import QtQuick
import QtQuick.Controls 6.3

Rectangle{
    property string name:"akram"
    id: react
    implicitWidth: 200
    implicitHeight : 100

    color :"gold"
    function update(){
    console.log(x+"x"+y)
    }
   /*   property int timeToHide: 4000
    Timer {
           interval: timeToHide; running: true; repeat: true
           onTriggered: parent.visible=false
       }*/
    onXChanged: update()
    onYChanged: update()
    Button {
        id: watchBtn
        text: qsTr("Watch")
        anchors.left: parent.left
        anchors.right: contBtn.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.rightMargin: 24
        anchors.leftMargin: 8
    }

        Button {
            id: contBtn
            text: qsTr("Continue")
            anchors.left: parent.left
            anchors.right: watchBtn.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 112
            anchors.rightMargin: -184
            anchors.bottomMargin: 5

        }

        Label {
            id: recText
            height: 45
            text: qsTr("Do you want watch this part")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            anchors.rightMargin: 14
            anchors.leftMargin: 14
            anchors.bottomMargin: 11
            anchors.topMargin: 8
        }
        MouseArea{
        id:mousedrage
        anchors.fill: parent
        drag.target: parent
        drag.minimumX: 0
        drag.maximumX: videoArea.width - parent.width
        drag.minimumY: 0
        drag.maximumY: videoArea.height - parent.height
        onClicked: {
            reactName.text=parent.name
            reactText.text=recText.text
        }
    }
}








