import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC
import QtQuick.Controls.Styles 1.0
import SQL 1.0
Page {
     anchors.fill: parent
     header:ToolBar{
         anchors.left: parent.left
             anchors.right: parent.right
             height: 70
          background:Rectangle{
          color:"white"
          height:70
          width:parent.width
          }

          Row{
            y:20
          Image {
              id: managebus
              source: "icon/User Male.svg"
              width: 50
              height: 50
          }

          Text{
          text: "Manage Staff"
          font.bold: true
          font.pointSize: 11
          y:15

          }
          }

          Button {
              y:10
                text: "+ Add Staff"
                anchors.right: parent.right
                anchors.margins: 60

                id:managestaffbtn
                onClicked:
                {
                loader.source ="AddStaff.qml"
                }
                contentItem: Text {
                    text:managestaffbtn.text
                    font.pointSize: 13
                    opacity: enabled ? 1.0 : 0.3
                    color:managestaffbtn.down ? "#090707" : "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }


                background: Rectangle {
                    color: "#1f54e8"
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color:managestaffbtn.down ? "#17a81a" : "#3a64f9"
                    border.width: 1
                    radius: 6
                }
            }

     }
     Column{
         anchors.fill: parent

         Row{

             anchors.margins: 60

             y:100
               anchors.right: parent.right
               anchors.leftMargin: 10
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
                   onAccepted: {
                       db.searchStaff(text); // Call the search function
                   }

              }
        }


             Rectangle{
                 height: parent.height
                 color: "#d5d5cf"
                 width: parent.width
                 SqlQueryModel{
                             id: sqlmodel
                             query: "select * from staff"
                         }
                 Component{
                     id: columnComponent
                     QC.TableViewColumn {width: 100 }
                 }
                 QC.TableView {
                     id: tableView
                     width: parent.width
                     height: parent.height-55
                     anchors.margins: 20


                     resources:{
                                     var roleList = sqlmodel.userRoleNames
                                     var temp = []
                                     for(var i in roleList){
                                         var role  = roleList[i]
                                         temp.push(columnComponent.createObject(tableView, { "role": role, "title": role}))
                                     }
                                     return temp
                                 }
                                 model: sqlmodel

                                 Connections {
                                     target: db
                                     onStaffModelUpdated: {
                                         tableView.model = model; // Update the model in QML
                                     }
                                 }
                 }
     }

}
}