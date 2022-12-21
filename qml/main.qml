import QtQuick
import QtQuick.Controls 6.3
import Qt5Compat.GraphicalEffects
import QtQuick.Dialogs
import "controls"
import "pages"
Window {
    flags: Qt.Window | Qt.FramelessWindowHint
    id: mainWindow
    width: 1024
    height: 580
    visible: true
    title: qsTr("Tpro app")
    color: "#00000000"
    minimumHeight: 500
    minimumWidth: 800
    property int windowStatus: 0
    property int windowMargin: 10
    QtObject{
        id: internal
        function resetResizeBorders(){
            // Resize visibility
            resizeLeft.visible = true
            resizeRight.visible = true
            resizeBottom.visible = true
            resizeWindow.visible = true
        }

        function maximizeRestore(){
            if(windowStatus == 0){
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
                // Resize visibility
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeBottom.visible = false
                resizeWindow.visible = false
                topBarMaxBtn.btnIconSource = "../../images/svg_images/restore_icon.svg"
            }
            else{
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                // Resize visibility
                internal.resetResizeBorders()
                topBarMaxBtn.btnIconSource = "../../images/svg_images/maximize_icon.svg"
            }
        }

        function ifMaximizedWindowRestore(){
            if(windowStatus == 1){
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                // Resize visibility
                internal.resetResizeBorders()
                topBarMaxBtn.btnIconSource = "../../images/svg_images/maximize_icon.svg"
            }
        }

        function restoreMargins(){
            windowStatus = 0
            windowMargin = 10
            // Resize visibility
            internal.resetResizeBorders()
            topBarMaxBtn.btnIconSource = "../../images/svg_images/maximize_icon.svg"
        }
    }
    FileDialog {
        id: dlg
        nameFilters: [ "Video files (*.mp4 *.flv *.ts *.mpg *.3gp *.ogv *.m4v *.mov)", "All files (*)" ]
        title: "Please choose a video file"
        //    folder: shortcuts.movies
        //   selectMultiple: false

        //modality: Qt.WindowModal
        onAccepted: {
            console.log("You chose: " + selectedFile)
            //  player.source = selectedFile
            return
        }
        onRejected: {
            console.log("Canceled")
            return
        }
    }
    property alias openBtn: openBtn
    Rectangle {
        id: bg
        color: "#2c313c"
        border.color: "#2c313c"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        z:1
        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                height: 60
                color: "#1a1d23"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                ToggleButton {
                    onClicked: animationMenu.running=true
                }

                Rectangle {
                    id: topBarDesc
                    y: 35
                    height: 25
                    color: "#242831"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                    anchors.bottomMargin: 0

                    Label {
                        id: topBarInfoLabel
                        color: "#5f6a82"
                        text: qsTr("Test info 1")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 10
                        anchors.rightMargin: 300
                        anchors.leftMargin: 20
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                    }

                    Label {
                        id: topBarInfoLabel2
                        color: "#5f6a82"
                        text: qsTr("Test Info 2")
                        anchors.left: topBarInfoLabel.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 10
                        font.pointSize: 10
                        anchors.topMargin: 0
                    }
                }

                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 70
                    anchors.topMargin: 0
                    DragHandler {
                        onActiveChanged: if(active){
                                             mainWindow.startSystemMove()
                                         }
                    }
                    Image {
                        id: iconApp
                        width: 28
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "qrc:/images/icon.ico"
                        anchors.leftMargin: 4
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: titleLabel
                        text: qsTr("My Title App")
                        anchors.left: iconApp.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 12
                        anchors.leftMargin: 5

                        MouseArea {
                            id: mouseResize
                            anchors.fill: parent
                            onDoubleClicked: {internal.maximizeRestore()

                            }
                        }
                    }
                }

                Row {
                    id: rowBtns
                    x: 872
                    width: 105
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                    TopBarButton {
                        id: topBarMinBtn
                        onClicked: {
                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }

                    }

                    TopBarButton {
                        id: topBarMaxBtn
                        btnIconSource: "../../images/svg_images/maximize_icon.svg"
                        onClicked: internal.maximizeRestore()
                    }

                    TopBarButton {
                        id: topBarCloseBtn
                        btnColorClicked: "#f10006"
                        btnIconSource: "../../images/svg_images/close_icon.svg"
                        onClicked: mainWindow.close()
                    }
                }
            }

            Rectangle {
                id: content
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: "#1c1d20"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    PropertyAnimation{
                        id:animationMenu
                        target: leftMenu
                        property: "width"
                        to: if(leftMenu.width == 70) return 250; else return 70
                        duration: 500
                        easing.type: Easing.InOutQuint
                    }

                    Column {
                        id: column
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 90
                        anchors.topMargin: 0

                        LeftMenuButton {
                            id: homeBtn
                            width: leftMenu.width
                            text: qsTr("Home")
                          onClicked: {
                          stackView.push("qrc:/qml/pages/board.qml")
                          }
                        }

                        LeftMenuButton {
                            id: openBtn
                            width: leftMenu.width
                            text: qsTr("Open")

                            btnIconSource: "../../images/svg_images/open_icon.svg"
                            onClicked: {dlg.open()}
                        }

                        LeftMenuButton {
                            id: saveBtn
                            width: leftMenu.width
                            text: qsTr("Save")
                            btnIconSource: "../../images/svg_images/save_icon.svg"
                        }
                    }

                    LeftMenuButton {
                        id: settingsBtn
                        width: leftMenu.width
                        text: qsTr("Settings")
                        anchors.bottom: parent.bottom
                        btnIconSource: "../../images/svg_images/settings_icon.svg"

                        anchors.bottomMargin: 30
                    }
                }

                Rectangle {
                    id: contentPages
                    color: "#2c313c"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 25
                    anchors.leftMargin: 0
                    clip: true
                    Rectangle{
                        id: bpage
                        anchors.fill: parent

                        Rectangle {
                            id: videoArea
                            color: "#000000"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 576
                            anchors.bottomMargin: 226
                            anchors.topMargin: 23
                            anchors.rightMargin: 17

                        }
                    }
                /* StackView {
                                              id: stackView
                                              anchors.fill: parent
                                             initialItem: "qrc:/qml/pages/board.qml" //Qt.resolvedUrl("pages/board.qml")
                                          }*/
                }

                Rectangle {
                    id: bottomBar
                    color: "#242831"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPages.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: -19

                    MouseArea {
                        id: resizeWindow
                        x: 884
                        y: 0
                        width: 25
                        height: 25
                        opacity: 0.5
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        cursorShape: Qt.SizeFDiagCursor

                        DragHandler{
                            target: null
                            onActiveChanged: if (active){
                                                 mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                                             }
                        }

                        Image {
                            id: resizeImage
                            width: 16
                            height: 16
                            anchors.fill: parent
                            source: "../../images/svg_images/resize_icon.svg"
                            anchors.leftMargin: 5
                            anchors.topMargin: 5
                            sourceSize.height: 16
                            sourceSize.width: 16
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }
                    }
                }
            }
        }
    }


    DropShadow{
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
        source: bg
        z: 0
    }
    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.RightEdge) }
        }
    }

    MouseArea {
        id: resizeLeft
        x: 0
        width: 10
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.LeftEdge) }
        }
    }
    MouseArea {
        id: resizeBottom
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.BottomEdge) }
        }
    }
  /*  Component.onCompleted:
             {
            stackView.push("qrc:/qml/pages/board.qml")
             }*/


}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:29}
}
##^##*/
