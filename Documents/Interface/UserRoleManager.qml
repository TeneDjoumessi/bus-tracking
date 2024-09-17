import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.0 as QC
import QtQuick.Controls.Styles 1.0
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
              source: "icon/driver_48px.png"
              width: 50
              height: 50
          }

          Text{
          text: "Manage Drivers"
          font.bold: true
          font.pointSize: 11
          y:15



          }

            }
            Button {
                y:10
                  text: "+ Add Driver"
                  anchors.right: parent.right
                  anchors.margins: 60

                  id:managedriverbtn
                  onClicked:
                  {
                  loader.source ="AddDriver.qml"
                  }
                  contentItem: Text {
                      text:managedriverbtn.text
                      font.pointSize: 13
                      opacity: enabled ? 1.0 : 0.3
                      color:managedriverbtn.down ? "#090707" : "#ffffff"
                      horizontalAlignment: Text.AlignHCenter
                      verticalAlignment: Text.AlignVCenter
                      elide: Text.ElideRight
                  }


                  background: Rectangle {
                      color: "#1f54e8"
                      implicitWidth: 100
                      implicitHeight: 40
                      opacity: enabled ? 1 : 0.3
                      border.color:managedriverbtn.down ? "#17a81a" : "#3a64f9"
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
            anchors.leftMargin: 60
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
         Rectangle{
             height: parent.height
             color: "#d5d5cf"
             width: parent.width

             QC.TableView {
                 id: tableView
                 width: parent.width
                 height: parent.height-55
                 anchors.margins: 20
                 model: 50



                 QC.TableViewColumn {
                     role: "driverid"
                     title: "Driver ID"
                     width: tableView.width * 0.1
                 }
                 QC.TableViewColumn {
                     role: "firstName"
                     title: "FirstName"
                     width: tableView.width * 0.3
                 }
                 QC.TableViewColumn {
                     role: "lastname"
                     title: "LastName"
                     width: tableView.width * 0.3
                 }
                 QC.TableViewColumn {
                     role: "busname"
                     title: "Bus Name"
                     width: tableView.width * 0.3
                 }
                 QC.TableViewColumn {
                     role: "phonenumber"
                     title: "Phone number"
                     width: tableView.width * 0.2
                 }
                 QC.TableViewColumn {
                     role: "address"
                     title: "Address"
                     width: tableView.width * 0.4
                 }
                 QC.TableViewColumn {
                     role: "email"
                     title: "Email"
                     width: tableView.width * 0.3
                 }
                 QC.TableViewColumn {
                     role: "dateofhire"
                     title: "Date of Hire"
                     width: tableView.width * 0.3
                 }
                 QC.TableViewColumn {
                     role: "status"
                     title: "Status"
                     width: tableView.width * 0.3

                     delegate: Row {
                     spacing: 10
                     height: 40
                    CheckBox {

                    checked: model.status === "Active"
                    onCheckedChanged: {
                   // Handle block/unblock logic here
                      }
                    }
                    Image {
                       source: "icon/Edit.svg"
                       width: 20
                        height: 20
                     MouseArea {
                     anchors.fill: parent
                     onClicked: {
                     // Handle edit logic here
                        }
                    }
                  }
                    Image {
                      source: "icon/trash_64px.png"
                      width: 20
                      height: 20
                      MouseArea {
                      anchors.fill: parent
                      onClicked: {
                     // Handle delete logic here
                      }
                     }
                    }
                 }
                 }
             }
         }
     }


}
