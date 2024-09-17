import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import "Messages.js" as Messages

Page {
    anchors.fill: parent
    Dialog {
         id: dialog
         title: "Notification"
         visible: false
         standardButtons: Dialog.Ok
         anchors.centerIn: parent
         property string message: ""
         Text {
             anchors.centerIn: parent
             text: dialog.message
         }

     }
    header: ToolBar {
        background: Rectangle {
            color: "white"
            width: parent.width
        }
            Text {
                text: "Add Staff Form"
                font.bold: true
                font.pointSize: 11
                anchors.centerIn: parent
            }

    }

    property string imagePath: ""
    FileDialog {
         id: fileDialog
         title: "Please choose a file"
         folder: shortcuts.home
         onAccepted: {
             console.log("You chose: " + fileDialog.fileUrl)
             imagePath = fileDialog.fileUrl.toString() // Store the file URL as a string
             profilpicture.source=imagePath // Update the image source
             imageError.visible = false; // Hide error when a valid image is selected
         }
         onRejected: {
             console.log("Canceled")

         }

     }
    Rectangle {
        height: parent.height
        color: "#d1ce20"
        width: parent.width

        Column {
            spacing: 10
            anchors.centerIn: parent

            Text {
                id: name
                text: qsTr("Staff picture")
                font.bold: true
                verticalAlignment: Text.AlignBottom
                font.pointSize: 9
                Layout.alignment: Qt.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Rectangle{
                width: 100
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
            Image {
                id: profilpicture
                source: "icon/customer_60px.png"
                width: 100
                height: 100
//                fillMode: Image.PreserveAspectFit // Maintain aspect ratio
//                Layout.alignment: Qt.AlignHCenter
                MouseArea{
                anchors.fill: parent
                  onClicked: {
                      fileDialog.open()
                  }
                }
            }
            }
            Text { id: imageError; color: "red"; visible: false; text: "Please select an image."; }

            Row{
                spacing: 5
                Text {
                    text: "Firstname:"
                    font.pixelSize: 24
                    font.bold: true
                    Layout.alignment: Qt.AlignLeft
                }

                TextField {
                    id: firstnameField
                    placeholderText: "Firstname"

                    color: "black"
                    validator: RegExpValidator { regExp: /^[a-zA-Z\s0-9]+$/ }
                    background: Rectangle {
                        implicitHeight: 40
                        implicitWidth: 450
                        radius: 4
                    }
                }}
                Text { id: firstnameError; color: "red"; visible: false; }

                Row{
                    spacing: 5
                Text {
                    text: "Lastname:"
                    font.pixelSize: 24
                    font.bold: true
                    Layout.alignment: Qt.AlignLeft
                }

                TextField {
                    id: lastnameField
                    placeholderText: "Lastname"
                    implicitWidth: 450
                    color: "black"
                    validator: RegExpValidator { regExp: /^[a-zA-Z\s0-9]+$/ }
                    background: Rectangle {
                        implicitHeight: 40
                        radius: 4
                    }
                }}
                Text { id: lastnameError; color: "red"; visible: false; }

                Row{
                    spacing: 5
                Text {
                    text: "Address:"
                    font.pixelSize: 24
                    font.bold: true
                    Layout.alignment: Qt.AlignLeft
                }

                TextField {
                    id: addressField
                    placeholderText: "Enter Address"
                    implicitWidth: 450
                    color: "black"
                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitHeight: 40
                        radius: 4
                    }
                }}
                Text { id: addressError; color: "red"; visible: false; }

                Row{
                    spacing: 5
                Text {
                    text: "Phone number:"
                    font.pixelSize: 24
                    font.bold: true
                    Layout.alignment: Qt.AlignLeft
                }

                TextField {
                    id: phonenumberField
                    placeholderText: "Phone number"
                    implicitWidth: 450
                    color: "black"
                    validator: RegExpValidator {regExp: /^[0-9]{9}$/}
                    background: Rectangle {
                        implicitHeight: 40
                        radius: 4
                    }
                }}
                Text { id: phoneError; color: "red"; visible: false; }

                Row{
                    spacing: 5
                Text {
                    text: "Email:"
                    font.pixelSize: 24
                    font.bold: true
                    Layout.alignment: Qt.AlignLeft
                }

                TextField {
                    id: emailField
                    placeholderText: "Email"
                    implicitWidth: 450
                    color: "black"
                    validator: RegExpValidator {regExp: /^[a-z0-9]+@gmail\.com$/}
                    background: Rectangle {
                        implicitHeight: 40
                        radius: 4
                    }
                }}
                Text { id: emailError; color: "red"; visible: false; }

                Row{
                    spacing: 5

            Text {
                text: "Salary:"
                font.pixelSize: 24
                font.bold: true
            }

            TextField {
                id: salaryField
                placeholderText: "Enter amount"

                color: "black"
                validator: RegExpValidator {regExp: /^[0-9]+$/}
                background: Rectangle {
                    implicitWidth: 450
                    implicitHeight: 40
                    radius: 4
                }
            }}
            Text { id: salaryError; color: "red"; visible: false; }

            Row{
                spacing: 5

            Text {
                text: "Hire date:"
                font.pixelSize: 24
                font.bold: true
            }

            TextField {
                id: hiredateField
                placeholderText: "Enter date"

                color: "black"
                validator: RegExpValidator {}
                background: Rectangle {
                    implicitWidth: 450
                    implicitHeight: 40
                    radius: 4
                }
            }}
            Text { id: hiredateError; color: "red"; visible: false; }


                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 30
                Button {
                    text: "Cancel"
                    id: cancelbtn
                    onClicked: {
                        loader.source ="ManageStaff.qml"
                    }
                    contentItem: Text {
                        text: cancelbtn.text
                        font: cancelbtn.font
                        opacity: enabled ? 1.0 : 0.3
                        color: cancelbtn.down ? "#090707" : "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        color: "#e81f1f"
                        implicitWidth: 100
                        implicitHeight: 40
                        opacity: enabled ? 1 : 0.3
                        border.color: cancelbtn.down ? "#e81f1f" : "#e81f1f"
                        border.width: 1
                        radius: 6
                    }
                }

                Button {
                    text: "Add"
                    id: addbtn
                    onClicked: {

                       // Validation logic
                        imageError.visible = imagePath === "";
                        firstnameError.visible = firstnameField.text === "";
                        lastnameError.visible = lastnameField.text === "";
                        /*phoneError.visible = !phonenumberField.validator.validate(phonenumberField.text, 0).state === Validator.Acceptable;
                        emailError.visible = !emailField.validator.validate(emailField.text, 0).state === Validator.Acceptable;
                        salaryError.visible = !salaryField.validator.validate(salaryField.text, 0).state === Validator.Acceptable;*/
                        hiredateError.visible = hiredateField.text === "";

                      // Set specific error messages
                        firstnameError.text = firstnameError.visible ? Messages.getErrorMessage("emptyField") : "";
                        lastnameError.text = lastnameError.visible ? Messages.getErrorMessage("emptyField") : "";
                        phoneError.text = phoneError.visible ? Messages.getErrorMessage("invalidPhone") : "";
                        emailError.text = emailError.visible ? Messages.getErrorMessage("invalidEmail") : "";
                        salaryError.text = salaryError.visible ? Messages.getErrorMessage("invalidSalary") : "";
                        hiredateError.text = hiredateError.visible ? Messages.getErrorMessage("invalidHireDate") : "";

                        // If no errors, proceed with adding staff
                      if (!imageError.visible && !firstnameError.visible && !lastnameError.visible && !phoneError.visible && !emailError.visible && !salaryError.visible && !hiredateError.visible) {
                        console.log("Firstname:", firstnameField.text)
                        console.log("Lastname:", lastnameField.text)
                        console.log("Address:", addressField.text)
                        console.log("Tel:", phonenumberField.text)
                        console.log("Email:", emailField.text)
                        console.log("Salary:", salaryField.text)
                        console.log("Hire Date:", hiredateField.text)
                        console.log("Image Path:", imagePath) // Log the image path

                        // Call the C++ method to insert user data
                       var result = db.addStaff(firstnameField.text, lastnameField.text, imagePath, addressField.text,phonenumberField.text, emailField.text, "staFF123@" ,salaryField.text, hiredateField.text, 2, 0);
                          if (result === 'success') { // Adjust based on your actual return type
                           //displayMessage(Messages.getErrorMessage("staffAddedSuccessfully"), "green");
                              dialog.message="Successfull"
                              dialog.open()
                          } else {
                              dialog.message="Already Exists"
                              dialog.open()
                           //displayMessage(Messages.getErrorMessage("staffAlreadyExists"), "red");
                        }
                      }
                   }
                    contentItem: Text {
                        text: addbtn.text
                        font: addbtn.font
                        opacity: enabled ? 1.0 : 0.3
                        color: addbtn.down ? "#090707" : "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        color: "#1f54e8"
                        implicitWidth: 100
                        implicitHeight: 40
                        opacity: enabled ? 1 : 0.3
                        border.color: addbtn.down ? "#1f54e8" : "#1f54e8"
                        border.width: 1
                        radius: 6
                    }
                }
            }
                // Message Display
                Text {
                    id: statusMessage
                    color: "green"
                    visible: false
                    font.pixelSize: 18
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: addbtn.bottom
                    anchors.topMargin: 20
                }
        }

    }
    function displayMessage(message, color) {
        statusMessage.text = message;
        statusMessage.color = color;
        statusMessage.visible = true;

        // Hide the message after 5 seconds
        /*setTimeout(function() {
            statusMessage.visible = false;
        }, 5000);*/
    }
}
