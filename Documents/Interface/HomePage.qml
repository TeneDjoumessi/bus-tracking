import QtQuick 2.5
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Page {
   anchors.fill: parent
   id:homePage
   header: ToolBar
   {
    background:Rectangle{
    color:"white"
    height:50
    width:parent.width


    }

        Image {
               id: applogos
               x:parent.width/4 -70
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

   Button {
         text: "Login"
         anchors.right: parent.right
         anchors.margins: 20
         y:10
         id:loginbtn
         onClicked:
         {
         homePage.parent.login()
         }
         contentItem: Text {
             text:loginbtn.text
             font:loginbtn.font
             opacity: enabled ? 1.0 : 0.3
             color:loginbtn.down ? "#090707" : "#ffffff"
             horizontalAlignment: Text.AlignHCenter
             verticalAlignment: Text.AlignVCenter
             elide: Text.ElideRight
         }


         background: Rectangle {
             color: "#1f54e8"
             implicitWidth: 100
             implicitHeight: 40
             opacity: enabled ? 1 : 0.3
             border.color:loginbtn.down ? "#17a81a" : "#3a64f9"
             border.width: 1
             radius: 6
         }
     }

   Button {
         text: "Sign up"
         anchors.right: loginbtn.left
          y:10
         anchors.margins: 20
         id:signupbtn
         onClicked:
         {
         homePage.parent.signup()
         }
         contentItem: Text {
             text:signupbtn.text
             font:signupbtn.font
             opacity: enabled ? 1.0 : 0.3
             color:signupbtn.down ? "#090707" : "#ffffff"
             horizontalAlignment: Text.AlignHCenter
             verticalAlignment: Text.AlignVCenter
             elide: Text.ElideRight
         }

         background: Rectangle {
             color: "#1f54e8"
             implicitWidth: 100
             implicitHeight: 40
             opacity: enabled ? 1 : 0.3
             border.color:signupbtn.down ? "#17a81a" : "#3a64f9"
             border.width: 1
             radius: 6
         }
     }
   }
Row{
 anchors.fill: parent
 Rectangle{
     id:rectone
     width: parent.width/2
     height: parent.height
     color:"#F9E2AF"

     Column{
         anchors.fill: parent
         spacing: 10

Rectangle
{
    height: 100
    color: "transparent"
    width: 10
}

Text {
    id: name
    text: qsTr("Track your bus easily with TrackMe.")
    font.family: "Arial Black"
    width: 300
    font.bold: true
    horizontalAlignment: Text.AlignHCenter
    anchors.horizontalCenter:parent.horizontalCenter
    wrapMode: Text.WordWrap
    font.pointSize: 23

   // anchors.verticalCenter: parent.verticalCenter
}

Text {
    id: name2
    text: qsTr("An application that will reduce the frustration, Stress, ...  of paassengers")
    font.pointSize: 18
    width: 400
    wrapMode: Text.WordWrap
    horizontalAlignment: Text.AlignHCenter
     anchors.horizontalCenter:parent.horizontalCenter

}
Rectangle
{
    height: 50
    color: "transparent"
    width: 10
}
Button {
    text: "Login"
    id:control
    onClicked:
    {
    homePage.parent.login()
    }
    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.down ? "#090707" : "#ffffff"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        color: "#1f54e8"
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        border.color: control.down ? "#17a81a" : "#3a64f9"
        border.width: 1
        radius: 6
    }
      anchors.horizontalCenter:parent.horizontalCenter
}
Row{
      anchors.horizontalCenter:parent.horizontalCenter
Text {
    id: name3
    text: qsTr("Already haveing an account? ")
    font.pointSize: 10
}
Text {
    color: "#12a1a6"

    text: qsTr("Sign up")
    font.underline: true
    font.pointSize: 10
}
}

Rectangle
{
    height: 100
    color: "transparent"
    width: 10
}

Column{
    anchors.horizontalCenter:parent.horizontalCenter
    Text {
        color: "#000000"

        text: qsTr("With TrackMe Enjoy the app Easily")
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 12
    }
    Text {
        color: "#000000"

        text: qsTr("with less Stress and with Real-Time Tracking!!")
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 12
    }
}

   }
 }

 Rectangle{
     color: "white"
     width: parent.width/2
     height: parent.height
     Image {

         source: "images/Live-Bus-Tracking-Image.jpg"
         width:parent.width
         height:parent.height-150
         anchors.verticalCenter:parent.verticalCenter
     }

    }
}
}
