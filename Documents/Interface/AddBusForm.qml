import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import "Messages.js" as Messages // Import the messages

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
        RowLayout{
            anchors.fill: parent
            anchors.leftMargin: 50
            spacing: 0
            Text {
                text: "Add Bus Form"
                font.bold: true
                font.pointSize: 11
            }
        }
        }

    Rectangle {
        height: parent.height
        color: "#d1ce20"
        width: parent.width

            GridLayout {
                anchors.fill: parent
                anchors.margins: 50
                columns: 2
                rows: 4
                columnSpacing: 20
                rowSpacing: 20

                ColumnLayout {
                    spacing: 10
                Text {
                    text: "Driver Unique Id:"
                    font.pixelSize: 24
                    font.bold: true
                }

                ComboBox {
                    id: driveridComboBox
                    Layout.fillWidth: true
                    model: db.getDriverId()
//                    validator: RegExpValidator {}
                    /*onModelChanged: {
                      for (var i = 0; i < model.length; ++i) {
                        driveridComboBox.addItem(model[i].toString());
                      }
                     }*/
                    background: Rectangle {
                        implicitWidth: 30
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: driverIdError; color: "red"; visible: false; }
               }

                ColumnLayout {
                    spacing: 10

                Text {
                    text: "Bus name:"
                    font.pixelSize: 24
                    font.bold: true
                }

                TextField {
                    id: busnameField
                    placeholderText: "Enter Bus name"
                    Layout.fillWidth: true
                    color: "black"
                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 150
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: busNameError; color: "red"; visible: false; }
               }

                ColumnLayout {
                    spacing: 10

                Text {
                    text: "Bus color:"
                    font.pixelSize: 24
                    font.bold: true
                }

                TextField {
                    id: buscolorField
                    placeholderText: "Enter Bus color"
                    Layout.fillWidth: true
                    color: "black"
                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: busColorError; color: "red"; visible: false; }
               }

                ColumnLayout {
                    spacing: 10

                Text {
                    text: "Sitting Place:"
                    font.pixelSize: 24
                    font.bold: true
                }

                TextField {
                    id: sittinplace
                    placeholderText: "Enter sitting number"
                    Layout.fillWidth: true
                    color: "black"
                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 150
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: sittingPlaceError; color: "red"; visible: false; }
               }


                ColumnLayout {
                    spacing: 10

                Text {
                    text: "Matricule:"
                    font.pixelSize: 24
                    font.bold: true
                }

                TextField {
                    id: matriculeField
                    placeholderText: "Enter Bus matricule"
                    Layout.fillWidth: true
                    color: "black"
                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 150
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: matriculeError; color: "red"; visible: false; }
              }

                ColumnLayout {
                    spacing: 10

                Text {
                    text: "Fuel Type:"
                    font.pixelSize: 24
                    font.bold: true
                }

                TextField {
                    id: fueltype
                    placeholderText: "Enter fuel type"
                    Layout.fillWidth: true
                    color: "black"
                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 150
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: fuelTypeError; color: "red"; visible: false; }
               }


            Item { implicitHeight: 5 } // Reduced Spacer
            RowLayout {
                spacing: 30
//                anchors.horizontalCenter: parent.horizontalCenter-100
                Button {
                    text: "Cancel"
                    id: cancelbtn
                    onClicked: {
                        loader.source ="ManageBus.qml"
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
                      busNameError.visible = busnameField.text === "";
                      busColorError.visible = buscolorField.text === "";
                     // sittingPlaceError.visible = !sittinplace.validator.validate(sittinplace.text, 0).state === Validator.Acceptable;
                      matriculeError.visible = matriculeField.text === "";
                      fuelTypeError.visible = fueltype.text === "";

                      // Set specific error messages
                      busNameError.text = busNameError.visible ? Messages.getErrorMessage("busEmptyField") : "";
                      busColorError.text = busColorError.visible ? Messages.getErrorMessage("busEmptyField") : "";
                      sittingPlaceError.text = sittingPlaceError.visible ? Messages.getErrorMessage("busInvalidSittingPlace") : "";
                      matriculeError.text = matriculeError.visible ? Messages.getErrorMessage("busInvalidMatricule") : "";
                      fuelTypeError.text = fuelTypeError.visible ? Messages.getErrorMessage("busInvalidFuelType") : "";

                        // If no errors, proceed with adding bus
                      if (!busNameError.visible && !busColorError.visible && !sittingPlaceError.visible && !matriculeError.visible && !fuelTypeError.visible) {
                      console.log("Driver Id:", driveridComboBox.currentText)
                      console.log("Bus Name:", busnameField.text)
                      console.log("Bus Color:", buscolorField.text)
                      console.log("Sitting Place:", sittinplace.text)
                      console.log("Matricule:", matriculeField.text)
                      console.log("Fuel Type:", fueltype.text)

                      // Call the C++ method to add the bus
                     var result = db.addBus(driveridComboBox.currentText,driveridField.text, busnameField.text, buscolorField.text, sittinplace.text, matriculeField.text, fueltype.text);
                          if (result === 'success') { // Adjust based on your actual return type
                           displayMessage(Messages.getErrorMessage("busAddedSuccessfully"), "green");
                              dialog.message="Successfull"
                              dialog.open()
                          } else {
                              dialog.message="Already Exists"
                              dialog.open()
                           //displayMessage(Messages.getErrorMessage(""), "red");
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
    function displayMessage(message, color) {
        statusMessage.text = message;
        statusMessage.color = color;
        statusMessage.visible = true;

        // Hide the message after 5 seconds
        setTimeout(function() {
            statusMessage.visible = false;
        }, 5000);
    }
}
