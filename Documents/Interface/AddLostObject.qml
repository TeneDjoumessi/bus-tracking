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
                text: "Post Form"
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
             imagePath = fileDialog.fileUrl.toString()
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
                text: qsTr("Lost Object picture")
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
                source: "icon/picture_80px.png"
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit // Maintain aspect ratio
                Layout.alignment: Qt.AlignHCenter
                MouseArea{
                anchors.fill: parent
                  onClicked: {
                      fileDialog.open()
                  }
                }
            }
        }
            Text { id: imageError; color: "red"; visible: false; text: "Please select an image."; }

            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                Text {
                    text: "Bus Matricule:"
                    font.pixelSize: 24
                    font.bold: true
                    Layout.alignment: Qt.AlignLeft
                }

                ComboBox {
                    id: matriculeComboBoxField
//                    Layout.fillWidth: true-400
                    model: db.getBusMatricule() // Use the method to populate the model
//                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 450
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: matriculeError; color: "red"; visible: false; }
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 5

            Text {
                text: "post date:"
                font.pixelSize: 24
                font.bold: true
            }

            TextField {
                id: postdate
                placeholderText: "Enter date"

                color: "black"
                validator: RegExpValidator {}
                background: Rectangle {
                    implicitWidth: 450
                    implicitHeight: 40
                    radius: 4
                }
            }
            Text { id: postDateError; color: "red"; visible: false; }
           }

            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                Text {
                    text: "Description:"
                    font.pixelSize: 24
                    font.bold: true
                    Layout.alignment: Qt.AlignLeft
                }
                Rectangle{
                    color: "white"
                    radius: 4
                    y: 30
                    height: 160
                    width: 490
                TextEdit {
                    id: descriptionTextEdit
                       anchors.fill: parent
                      text: ""
                      font.family: "Helvetica"
                      font.pointSize: 14
                      color: "black"
                      focus: false
                      wrapMode: TextEdit.Wrap
                  }
                 }
                Text { id: descriptionError; color: "red"; visible: false; }
            }


                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 30
                Button {
                    text: "Cancel"
                    id: cancelbtn
                    onClicked: {
                        loader.source ="LostObjectForm.qml"
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
                    text: "Submit"
                    id: submitbtn
                    onClicked: {
                        // Validation logic
                        matriculeError.visible = matriculeComboBoxField.currentIndex === -1;
                        // Check if the post date matches the regex
                        var postDateValid = /^[0-9]{4}-[0-9]{2}-[0-9]{2} (24|[01]?[0-9]):[0-5][0-9]$/.test(postdate.text); // Example regex for YYYY-MM-DD
                        postDateError.visible = postdate.text === "" || !postDateValid;
                        descriptionError.visible = descriptionTextEdit.text === "";

                        // Set specific error messages
                        matriculeError.text = matriculeError.visible ? Messages.getErrorMessage("postEmptyField") : "";
                        postDateError.text = postDateError.visible ? Messages.getErrorMessage("postInvalidDate") : "";
                        descriptionError.text = descriptionError.visible ? Messages.getErrorMessage("postInvalidDescription") : "";

                        // If no errors, proceed with submitting
                        if (!matriculeError.visible && !postDateError.visible && !descriptionError.visible) {
                        console.log("Bus Matricule:", matriculeComboBoxField.text)
                        console.log("Post Date:", postdate.text)
                        console.log("Description:", descriptionTextEdit.text)
                        console.log("Image Path:", imagePath)

                        // Call the C++ method to submit the data
                        var result = db.addLostObject(imagePath,matriculeComboBoxField.text, postdate.text, descriptionTextEdit.text);
                            if (result === "success") { // Adjust based on your actual return type
                             //displayMessage(Messages.getErrorMessage("postAddedSuccessfully"), "green");
                                dialog.message="Successfull"
                                dialog.open()
                            }
                        }
                    }
                    contentItem: Text {
                        text: submitbtn.text
                        font: submitbtn.font
                        opacity: enabled ? 1.0 : 0.3
                        color: submitbtn.down ? "#090707" : "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        color: "#1f54e8"
                        implicitWidth: 100
                        implicitHeight: 40
                        opacity: enabled ? 1 : 0.3
                        border.color: submitbtn.down ? "#1f54e8" : "#1f54e8"
                        border.width: 1
                        radius: 6
                    }
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
            anchors.top: submitbtn.bottom
            anchors.topMargin: 20
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
