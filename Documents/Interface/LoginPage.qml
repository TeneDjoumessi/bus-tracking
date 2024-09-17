import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "Messages.js" as Messages
Page {
id:loginPage
    Rectangle{
          anchors.centerIn: parent
          width:  400
          height: 300
          color: "#f19c4c"
          radius: 20
          Column{
            anchors.centerIn: parent
                   spacing: 20


                   Text {
                       text: "Login"
                       font.pixelSize: 24
                       font.bold: true
                       horizontalAlignment: Text.AlignHCenter
                       anchors.horizontalCenter:parent.horizontalCenter
                       Layout.alignment: Qt.AlignHCenter
                   }

                   TextField {
                       id: telField
                       placeholderText: "Tel number:"
                       Layout.fillWidth: true
                       color: "black"
                       x:5
                       validator: RegExpValidator {regExp: /^[0-9]{9}$/}
                       background: Rectangle {
                           implicitWidth: 250
                           implicitHeight: 45
                           radius: 4
                       }
                   }

                   TextField {
                       id: passwordField
                       placeholderText: "Password"
                       echoMode: TextInput.Password
                       Layout.fillWidth: true
                       color: "black"
                       x:5
                       validator: RegExpValidator{}
                       background: Rectangle {
                           implicitWidth: 250
                           implicitHeight: 45
                           radius: 4
                       }
                     }

                   RowLayout {
                       Layout.alignment: Qt.AlignHCenter
                       spacing: 30
                       x: 25
                       Button {
                           text: "back"
                           id: backbtn
                           onClicked: {
                               loginPage.parent.back()
                           }
                           contentItem: Text {
                               text: backbtn.text
                               font: backbtn.font
                               opacity: enabled ? 1.0 : 0.3
                               color: backbtn.down ? "#090707" : "#ffffff"
                               horizontalAlignment: Text.AlignHCenter
                               verticalAlignment: Text.AlignVCenter
                               elide: Text.ElideRight
                           }
                           background: Rectangle {
                               color: "#e81f1f"
                               implicitWidth: 100
                               implicitHeight: 40
                               opacity: enabled ? 1 : 0.3
                               border.color: backbtn.down ? "#e81f1f" : "#e81f1f"
                               border.width: 1
                               radius: 6
                           }
                       }
                   Button {
                       text: "Login"
                       id: control
                       onClicked: {
                           console.log("Tel number:", telField.text)
                           console.log("Password:", passwordField.text)

                           if(telField.text =="")
                           {
                             errorText.text = Messages.getErrorMessage("emptyField")
                              return;
                           }

                           var code = db.checkstaff(telField.text,passwordField.text)
                           if(code === 500)
                           {
                                loginPage.parent.openApp()
                               telField.text=""
                               passwordField.text=""
                           }
                       }
                       Layout.fillWidth: true

                       contentItem: Text {
                           color:  "#f9f6f6"
                           text: control.text
                           font: control.font
                           opacity: enabled ? 1.0 : 0.3
                           horizontalAlignment: Text.AlignHCenter
                           verticalAlignment: Text.AlignVCenter
                           elide: Text.ElideRight
                       }

                       background: Rectangle {
                           color: "#1f54e8"
                           implicitWidth: 90
                           implicitHeight: 40
                           opacity: enabled ? 1 : 0.3
                           border.color: "#f9f6f6"
                           border.width: 1
                           radius: 6
                       }
//                         anchors.horizontalCenter:parent.horizontalCenter
                   }
                 }
                   Text {
                       id: errorText

                   }
        }
    }

}
