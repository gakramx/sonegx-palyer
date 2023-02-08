import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.Dialogs
import QtMultimedia 5.9
import QtQuick.Layouts
import "controls"
import "pages"
import JsonFile

Window {
    flags: Qt.Window | Qt.FramelessWindowHint
    id: mainWindow
    width: 1024
    height: 580
    //  width: Screen.width
    //height: Screen.height
    //visibility:Window.FullScreen
    visible: true
    title: qsTr("Tpro app")
    color: "#00000000"
    property alias mycanvas3: mycanvas3
    property alias topBarInfoLabel: topBarInfoLabel
    minimumHeight: 500
    minimumWidth: 800
    property int windowStatus: 0
    property int windowMargin: 10

    QtObject {
        id: internal
        function resetResizeBorders() {
            // Resize visibility
            resizeLeft.visible = true
            resizeRight.visible = true
            resizeBottom.visible = true
            resizeWindow.visible = true
        }

        function maximizeRestore() {
            if (windowStatus == 0) {
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
                // Resize visibility
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeBottom.visible = false
                resizeWindow.visible = false
                topBarMaxBtn.btnIconSource = "../../images/svg_images/restore_icon.svg"
            } else {
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                // Resize visibility
                internal.resetResizeBorders()
                topBarMaxBtn.btnIconSource = "../../images/svg_images/maximize_icon.svg"
            }
        }

        function ifMaximizedWindowRestore() {
            if (windowStatus == 1) {
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                // Resize visibility
                internal.resetResizeBorders()
                topBarMaxBtn.btnIconSource = "../../images/svg_images/maximize_icon.svg"
            }
        }

        function restoreMargins() {
            windowStatus = 0
            windowMargin = 10
            // Resize visibility
            internal.resetResizeBorders()
            topBarMaxBtn.btnIconSource = "../../images/svg_images/maximize_icon.svg"
        }
       /* function msToTimeString(ms) {
            var totalSec = Math.floor(ms / 1000)
            var min = Math.floor(totalSec / 60)
            var sec = totalSec - min * 60
            if (min <= 9)
                min = "0" + min
            if (sec <= 9)
                sec = "0" + sec
            return min + ":" + sec
        }*/
        function msToTimeString(duration) {
          var milliseconds = Math.floor((duration % 1000) / 100),
            seconds = Math.floor((duration / 1000) % 60),
            minutes = Math.floor((duration / (1000 * 60)) % 60),
            hours = Math.floor((duration / (1000 * 60 * 60)) % 24);

          hours = (hours < 10) ? "0" + hours : hours;
          minutes = (minutes < 10) ? "0" + minutes : minutes;
          seconds = (seconds < 10) ? "0" + seconds : seconds;

          return hours + ":" + minutes + ":" + seconds; //+ "." + milliseconds;
        }
        function toMilliseconds(hrs,min,sec){
            return (hrs*60*60+min*60+sec)*1000;
        }
    }
    FileDialog {
        id: dlg
        nameFilters: ["Video files (*.mp4 *.flv *.ts *.mpg *.3gp *.ogv *.m4v *.mov)", "All files (*)"]
        title: "Please choose a video file"

        //    folder: shortcuts.movies
        //   selectMultiple: false
        modality: Qt.WindowModal
        onAccepted: {
            console.log("You chose: " + selectedFile)
            videoPlayer.source = selectedFile
            //loader_timeline.source="qrc:/qml/video_timeline.qml"
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
        z: 1
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
                    onClicked: animationMenu.running = true
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
                        onActiveChanged: if (active) {
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
                            onDoubleClicked: {
                                internal.maximizeRestore()
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
                    PropertyAnimation {
                        id: animationMenu
                        target: leftMenu
                        property: "width"
                        to: if (leftMenu.width == 70)
                                return 250
                            else
                                return 70
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
                            onClicked: {
                                dlg.open()
                            }
                        }

                        LeftMenuButton {
                            id: saveBtn
                            width: leftMenu.width
                            text: qsTr("Save")
                            btnIconSource: "../../images/svg_images/save_icon.svg"
                            onClicked: {
                                //  console.log(JSON.stringify(jsonFile.read()))
                                var store = JSON.stringify(jsonFile.read())
                                var data = jsonFile.read()

                                //    data.color="green"
                                //var feed = {age:88, name: "akram2", powers:["Radiation resistance","Turning tiny","Radiation blast"], secretIdentity: "chaima"};
                                //  data.members.push(feed)
                                //   console.log(data.members[0].age)
                                //    jsonFile.name="foo.json"
                                //  data.members[1].age=88
                                // var members
                                var timeline_data = data.timeline.sort(
                                            (a, b) => {
                                                if (a.show_time < b.show_time) {
                                                    return -1
                                                }
                                            })
                                console.log(JSON.stringify(timeline_data))
                                delete data.timeline
                                data["timeline"] = timeline_data

                                //    data.push(JSON.stringify(timeline_data))
                                console.log(JSON.stringify(data))
                                console.log(jsonFile.write(
                                                JSON.stringify(data)))
                            }
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
                    Rectangle {
                        id: bpage
                        anchors.fill: parent

                        Rectangle {
                            id: videoArea
                            color: "#000000"
                            border.width: 3
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 233
                            anchors.leftMargin: 429
                            anchors.topMargin: 17
                            anchors.rightMargin: 13

                            border.color: "red"
                            Video {
                                id: videoPlayer
                                volume: 0.5
                                anchors.fill: parent
                                anchors.rightMargin: 4
                                anchors.leftMargin: 4
                                anchors.bottomMargin: 4
                                anchors.topMargin: 4
                                onPositionChanged: {
                                    // control.handle.x= control.handle.x+control.position
                                    console.log(videoPlayer.position / videoPlayer.duration)

                                    console.log("x" + progressSlider.handle.x
                                                + "y" + progressSlider.handle.y)
                                }
                            }
                        }

                        Row {
                            id: videoBtns
                            x: 801
                            y: 280
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 178
                            anchors.rightMargin: 46

                            VideoButtons {
                                id: videoPlayBtn
                                onClicked: {
                                    if (videoPlayer.playbackState == 1)
                                        videoPlayer.pause()
                                    else
                                        videoPlayer.play()
                                }
                            }
                            VideoButtons {
                                id: videSeekDecrease
                                onClicked: {
                                    videoPlayer.seek(
                                                videoPlayer.position - 20000)
                                }
                            }
                            VideoButtons {
                                id: videSeekIncrease
                                onClicked: {
                                    videoPlayer.seek(
                                                videoPlayer.position + 20000)
                                }
                            }
                        }

                        Rectangle {
                            id: rectangle
                            y: 319
                            height: 130
                            color: "#7e7e7e"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 44
                            anchors.leftMargin: 8
                            anchors.rightMargin: 5

                            Slider {
                                id: progressSlider
                                x: 0
                                y: 0
                                width: parent.width
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 125
                                enabled: videoPlayer.seekable
                                value: videoPlayer.duration
                                       > 0 ? videoPlayer.position / videoPlayer.duration : 0
                                background: Rectangle {
                                    implicitHeight: 2
                                    color: "white"
                                    radius: 3
                                    Rectangle {
                                        width: progressSlider.visualPosition * parent.width
                                        height: parent.height
                                        color: "#1D8BF8"
                                        radius: 3
                                    }
                                }
                                handle: Rectangle {
                                    x: progressSlider.leftPadding + progressSlider.position
                                       * (progressSlider.availableWidth - width)
                                    y: progressSlider.topPadding
                                       + progressSlider.availableHeight / 2 - height / 2
                                    implicitWidth: 5
                                    implicitHeight: 5
                                    radius: 13
                                    color: progressSlider.pressed ? "#f0f0f0" : "#f6f6f6"
                                    border.color: "#bdbebf"
                                }
                                onMoved: function () {
                                    videoPlayer.position = videoPlayer.duration
                                            * progressSlider.position
                                }
                            }
                            Canvas {
                                id: mycanvas3
                                width: 2
                                height: parent.height
                                x: progressSlider.handle.x
                                onPaint: {
                                    var ctx = getContext("2d")
                                    ctx.fillStyle = Qt.rgba(1, 0, 0, 1)
                                    ctx.fillRect(0, 0, width, height)
                                }
                            }
                            RowLayout {
                                id: rowLayout
                                x: 0
                                y: 60
                                width: 890
                                height: 16
                            }
                            Item {
                                width: parent.width
                                height: 3
                                anchors.top: parent.top
                                anchors.topMargin: 21
                                property real spacing: 15
                                x: 0
                                Repeater {
                                    model: parent.width / (parent.spacing + 1) - 1
                                    delegate: Rectangle {
                                        x: index * (rowLayout.spacing + 20)
                                        y: parent.height - height
                                        implicitWidth: major ? 2 : 1
                                        implicitHeight: major ? 18 : 9
                                        color: "green"

                                        readonly property bool major: index % 3 == 0
                                    }
                                }
                            }
                        }

                        Rectangle {
                            id: objArea
                            width: 398
                            color: "#00ff7f"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 233
                            anchors.leftMargin: 8
                            anchors.topMargin: 17
                            JsonFile {
                                id: jsonFile
                                name: "jsfile.json"
                            }
                            clip: true
                            ListModel {
                                id: listModel
                            }
                            Column {
                                id: column1
                                width: 164
                                spacing: 10
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.leftMargin: 8
                                anchors.topMargin: 8
                                anchors.bottomMargin: 121

                                Label {
                                    id: label
                                    text: qsTr("Name")
                                }

                                TextField {
                                    id: reactName
                                    width: 80
                                    height: 20
                                    text: qsTr("Text Edit")

                                    font.pixelSize: 12
                                    background: Rectangle {
                                        radius: 2
                                        implicitWidth: 100
                                        implicitHeight: 24
                                        border.color: "#333"
                                        border.width: 1
                                    }
                                }

                                Label {
                                    id: label1
                                    text: qsTr("Msg text")
                                }

                                TextField {
                                    id: reactText
                                    width: 80
                                    height: 20
                                    text: qsTr("Text Edit")
                                    font.pixelSize: 12
                                    background: Rectangle {
                                        radius: 2
                                        implicitWidth: 100
                                        implicitHeight: 24
                                        border.color: "#333"
                                        border.width: 1
                                    }
                                }
                                /*TextField {

                                    id: textEditTD
                                    text: "00:00:00"
                                    //  inputMask: "99:99:99"
                                    //    inputMethodHints: Qt.ImhDigitsOnly
                                    validator: RegularExpressionValidator {
                                        regularExpression: /^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)$/
                                    }

                                    width: 100
                                    height: 50
                                }*/
                            }

                            Button {
                                id: addReactBtn
                                x: 186
                                y: 202
                                text: qsTr("Add")
                                onClicked: {
                                    var component
                                    var sprite
                                    component = Qt.createComponent(
                                                  "qrc:/qml/pages/ReactMess.qml")
                                    //  anchors.verticalCenter: parent.verticalCenter
                                    //anchors.horizontalCenter: parent.horizontalCenter
                                    sprite = component.createObject(videoArea, {
                                                                        "anchors.verticalCenter": videoArea.verticalCenter,
                                                                        "anchors.horizontalCenter": videoArea.horizontalCenter
                                                                    })
                                    rectangle1.appendIfNotExist(reactName.text,reactText.text)
                                }
                            }

                            Rectangle {
                                id: rectangle1
                                x: 186
                                y: 12
                                width: 208
                                height: 184
                                color: "#ffffff"

                                ListModel {
                                    id: channelModelId
                                }

                                ListView {
                                    id: timelineList
                                    anchors {
                                        fill: parent
                                        margins: 10
                                    }
                                    model: channelModelId
                                    delegate: Item {
                                        width: parent.width
                                        height: 40
                                        Column {
                                            Text {
                                                text: 'Name:' + model.name
                                            }

                                            Text {
                                                text: 'Time:' + internal.msToTimeString( model.rtime)
                                            }
                                        }
                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: timelineList.currentIndex = index
                                        }
                                    }
                                    highlight: Rectangle {
                                        color: 'grey'
                                    }
                                    focus: true
                                    flickableDirection: Flickable.VerticalFlick
                                    boundsBehavior: Flickable.StopAtBounds
                                    clip: true

                                    ScrollBar.vertical: vbar

                                    ScrollBar {
                                        id: vbar
                                        active: true
                                        orientation: Qt.Vertical
                                        size: timelineList.height / timelineList.contentHeight
                                        position: timelineList.currentItem
                                        policy: ScrollBar.active
                                        anchors.top: parent.top
                                        anchors.right: parent.right
                                        anchors.bottom: parent.bottom
                                    }
                                }

                                Component.onCompleted: {

                                    //I will fetch JSON api. For testing purpose this will work
                                    //  channelModelId.append({"name" : "hello"})
                                    //  appendIfNotExist({"name" : "hello"})
                                    //   appendIfNotExist({"name" : "hello"})
                                }
                                function appendIfNotExist(recName,recText) {
                                    for (var i = 0; i < channelModelId.count; i++) {
                                        if (channelModelId.get(
                                                    i).name === recName) {
                                            console.log("Exist")
                                            return
                                        }
                                    }
                                    channelModelId.append({
                                                              "name": recName,
                                                              "text": recText,
                                                              "rtime": internal.toMilliseconds(spinHour.value,spinMin.value,spinSec.value)
                                                          })
                                }
                            }

                            Button {
                                id: button2
                                x: 310
                                y: 202
                                text: qsTr("remove")
                                onClicked: {
                                    channelModelId.remove(
                                                timelineList.currentIndex)
                                }
                            }

                            Rectangle {
                                id: rectangle2
                                x: 8
                                y: 142
                                width: 164
                                height: 54
                                color: "#ffffff"

                                SpinBox {
                                    id: spinHour
                                    x: 8
                                    y: 14
                                    width: 49
                                    height: 25

                                     from: 00
                                     to: 59//Math.floor(videoPlayer.duration % 1000)
                                }

                                SpinBox {
                                    id: spinMin
                                    x: 58
                                    y: 14
                                    width: 49
                                    height: 25
                                    from: 00
                                    to:59
                                }

                                SpinBox {
                                    id: spinSec
                                    x: 107
                                    y: 14
                                    width: 49
                                    height: 25
                                    from: 00
                                    to:59
                                }
                            }
                        }

                        Label {
                            id: timePlay
                            x: 8
                            y: 280
                            width: 140
                            height: 17
                            text: internal.msToTimeString(
                                      videoPlayer.position) + " / " + internal.msToTimeString(
                                      videoPlayer.duration)
                            anchors.bottom: rectangle.top
                            anchors.bottomMargin: 22
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

                        DragHandler {
                            target: null
                            onActiveChanged: if (active) {
                                                 mainWindow.startSystemResize(
                                                             Qt.RightEdge | Qt.BottomEdge)
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

    DropShadow {
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

        DragHandler {
            target: null
            onActiveChanged: if (active) {
                                 mainWindow.startSystemResize(Qt.RightEdge)
                             }
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

        DragHandler {
            target: null
            onActiveChanged: if (active) {
                                 mainWindow.startSystemResize(Qt.LeftEdge)
                             }
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

        DragHandler {
            target: null
            onActiveChanged: if (active) {
                                 mainWindow.startSystemResize(Qt.BottomEdge)
                             }
        }
    }
    Component.onCompleted: {
        internal.maximizeRestore()
        // stackView.push("qrc:/qml/pages/board.qml")
    }
}
