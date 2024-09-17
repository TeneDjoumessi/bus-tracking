import QtQuick 2.5
import QtQuick.Controls 2.0
import QtLocation 5.12
import QtPositioning 5.12
Page {

    header: ToolBar {
        anchors.left: parent.left
            anchors.right: parent.right
            height: 70

            Row {
                y:20
                anchors.margins: 60
                  anchors.right: parent.right
                  anchors.leftMargin: 20
                  spacing: 10

                  Image {
                      y:5
                      id: searchicon
                      source: "icon/search_500px.png"
                      width: 35
                      height: 35
                  }


                TextField {
                    placeholderText: "Search"
                    implicitWidth: 400
                    color: "black"
                    font.pointSize: 13
                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 150
                        implicitHeight: 40
                        radius: 4
                        border.color: "black"
                }
               }
            }
    }
  Map{
      anchors.fill: parent
      id:map
      plugin: Plugin{
          name:"osm"

      }
      zoomLevel: 20
      copyrightsVisible: false

      MapQuickItem {
           id: marker
           anchorPoint.x: image.width/4
           anchorPoint.y: image.height
           coordinate:map.center
           sourceItem: Image {
               id: image
               source: "icon/location_100px.png"
           }
       }

  }
}
