import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets

ShellRoot {
  Variants {
    model: Quickshell.screens
    delegate: PanelWindow {
      id: window
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
      WlrLayershell.namespace: "launcher"

      anchors.top: true
      anchors.bottom: true
      anchors.left: true
      anchors.right: true

      color: "transparent"

      // Filtered app list via ScriptModel
      property string searchQuery: searchBox.text.toLowerCase().trim()

      ScriptModel {
        id: filteredModel
        values: {
          const q = window.searchQuery;
          const apps = DesktopEntries.applications.values;
          
          if (q === "") return apps;

          return apps.filter(app => {
            const nameMatch    = app.name.toLowerCase().includes(q);
            const genericMatch = app.genericName && app.genericName.toLowerCase().includes(q);
            const descMatch    = app.description  && app.description.toLowerCase().includes(q);
            return nameMatch || genericMatch || descMatch;
          }).sort((a, b) => {
            const aStarts = a.name.toLowerCase().startsWith(q) ? 0 : 1;
            const bStarts = b.name.toLowerCase().startsWith(q) ? 0 : 1;
            return aStarts - bStarts;
          });
        }
      }

      // Reset selection whenever filtered results change
      onSearchQueryChanged: appList.currentIndex = 0

      // Keyboard: Escape closes
      Shortcut {
        sequences: ["Escape"]
        onActivated: Qt.quit()
      }

      // Background dim
      Rectangle {
        anchors.fill: parent
        color: "#88000000"
        opacity: 0
        Component.onCompleted: opacity = 1
        Behavior on opacity { NumberAnimation { duration: 180 } }

        MouseArea {
          anchors.fill: parent
          onClicked: Qt.quit()
        }
      }

      // Launcher box
      Rectangle {
        id: container

        // Dynamic height: search bar + up to 6 results + padding
        readonly property int itemHeight: 56
        readonly property int itemSpacing: 4
        readonly property int maxVisible: 6
        readonly property int visibleCount: Math.min(appList.count, maxVisible)
        readonly property int listHeight: visibleCount > 0
          ? visibleCount * itemHeight + (visibleCount - 1) * itemSpacing
          : 0
        readonly property int headerHeight: 54
        readonly property int contentMargin: 20
        readonly property int footerHeight: appList.count === 0 ? emptyState.height + contentMargin : 0

        anchors.centerIn: parent
        width: 660
        height: contentMargin + headerHeight
                + (listHeight > 0 ? contentMargin + listHeight : 0)
                + footerHeight
                + contentMargin

        Behavior on height { NumberAnimation { duration: 160; easing.type: Easing.OutQuad } }

        color: "#@base00@"
        radius: 18
        border.color: "#@base02@"
        border.width: 1

        // Entry animation
        scale: 0.93
        opacity: 0
        Component.onCompleted: { scale = 1.0; opacity = 1.0 }
        Behavior on scale   { NumberAnimation { duration: 220; easing.type: Easing.OutBack } }
        Behavior on opacity { NumberAnimation { duration: 180 } }

        // Block clicks from falling through to the dim layer
        MouseArea { anchors.fill: parent }

        Column {
          anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            topMargin: container.contentMargin
            leftMargin: container.contentMargin
            rightMargin: container.contentMargin
          }
          spacing: container.contentMargin

          // Search bar
          Rectangle {
            width: parent.width
            height: container.headerHeight
            color: "#@base01@"
            radius: 12
            border.color: searchBox.activeFocus ? "#@base0D@" : "transparent"
            border.width: 2
            Behavior on border.color { ColorAnimation { duration: 120 } }

            Item {
              anchors.fill: parent
              anchors.leftMargin: 16
              anchors.rightMargin: 16

              // Search icon
              Text {
                id: searchIcon
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: "󰍉"
                font.family: "@monoFont@"
                font.pixelSize: 20
                color: searchBox.activeFocus ? "#@base0D@" : "#@base04@"
                Behavior on color { ColorAnimation { duration: 120 } }
              }

              TextField {
                id: searchBox
                anchors {
                  left: searchIcon.right
                  leftMargin: 12
                  right: clearBtn.left
                  rightMargin: 8
                  verticalCenter: parent.verticalCenter
                }
                height: parent.height
                placeholderText: "Search applications…"
                placeholderTextColor: "#@base03@"
                focus: true

                font.family: "@sansFont@"
                font.pixelSize: 17
                color: "#@base05@"
                background: null
                selectionColor: "#@base02@"
                selectedTextColor: "#@base05@"

                Keys.onPressed: (event) => {
                  if (event.key === Qt.Key_Escape) {
                    Qt.quit()
                    event.accepted = true
                  } else if (event.key === Qt.Key_Down || event.key === Qt.Key_Tab) {
                    appList.currentIndex = Math.min(appList.currentIndex + 1, appList.count - 1)
                    event.accepted = true
                  } else if (event.key === Qt.Key_Up || (event.key === Qt.Key_Tab && (event.modifiers & Qt.ShiftModifier))) {
                    appList.currentIndex = Math.max(appList.currentIndex - 1, 0)
                    event.accepted = true
                  } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    launchCurrent()
                    event.accepted = true
                  }
                }
              }

              // Clear button
              Text {
                id: clearBtn
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: "󰅖"
                font.family: "@monoFont@"
                font.pixelSize: 16
                color: "#@base03@"
                visible: searchBox.text.length > 0
                opacity: visible ? 1 : 0
                Behavior on opacity { NumberAnimation { duration: 100 } }

                MouseArea {
                  anchors.fill: parent
                  cursorShape: Qt.PointingHandCursor
                  onClicked: searchBox.text = ""
                }
              }
            }
          }

          // Results list
          ListView {
            id: appList
            width: parent.width
            height: container.listHeight
            clip: true
            model: filteredModel
            spacing: container.itemSpacing
            visible: count > 0
            currentIndex: 0

            // Smooth animated highlight
            highlightMoveDuration: 140
            highlightMoveVelocity: -1

            highlight: Rectangle {
              radius: 10
              color: "#@base02@"
              width: appList.width
              Behavior on y { NumberAnimation { duration: 140; easing.type: Easing.OutQuad } }
            }
            highlightFollowsCurrentItem: false

            delegate: Item {
              id: delegateRoot
              width: appList.width
              height: container.itemHeight

              readonly property var app: modelData
              readonly property bool isCurrent: ListView.isCurrentItem

              // Sync highlight position
              onIsCurrentChanged: if (isCurrent) appList.highlight.y = y

              function launch() {
                app.execute()
                Qt.quit()
              }

              Row {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                spacing: 14

                // App icon with fallback
                Item {
                  width: 36
                  height: 36
                  anchors.verticalCenter: parent.verticalCenter

                  IconImage {
                    id: appIcon
                    anchors.fill: parent
                    source: app.icon
                    visible: status === Image.Ready
                  }

                  // Fallback: first letter of app name
                  Rectangle {
                    anchors.fill: parent
                    radius: 8
                    color: "#@base02@"
                    visible: appIcon.status !== Image.Ready

                    Text {
                      anchors.centerIn: parent
                      text: app.name.charAt(0).toUpperCase()
                      font.family: "@sansFont@"
                      font.pixelSize: 16
                      font.weight: Font.Bold
                      color: "#@base0D@"
                    }
                  }
                }

                // Name + subtitle
                Column {
                  anchors.verticalCenter: parent.verticalCenter
                  spacing: 2

                  Text {
                    text: app.name
                    color: delegateRoot.isCurrent ? "#@base0D@" : "#@base05@"
                    font.family: "@sansFont@"
                    font.pixelSize: 15
                    font.weight: Font.Medium
                    Behavior on color { ColorAnimation { duration: 100 } }
                  }

                  Text {
                    text: app.description || app.genericName || ""
                    color: delegateRoot.isCurrent ? "#@base04@" : "#@base03@"
                    font.family: "@sansFont@"
                    font.pixelSize: 11
                    visible: text !== ""
                    elide: Text.ElideRight
                    width: container.width - 80
                    Behavior on color { ColorAnimation { duration: 100 } }
                  }
                }
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: appList.currentIndex = index
                onClicked: launch()
              }
            }
          }

          // Empty state
          Item {
            id: emptyState
            width: parent.width
            height: 60
            visible: appList.count === 0 && searchBox.text.length > 0
            opacity: visible ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 120 } }

            Column {
              anchors.centerIn: parent
              spacing: 4

              Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: 'No results for "' + searchBox.text + '"'
                color: "#@base04@"
                font.family: "@sansFont@"
                font.pixelSize: 14
              }
            }
          }
        } // Column

        // Result count badge
        Text {
          anchors {
            bottom: parent.bottom
            right: parent.right
            margins: 12
          }
          visible: appList.count > 0 && searchBox.text.length > 0
          text: appList.count + " result" + (appList.count === 1 ? "" : "s")
          color: "#@base03@"
          font.family: "@sansFont@"
          font.pixelSize: 11
        }
      } // container

      // Global launch helper
      function launchCurrent() {
        if (appList.count > 0 && appList.currentIndex >= 0) {
          filteredModel.values[appList.currentIndex].execute()
          Qt.quit()
        }
      }
    } 
  } 
} 
