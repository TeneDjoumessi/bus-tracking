import QtQuick 2.5
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Page {
//   anchors.fill: parent
   id:homePage
   Component.onCompleted: dialog.open()
   Dialog {
        id: dialog
        title: "Notification"
        visible: false
        standardButtons: Dialog.Ok
        anchors.centerIn: parent
        Text {
            anchors.centerIn: parent
            text: qsTr("Welcome")
        }

    }
Row{
 anchors.fill: parent
 Rectangle {
     id: rectone
     width: parent.width / 5
     height: parent.height
     color: "white"

     Rectangle {
         color: "#cac1c1"
         width: parent.width
         height: parent.height / 6
         id:rect

         Image {
             id: applogos
             x: parent.width / 2 - 70
             source: "images/TrackMe logo1.jpg"
             height: 100
             width: 100
             layer {
                 enabled: true
                 effect: OpacityMask {
                     maskSource: Item {
                         width: applogos.width
                         height: applogos.height
                         Rectangle {
                             anchors.centerIn: parent
                             width: applogos.width
                             height: applogos.height
                             radius: 50 // Définir le rayon de la bordure ici
                         }
                     }
                 }
             }
         }
     }

     Column {
            y: 140

         Row {
             x: 30
             spacing: 10
             Image {
                 id: managebus
                 source: "icon/Bus_128px.png"
                 height: 30
                 width: 30
             }
             Text {
                 color: "#12a1a6"
                 text: qsTr("Manage Buses")
                 font.underline: false
                 font.pointSize: 10
                 y: 4
                 MouseArea{
                     anchors.fill: parent
                     onClicked: {
                         loader.source ="ManageBus.qml"
                     }
                 }
             }
         }

         Row {
             x: 30
             spacing: 10

             Image {
                 id: managedrivers
                 source: "icon/driver_48px.png"
                 height: 30
                 width: 30
             }
             Text {
                 color: "#12a1a6"
                 text: qsTr("Manage Drivers")
                 font.underline: false
                 font.pointSize: 10
                 y: 4
                 MouseArea{
                     anchors.fill: parent
                     onClicked: {
                         loader.source ="ManageDrivers.qml"
                     }
                 }
                 Loader {
                        id: loaderdriver
                        anchors.fill: parent
                    }
             }
         }

         Row {
             x: 30
             spacing: 10
             visible: db.isAdmin() // Show if the user is admin
             Image {
                 id: managestaff
                 source: "icon/Staff_128px.png"
                 height: 30
                 width: 30
             }
             Text {
                 color: "#12a1a6"
                 text: qsTr("Manage Staff")
                 font.underline: false
                 font.pointSize: 10
                 y: 4
                 MouseArea{
                     anchors.fill: parent
                     onClicked: {
                         loader.source ="ManageStaff.qml"
                     }
                 }
                 Loader {
                        id: loaderstaff
                        anchors.fill: parent
                    }
             }
         }

         Row {
             x: 30
             spacing: 10
             Image {
                 id: setrout
                 source: "icon/location_100px.png"
                 height: 30
                 width: 30
             }
             Text {
                 color: "#12a1a6"
                 text: qsTr("SetRout")
                 font.underline: false
                 font.pointSize: 10
                 y: 4
                 MouseArea{
                     anchors.fill: parent
                     onClicked: {
                        loader.source ="SetRout.qml"
                     }
                 }
                 Loader {
                        id: loaderrout
                        anchors.fill: parent
                    }
             }
         }

         Row {
             x: 30
             spacing: 10
             Image {
                 id: trackbus
                 source: "icon/track_order_48px.png"
                 height: 30
                 width: 30
             }
             Text {
                 color: "#12a1a6"
                 text: qsTr("Track Bus")
                 font.underline: false
                 font.pointSize: 10
                 y: 4
                 MouseArea{
                     anchors.fill: parent
                     onClicked: {
                     loader.source ="MapPage.qml"
                     }
                 }
                 Loader {
                        id: loadertrack
                        anchors.fill: parent
                    }
             }
         }

         Row {
             x: 30
             spacing: 10
             Image {
                 id: lostobject
                 source: "icon/Pick Up_128px.png"
                 height: 30
                 width: 30
             }
             Text {
                 color: "#12a1a6"
                 text: qsTr("Lost Object")
                 font.underline: false
                 font.pointSize: 10
                 y: 4
                 MouseArea{
                     anchors.fill: parent
                     onClicked: {
                     loader.source ="LostObjectForm.qml"
                     }
                 }
             }
         }

         Row {
             x: 30
             spacing: 10
             Image {
                 id: logout
                 source: "icon/logout_52px.png"
                 height: 30
                 width: 30
             }
             Text {
                 color: "#12a1a6"
                 text: qsTr("Logout")
                 font.underline: false
                 font.pointSize: 10
                 y: 4
                 MouseArea{
                     anchors.fill: parent
                     onClicked: {
                     homePage.parent.logout()
                     }
                 }
             }
         }
     }
 }

 Rectangle{
     color: "#805555"
     width: parent.width
     height: parent.height
          Loader {
                  id:loader
                  source :"ManageBus.qml"
                  height: parent.height
                  width: parent.width-rectone.width


                }


    }

}

}
