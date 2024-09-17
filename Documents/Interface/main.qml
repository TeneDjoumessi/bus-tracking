import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import QtLocation 5.7
Window {
    visible: true
     visibility: Window.Maximized
    width: 640
    height: 480
    title: qsTr("TrackMe")

   StackView {
             id: stack
             initialItem: HomePage{

             }

             width: parent.width
                     height: parent.height
//             anchors.fill: parent
             function back()
             {
             stack.pop()
             }
             function login()
             {
             stack.push(Qt.resolvedUrl("LoginPage.qml"))
             }

             function signup()
             {
             stack.push(Qt.resolvedUrl("SignUpPage.qml"))
             }

             function openApp()
             {
             stack.push(Qt.resolvedUrl("DispachCenterPage.qml"))
             }


             function logout()
             {
//             stack.push(Qt.resolvedUrl("HomePage.qml"))
                 stack.pop()
             }
         }
}
