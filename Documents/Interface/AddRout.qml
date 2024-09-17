import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import "Messages.js" as Messages

Page {
    anchors.fill: parent
    header: ToolBar {
        background: Rectangle {
            color: "white"
            width: parent.width
        }

            Text {
                text: "Add Route Form"
                font.bold: true
                font.pointSize: 11
                anchors.centerIn: parent
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
            rows: 5
            columnSpacing: 50
            rowSpacing: 20



            ColumnLayout {
                spacing: 10

                Text {
                    text: "Route Id:"
                    font.pixelSize: 24
                    font.bold: true
                }

                TextField {
                    id: routeidField
                    placeholderText: "Route Id"
                    Layout.fillWidth: true
                    color: "black"
                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 150
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: routeIdError; color: "red"; visible: false; }
            }

            ColumnLayout {
                spacing: 10

                Text {
                    text: "Bus:"
                    font.pixelSize: 24
                    font.bold: true
                }

                ComboBox {
                    id: busComboBox
                    Layout.fillWidth: true
                    model: db.getBusNames() // Use the method to populate the model
//                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 150
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: busError; color: "red"; visible: false; }
            }

            ColumnLayout {
                spacing: 10

                Text {
                    text: "Source:"
                    font.pixelSize: 24
                    font.bold: true
                }

                TextField {
                    id: addLocation
                    placeholderText: "Add Location"
                    Layout.fillWidth: true
                    color: "black"
                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 250
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: locationError; color: "red"; visible: false; }
            }

            ColumnLayout {
                spacing: 10

                Text {
                    text: "Destination:"
                    font.pixelSize: 24
                    font.bold: true
                }

                TextField {
                    id: addDestination
                    placeholderText: "Add Destination"
                    Layout.fillWidth: true
                    color: "black"
                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 250
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: destinationError; color: "red"; visible: false; }
            }

            ColumnLayout {
                spacing: 10

                Text {
                    text: "Stop name:"
                    font.pixelSize: 24
                    font.bold: true
                }

                TextField {
                    id: stopName
                    placeholderText: "Stop name"
                    Layout.fillWidth: true
                    color: "black"
                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 250
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: stopNameError; color: "red"; visible: false; }
            }

            ColumnLayout {
                spacing: 10

                Text {
                    text: "Stop Long.Lat:"
                    font.pixelSize: 24
                    font.bold: true
                }

                TextField {
                    id: longlat
                    placeholderText: "Enter name-coordinate"
                    Layout.fillWidth: true
                    color: "black"
                    validator: RegExpValidator {}
                    background: Rectangle {
                        implicitWidth: 250
                        implicitHeight: 40
                        radius: 4
                    }
                }
                Text { id: longlatError; color: "red"; visible: false; }
            }



            Item { implicitHeight:1 } // Reduced Spacer
            RowLayout {
                spacing: 30
                Button {
                    text: "Cancel"
                    id: cancelbtn
                    onClicked: {
                        loader.source ="SetRout.qml"
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
                        routeIdError.visible = routeidField.text === "";
                        busError.visible = busComboBox.currentIndex === -1;
                        locationError.visible = addLocation.text === "";
                        destinationError.visible = addDestination.text === "";
                        stopNameError.visible = stopName.text === "";
                        longlatError.visible = longlat.text === "";

                      // Set specific error messages
                       routeIdError.text = routeIdError.visible ? Messages.getErrorMessage("routeEmptyField") : "";
                       busError.text = busError.visible ? Messages.getErrorMessage("routeEmptyField") : "";
                       locationError.text = locationError.visible ? Messages.getErrorMessage("routeEmptyField") : "";
                       destinationError.text = destinationError.visible ? Messages.getErrorMessage("routeEmptyField") : "";
                       stopNameError.text = stopNameError.visible ? Messages.getErrorMessage("routeEmptyField") : "";
                       longlatError.text = longlatError.visible ? Messages.getErrorMessage("routeInvalidLongLat") : "";

                        // If no errors, proceed with adding the route
                       if (!routeIdError.visible && !busError.visible && !locationError.visible && !destinationError.visible && !stopNameError.visible && !longlatError.visible) {
                       console.log("Route Id:", routeidField.text)
                       console.log("Bus:", busComboBox.currentText)
                       console.log("Source:", addLocation.text)
                       console.log("Destination:", addDestination.text)
                       console.log("Stop Name:", stopName.text)
                       console.log("Stop Long.Lat:", longlat.text)

                       // Call the C++ method to insert route data
                       var result = db.addRoute(routeidField.text, busComboBox.currentText, addLocation.text, addDestination.text, stopName.text, longlat.text,12);
                           if (result === 'success') { // Adjust based on your actual return type
                            displayMessage(Messages.getErrorMessage(""), "green");
                               dialog.message="Successfull"
                               dialog.open()
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
        setTimeout(function() {
            statusMessage.visible = false;
        }, 5000);
    }
}
