import QtQuick
import QtQuick.Controls 6.3
import Qt5Compat.GraphicalEffects
Button {
    id: videoBtn
    property url btnIconSource: "../../images/svg_images/minimize_icon.svg"
           property color btnColorDefault: "#1c1d20"
           property color btnColorMouseOver: "#23272E"
    property color btnColorClicked: "#00a1f1"
    icon.color: "#ffffff"


           QtObject{
               id: internal

               // MOUSE OVER AND CLICK CHANGE COLOR
               property var dynamicColor: if(videoBtn.down){
                                              videoBtn.down ? btnColorClicked : btnColorDefault
                                          } else {
                                              videoBtn.hovered ? btnColorMouseOver : btnColorDefault
                                          }
           }

           implicitWidth: 35
           implicitHeight: 35

           background: Rectangle{
               id: bgBtn
               color: internal.dynamicColor

               Image {
                   id: iconBtn
                   source: btnIconSource
                   anchors.verticalCenter: parent.verticalCenter
                   anchors.horizontalCenter: parent.horizontalCenter
                   height: 16
                   width: 16
                   fillMode: Image.PreserveAspectFit
                   visible: false
               }

               ColorOverlay{
                   anchors.fill: iconBtn
                   source: iconBtn
                   color: "#ffffff"
                   antialiasing: false
               }
           }
       }
/*##^##
Designer {
    D{i:0;autoSize:true;height:60;width:70}
}
##^##*/
