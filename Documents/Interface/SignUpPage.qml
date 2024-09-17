import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Page {
id:signupPage

    Rectangle{
          anchors.centerIn: parent
          width:  400
          height: 550
          color: "#f19c4c"
          radius: 20
          Column{
            anchors.centerIn: parent
                   spacing: 20

                   Text {
                       text: "SignUp"
                       font.pixelSize: 24
                       font.bold: true
                       horizontalAlignment: Text.AlignHCenter
                       anchors.horizontalCenter:parent.horizontalCenter
                       Layout.alignment: Qt.AlignHCenter
                   }

                   TextField {
                       id: firstnameField
                       placeholderText: "Firstname"
                       Layout.fillWidth: true
                       color: "black"
                       x:5
                      validator: RegExpValidator { regExp: /^[a-zA-Z]+$/ }
                       background: Rectangle {
                           implicitWidth: 250
                           implicitHeight: 45
                           radius: 4
                       }
                   }

                   TextField {
                       id: lastnameField
                       placeholderText: "Lastname"
                       Layout.fillWidth: true
                       color: "black"
                       x:5
                        validator: RegExpValidator { regExp: /^[a-zA-Z0-9]+$/ }
                       background: Rectangle {
                           implicitWidth: 250
                           implicitHeight: 45
                           radius: 4
                       }
                   }

                   TextField {
                       id: phonenumberField
                       placeholderText: "Tel +237 "
                       Layout.fillWidth: true
                       color: "black"
                       x:5
                        validator: RegExpValidator { regExp: /^[0-9]{9}$/ }
                       background: Rectangle {
                           implicitWidth: 250
                           implicitHeight: 45
                           radius: 4
                       }
                   }

                   TextField {
                       id: emailField
                       placeholderText: "Email"
                       Layout.fillWidth: true
                       color: "black"
                       x:5
                       validator: RegExpValidator {regExp: /^[a-z0-9]+@gmail\.com$/}
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
                        validator: RegExpValidator { regExp: /^[a-zA-Z0-9]+[@$!%*?&]$/ }
                       background: Rectangle {
                           implicitWidth: 250
                           implicitHeight: 45
                           radius: 4
                       }
                     }

                   RowLayout {
                       Layout.alignment: Qt.AlignHCenter
                       spacing: 30
                       x: 30
                       Button {
                           text: "back"
                           id: backbtn
                           onClicked: {
                               signupPage.parent.back()
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
                       text: "SignUp"
                       id: control
                       onClicked: {
                           console.log("Firstname:", firstnameField.text)
                           console.log("Lastname:", lastnameField.text)
                           console.log("Tel:", phonenumberField.text)
                           console.log("Email:", emailField.text)
                           console.log("Password:", passwordField.text)

                           // Call the C++ method to insert user data
                           db.addStaff(14,firstnameField.text, lastnameField.text, emailField.text, parseInt(phonenumberField.text), "user@example.com", 2000000, "2024-08-28");
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
        }
    }

}
