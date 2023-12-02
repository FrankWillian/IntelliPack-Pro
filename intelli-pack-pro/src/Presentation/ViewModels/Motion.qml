import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQml 2.2
import "."

Item {
    id: root

    property string uploadType: "sw"

    Component.onCompleted: {


    }

    function sendSignal (register, value)
    {
        Data.envioRun = true
        Task.writeParamt(Number(register),Number(value))
        Data.envioRun = false
    }

    Connections{
        target: Task
    }

    Rectangle {

        id: arquivo
        color: "transparent"
        width: parent.width + 5
        height: 650
        y: 60
        x: -5

        SwipeView{
            id: swipe
            anchors.fill: parent
            currentIndex: tabBarEng.currentIndex

            function addPage(page) {
                addItem(page)
                page.visible = true
            }

            function removePage(page) {
                for (var n = 0; n < count; n++) { if (page === itemAt(n)) { removeItem(n) } }
                page.visible = false
            }

            Timer {
                id: timerCal
                interval: 300
                running: true
                repeat: false
                onTriggered: {
                    Task.enableDevice(37,1,false)
                    timerCal.running = false
                }
            }



            Component.onCompleted:
            {


                swipe.addPage(pageTracao)
                swipe.addPage(pageSelag)
                swipe.addPage(pagePortinhola)
                swipe.addPage(pageEsteira)


            }
        }

        PageIndicator{
            id: indicator
            count: swipe.count
            currentIndex: swipe.currentIndex

            //anchors.bottom: swipe.bottom
            //anchors.horizontalCenter: swipe.horizontalCenter
            x: 200
            y: 510

            delegate: Rectangle {
                implicitWidth: 20
                implicitHeight: 20

                radius: width / 2
                color: "#667ab3"
                border.color: "#ffffff"
                border.width: 1

                opacity: index === indicator.currentIndex ? 0.95 : pressed ? 0.7 : 0.45

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 400
                    }
                }
            }
        }

        Page{
            id: pageTracao
            visible: false

            Column{
                x: 80

                spacing: 25

                Row{

                    x: 90

                    Label{

                        text: "Movimento relativo"
                        font.pointSize: 16
                        font.family: "Arial"
                        font.bold: Font.Medium
                        color: "black"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignHCenter
                    }
                }

                Row{

                    Rectangle{
                        y: 0
                        width: 400
                        height: 440
                        border.color: Paleta.colorPatern
                        border.width: 4
                        radius: 6

                        layer.enabled: true
                        layer.effect: DropShadow {
                            transparentBorder: true
                            color: "black"
                            horizontalOffset: 2
                            verticalOffset: 2
                        }
                        ColumnLayout{
                            x: 25
                            y: 25

                            ColumnLayout{
                                spacing: 35

                                Row{
                                    spacing: 0

                                    Text {

                                        text: "Velocidade (%)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        id: insert
                                        texto: Data.tracaoVelocMotion
                                        registro: 60
                                        x_txt: 200
                                    }
                                }

                                Row{
                                    spacing: 0

                                    Text {

                                        text: "Aceleração (ms)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.tracaoAccMotion
                                        registro: 62
                                        x_txt: 200
                                    }
                                }

                                Row{
                                    spacing: 0

                                    Text {

                                        text: "Desaceleração (ms)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.tracaoDecMotion
                                        registro: 64
                                        x_txt: 200
                                    }
                                }

                                Row{
                                    spacing: 0

                                    Text {

                                        text: "Distância (mm)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.tracaoRelatMotion
                                        registro: 66
                                        x_txt: 200
                                    }
                                }

                                Row{

                                    spacing: 30

                                    Rectangle {
                                        id: btn_triggerTrac
                                        width: 90
                                        height: 90
                                        //visible: Data.alarmActive ? false : true
                                        visible: true

                                        Image {
                                            id: imgTriggerTraction
                                            anchors.fill: parent
                                            source: "CONTENTS/IMAGES/escrever.png"
                                            sourceSize: Qt.size(width, height)
                                            asynchronous: true

                                            Text {
                                                font.pointSize: 12
                                                font.family: "Arial"
                                                font.bold: Font.Medium
                                                color: "white"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignHCenter
                                                anchors.centerIn: parent
                                                text: "Trigger"

                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: btn_triggerTrac
                                            hoverEnabled: true

                                            onPressed: {
                                                imgTriggerTraction.source = "CONTENTS/IMAGES/escritoVerde.png"
                                                Task.enableDevice(37,7,true)

                                            }

                                            onReleased:{
                                                imgTriggerTraction.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(37,7,false)
                                            }

                                            onExited: {
                                                imgTriggerTraction.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(37,7,false)
                                            }
                                        }

                                    }

                                    Rectangle {
                                        id: btn_HomeTrac
                                        width: 90
                                        height: 90
                                        visible: false

                                        Image {
                                            id: imgBtnHomeTrac
                                            anchors.fill: parent
                                            source: "CONTENTS/IMAGES/escrever.png"
                                            sourceSize: Qt.size(width, height)
                                            asynchronous: true

                                            Text {
                                                font.pointSize: Data.fontLabelSize
                                                font.family: "Arial"
                                                font.bold: Font.Medium
                                                color: "white"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignHCenter
                                                anchors.centerIn: parent
                                                text: "Home"

                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: btn_HomeTrac
                                            hoverEnabled: true

                                            onPressed: {
                                                imgBtnHomeTrac.source = "CONTENTS/IMAGES/escritoVerde.png"
                                                Task.enableDevice(38,1,true)
                                            }

                                            onReleased:{
                                                imgBtnHomeTrac.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(38,1,false)
                                            }

                                            onExited: {
                                                imgBtnHomeTrac.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(38,1,false)
                                            }
                                        }

                                    }

                                    Rectangle {
                                        id: btn_tracao2
                                        width: 90
                                        height: 90
                                        visible: true

                                        Image {
                                            id: imgTracao2
                                            anchors.fill: parent
                                            source: "CONTENTS/IMAGES/escrever.png"
                                            sourceSize: Qt.size(width, height)
                                            asynchronous: true

                                            Text {
                                                id: textEscrito
                                                font.pointSize: 14
                                                font.family: "Arial"
                                                font.bold: Font.Medium
                                                color: "white"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignHCenter
                                                anchors.centerIn: parent
                                                text: "Jog"

                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: btn_tracao2
                                            hoverEnabled: true

                                            onPressed: {
                                                imgTracao2.source = "CONTENTS/IMAGES/escritoVerde.png"
                                                Task.enableDevice(36,1,true)
                                            }

                                            onReleased:{
                                                imgTracao2.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(36,1,false)
                                            }

                                            onExited: {
                                                imgTracao2.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(36,1,false)
                                            }
                                        }

                                    }


                                }

                                Row{
                                    spacing: 40


                                    Text {
                                        y: 5
                                        id: lblSentido
                                        font.pointSize: Data.fontLabelSize
                                        color: ctrlSentido.checked ? "#667ab3" : "black"
                                        font.family: "Arial"
                                        Component.onCompleted: lblSentido.text = "Sentido movimento"
                                    }

                                    Switch{
                                        id: ctrlSentido
                                        implicitHeight: 50
                                        implicitWidth: 72

                                        onReleased: {
                                            if(ctrlSentido.checked){
                                                Data.envioRun = true
                                                lblSentido.text = "Sentido movimento"
                                                Task.enableDevice(38,4,true)

                                                Data.envioRun = false

                                            }
                                            else{
                                                Data.envioRun = true
                                                lblSentido.text = "Sentido movimento"
                                                Task.enableDevice(38,4,false)

                                                Data.envioRun = false
                                            }
                                        }
                                        indicator: Rectangle{
                                            implicitWidth: 72
                                            implicitHeight: 30
                                            radius: 15
                                            color: ctrlSentido.checked ? "#667ab3" : "#ffffff"
                                            border.color: ctrlSentido.checked ? "#cccccc" : "#667ab3"
                                            border.width: 2

                                            Rectangle {
                                                x: ctrlSentido.checked ? parent.width - width : 0
                                                width: 30
                                                height: 30
                                                radius: 15
                                                color: "#ffffff"
                                                border.color: ctrlSentido.checked ? "#cccccc" : "#667ab3"
                                                border.width: 2
                                            }
                                        }
                                        contentItem: Text {
                                            text: ctrlSentido.text
                                            font: ctrlSentido.font
                                            color: ctrlSentido.down ? "#17a81a" : "#21be2b"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }


                            }
                        }
                    }



                }


            }

        }

        Page{
            id: pageSelag

            Column{
                x: 50

                spacing: 25

                Row{

                    x: 90

                    Label{

                        text: "Movimento relativo"
                        font.pointSize: 14
                        font.family: "Arial"
                        font.bold: Font.Medium
                        color: "black"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignHCenter

                    }

                }

                Row{

                    Rectangle{

                        y: 0
                        width: 400
                        height: 450
                        border.color: Paleta.colorPatern
                        border.width: 4
                        radius: 6

                        layer.enabled: true
                        layer.effect: DropShadow {
                            transparentBorder: true
                            color: "black"
                            horizontalOffset: 2
                            verticalOffset: 2
                        }
                        ColumnLayout{
                            x: 25
                            y: 15

                            ColumnLayout{
                                spacing: 35

                                Row{
                                    spacing: 0

                                    Text {

                                        text: "Velocidade (%)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.selagVelocMotion
                                        registro: 80
                                        x_txt: 200
                                    }
                                }

                                Row{
                                    spacing: 0

                                    Text {

                                        text: "Aceleração (ms)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.selagAccMotion
                                        registro: 82
                                        x_txt: 200
                                    }
                                }

                                Row{
                                    spacing: 0

                                    Text {

                                        text: "Desaceleração (ms)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.selagDecMotion
                                        registro: 84
                                        x_txt: 200
                                    }
                                }

                                Row{
                                    spacing: 0

                                    Text {

                                        text: "Distância (mm)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.selagRelatMotion
                                        registro: 86
                                        x_txt: 200
                                    }
                                }

                                Row{

                                    spacing: 30

                                    Rectangle {
                                        id: btn_selagTrigger
                                        width: 90
                                        height: 90

                                        Image {
                                            anchors.fill: parent
                                            id: imgSelagTrigger
                                            source: "CONTENTS/IMAGES/escrever.png"
                                            sourceSize: Qt.size(width, height)
                                            asynchronous: true

                                            Text {
                                                font.pointSize: 12
                                                font.family: "Arial"
                                                font.bold: Font.Medium
                                                color: "white"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignHCenter
                                                anchors.centerIn: parent
                                                text: "Trigger"

                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: btn_selagTrigger
                                            hoverEnabled: true

                                            onPressed: {
                                                imgSelagTrigger.source = "CONTENTS/IMAGES/escritoVerde.png"
                                                Task.enableDevice(36,4,true)

                                            }

                                            onReleased:{
                                                imgSelagTrigger.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(36,4,false)
                                            }

                                            onExited: {
                                                imgSelagTrigger.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(36,4,false)
                                            }
                                        }

                                    }

                                    Rectangle {
                                        id: btn_HomeSelag
                                        width: 90
                                        height: 90

                                        Image {
                                            id: imgBtnHomeSelag
                                            anchors.fill: parent
                                            source: "CONTENTS/IMAGES/escrever.png"
                                            sourceSize: Qt.size(width, height)
                                            asynchronous: true

                                            Text {
                                                font.pointSize: 14
                                                font.family: "Arial"
                                                font.bold: Font.Medium
                                                color: "white"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignHCenter
                                                anchors.centerIn: parent
                                                text: "Home"

                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: btn_HomeSelag
                                            hoverEnabled: true

                                            onPressed: {
                                                imgBtnHomeSelag.source = "CONTENTS/IMAGES/escritoVerde.png"
                                                Task.enableDevice(38,6,true)
                                            }

                                            onReleased:{
                                                imgBtnHomeSelag.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(38,6,false)
                                            }

                                            onExited: {
                                                imgBtnHomeSelag.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(38,6,false)
                                            }
                                        }

                                    }

                                    Rectangle {
                                        id: btn_selagJog
                                        width: 90
                                        height: 90

                                        Image {
                                            anchors.fill: parent
                                            id: imgSelagJog
                                            source: "CONTENTS/IMAGES/escrever.png"
                                            sourceSize: Qt.size(width, height)
                                            asynchronous: true

                                            Text {
                                                font.pointSize: 14
                                                font.family: "Arial"
                                                font.bold: Font.Medium
                                                color: "white"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignHCenter
                                                anchors.centerIn: parent
                                                text: "Jog"

                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: btn_selagJog
                                            hoverEnabled: true

                                            onPressed: {
                                                imgSelagJog.source = "CONTENTS/IMAGES/escritoVerde.png"
                                                Task.enableDevice(37,4,true)
                                            }

                                            onReleased:{
                                                imgSelagJog.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(37,4,false)
                                            }

                                            onExited: {
                                                imgSelagJog.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(37,4,false)
                                            }
                                        }

                                    }

                                }

                                Row{
                                    spacing: 40


                                    Text {
                                        y: 5
                                        id: lblSentidoSelag
                                        font.pointSize: Data.fontLabelSize
                                        color: ctrlSentidoSelag.checked ? "#667ab3" : "black"
                                        font.family: "Arial"
                                        Component.onCompleted: lblSentidoSelag.text = "Sentido movimento"
                                    }

                                    Switch{
                                        id: ctrlSentidoSelag
                                        implicitHeight: 50
                                        implicitWidth: 72

                                        onReleased: {
                                            if(ctrlSentidoSelag.checked){
                                                Data.envioRun = true
                                                lblSentidoSelag.text = "Sentido movimento"
                                                Task.enableDevice(38,5,true)

                                                Data.envioRun = false

                                            }
                                            else{
                                                Data.envioRun = true
                                                lblSentidoSelag.text = "Sentido movimento"
                                                Task.enableDevice(38,5,false)

                                                Data.envioRun = false
                                            }
                                        }
                                        indicator: Rectangle{
                                            implicitWidth: 72
                                            implicitHeight: 30
                                            radius: 15
                                            color: ctrlSentidoSelag.checked ? "#667ab3" : "#ffffff"
                                            border.color: ctrlSentidoSelag.checked ? "#cccccc" : "#667ab3"
                                            border.width: 2

                                            Rectangle {
                                                x: ctrlSentidoSelag.checked ? parent.width - width : 0
                                                width: 30
                                                height: 30
                                                radius: 15
                                                color: "#ffffff"
                                                border.color: ctrlSentidoSelag.checked ? "#cccccc" : "#667ab3"
                                                border.width: 2
                                            }
                                        }
                                        contentItem: Text {
                                            text: ctrlSentidoSelag.text
                                            font: ctrlSentidoSelag.font
                                            color: ctrlSentidoSelag.down ? "#17a81a" : "#21be2b"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }

                            }
                        }
                    }



                }

            }

        }

        Page{
            id: pagePortinhola

            Column{
                x: 50; spacing: 25

                Row{

                    x: 90

                    Label{

                        text: "Movimento relativo"
                        font.pointSize: 14
                        font.family: "Arial"
                        font.bold: Font.Medium
                        color: "black"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignHCenter

                    }

                }

                Row{

                    Rectangle{
                        y: 0
                        width: 400
                        height: 450
                        border.color: Paleta.colorPatern
                        border.width: 4
                        radius: 6
                        layer.enabled: true
                        layer.effect: DropShadow {
                            transparentBorder: true
                            color: "black"
                            horizontalOffset: 2
                            verticalOffset: 2
                        }

                        ColumnLayout{
                            x: 25; y: 15

                            ColumnLayout{
                                spacing: 35

                                Row{
                                    spacing: 0

                                    Text {

                                        text: "Velocidade (%)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.portinholaVelocMotion
                                        registro: 52
                                        x_txt: 200
                                    }
                                }

                                Row{
                                    spacing: 0

                                    Text {

                                        text: "Aceleração (ms)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.portinholaAccMotion
                                        registro: 54
                                        x_txt: 200
                                    }
                                }

                                Row{
                                    spacing: 0

                                    Text {

                                        text: "Desaceleração (ms)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.portinholaDecMotion
                                        registro: 56
                                        x_txt: 200
                                    }
                                }

                                Row{
                                    spacing: 0

                                    Text {

                                        text: "Distância (mm)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.portinholaRelatMotion
                                        registro: 58
                                        x_txt: 200
                                    }
                                }

                                Row{
                                    spacing: 30

                                    Rectangle {
                                        id: btn_PortTrigger
                                        width: 90
                                        height: 90
                                        visible: true

                                        Image {
                                            anchors.fill: parent
                                            id: imgPortTrigger
                                            source: "CONTENTS/IMAGES/escrever.png"
                                            sourceSize: Qt.size(width, height)
                                            asynchronous: true

                                            Text {
                                                font.pointSize: 12
                                                font.family: "Arial"
                                                font.bold: Font.Medium
                                                color: "white"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignHCenter
                                                anchors.centerIn: parent
                                                text: "Trigger"

                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: btn_PortTrigger
                                            hoverEnabled: true

                                            onPressed: {
                                                imgPortTrigger.source = "CONTENTS/IMAGES/escritoVerde.png"
                                                Task.enableDevice(38,1,true)

                                            }

                                            onReleased:{
                                                imgPortTrigger.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(38,1,false)
                                            }

                                            onExited: {
                                                imgPortTrigger.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(38,1,false)
                                            }
                                        }

                                    }

                                    Rectangle {
                                        id: btn_HomePort
                                        width: 90
                                        height: 90

                                        Image {
                                            id: imgBtnHomePort
                                            anchors.fill: parent
                                            source: "CONTENTS/IMAGES/escrever.png"
                                            sourceSize: Qt.size(width, height)
                                            asynchronous: true

                                            Text {
                                                font.pointSize: 14
                                                font.family: "Arial"
                                                font.bold: Font.Medium
                                                color: "white"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignHCenter
                                                anchors.centerIn: parent
                                                text: "Home"

                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: btn_HomePort
                                            hoverEnabled: true

                                            onPressed: {
                                                imgBtnHomePort.source = "CONTENTS/IMAGES/escritoVerde.png"
                                                Task.enableDevice(38,7,true)
                                            }

                                            onReleased:{
                                                imgBtnHomePort.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(38,7,false)
                                            }

                                            onExited: {
                                                imgBtnHomePort.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(38,7,false)
                                            }
                                        }

                                    }

                                    Rectangle {
                                        id: btn_PortJog
                                        width: 90
                                        height: 90
                                        visible: true

                                        Image {
                                            anchors.fill: parent
                                            id: imgPortJog
                                            source: "CONTENTS/IMAGES/escrever.png"
                                            sourceSize: Qt.size(width, height)
                                            asynchronous: true

                                            Text {
                                                font.pointSize: 14
                                                font.family: "Arial"
                                                font.bold: Font.Medium
                                                color: "white"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignHCenter
                                                anchors.centerIn: parent
                                                text: "Jog"

                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: btn_PortJog
                                            hoverEnabled: true

                                            onPressed: {
                                                imgPortJog.source = "CONTENTS/IMAGES/escritoVerde.png"
                                                Task.enableDevice(37,6,true)
                                            }

                                            onReleased:{
                                                imgPortJog.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(37,6,false)
                                            }

                                            onExited: {
                                                imgPortJog.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(37,6,false)
                                            }
                                        }

                                    }

                                }

                                Row{
                                    spacing: 40


                                    Text {
                                        y: 5
                                        id: lblSentidoPort
                                        font.pointSize: Data.fontLabelSize
                                        color: ctrlSentidoPort.checked ? "#667ab3" : "black"
                                        font.family: "Arial"
                                        Component.onCompleted: lblSentidoPort.text = "Sentido movimento"
                                    }

                                    Switch{
                                        id: ctrlSentidoPort
                                        implicitHeight: 50
                                        implicitWidth: 72

                                        onReleased: {
                                            if(ctrlSentidoPort.checked){
                                                Data.envioRun = true
                                                lblSentidoPort.text = "Sentido movimento"
                                                Task.enableDevice(38,3,true)

                                                Data.envioRun = false

                                            }
                                            else{
                                                Data.envioRun = true
                                                lblSentidoPort.text = "Sentido movimento"
                                                Task.enableDevice(38,3,false)

                                                Data.envioRun = false
                                            }
                                        }
                                        indicator: Rectangle{
                                            implicitWidth: 72
                                            implicitHeight: 30
                                            radius: 15
                                            color: ctrlSentidoPort.checked ? "#667ab3" : "#ffffff"
                                            border.color: ctrlSentidoPort.checked ? "#cccccc" : "#667ab3"
                                            border.width: 2

                                            Rectangle {
                                                x: ctrlSentidoPort.checked ? parent.width - width : 0
                                                width: 30
                                                height: 30
                                                radius: 15
                                                color: "#ffffff"
                                                border.color: ctrlSentidoPort.checked ? "#cccccc" : "#667ab3"
                                                border.width: 2
                                            }
                                        }
                                        contentItem: Text {
                                            text: ctrlSentidoPort.text
                                            font: ctrlSentidoPort.font
                                            color: ctrlSentidoPort.down ? "#17a81a" : "#21be2b"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }

                            }
                        }
                    }
                }
            }
        }

        Page{
            id: pageEsteira
            visible: false

            Column{
                x: 50; spacing: 25

                Row{

                    x: 90

                    Label{

                        text: "Movimento relativo"
                        font.pointSize: 14
                        font.family: "Arial"
                        font.bold: Font.Medium
                        color: "black"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignHCenter

                    }
                }

                Row{

                    Rectangle{
                        y: 0
                        width: 400
                        height: 450
                        border.color: Paleta.colorPatern
                        border.width: 4
                        radius: 6
                        layer.enabled: true
                        layer.effect: DropShadow {
                            transparentBorder: true
                            color: "black"
                            horizontalOffset: 2
                            verticalOffset: 2
                        }

                        ColumnLayout{
                            x: 25; y: 15

                            ColumnLayout{
                                spacing: 35

                                Row{

                                    Text {

                                        text: "Velocidade (%)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.esteiraVelocMotion
                                        registro: 88
                                        x_txt: 200
                                    }
                                }

                                Row{

                                    Text {

                                        text: "Aceleração (ms)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.esteiraAccMotion
                                        registro: 90
                                        x_txt: 200
                                    }
                                }

                                Row{

                                    Text {

                                        text: "Desaceleração (ms)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.esteiraDecMotion
                                        registro: 92
                                        x_txt: 200
                                    }
                                }

                                Row{

                                    Text {

                                        text: "Distância (mm)"
                                        font.family: "Arial"
                                        color: "black"
                                        font.pointSize: Data.fontLabelSize
                                        anchors.margins: 2
                                    }

                                    TextBoxOpus
                                    {
                                        minValue: 0
                                        maxValue: 9999
                                        texto: Data.esteiraRelatMotion
                                        registro: 94
                                        x_txt: 200
                                    }
                                }

                                Row{
                                    spacing: 30

                                    Rectangle {
                                        id: btn_EsteiraTrigger
                                        width: 90
                                        height: 90
                                        visible: true

                                        Image {
                                            anchors.fill: parent
                                            id: imgEsteiraTrigger
                                            source: "CONTENTS/IMAGES/escrever.png"
                                            sourceSize: Qt.size(width, height)
                                            asynchronous: true

                                            Text {
                                                font.pointSize: 12
                                                font.family: "Arial"
                                                font.bold: Font.Medium
                                                color: "white"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignHCenter
                                                anchors.centerIn: parent
                                                text: "Trigger"

                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: btn_EsteiraTrigger
                                            hoverEnabled: true

                                            onPressed: {
                                                imgEsteiraTrigger.source = "CONTENTS/IMAGES/escritoVerde.png"
                                                Task.enableDevice(38,0,true)

                                            }

                                            onReleased:{
                                                imgEsteiraTrigger.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(38,0,false)
                                            }

                                            onExited: {
                                                imgEsteiraTrigger.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(38,0,false)
                                            }
                                        }

                                    }

                                    Rectangle {
                                        id: btn_HomeEsteira
                                        width: 90
                                        height: 90
                                        visible: false

                                        Image {
                                            id: imgBtnHomeEsteira
                                            anchors.fill: parent
                                            source: "CONTENTS/IMAGES/escrever.png"
                                            sourceSize: Qt.size(width, height)
                                            asynchronous: true

                                            Text {
                                                font.pointSize: 14
                                                font.family: "Arial"
                                                font.bold: Font.Medium
                                                color: "white"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignHCenter
                                                anchors.centerIn: parent
                                                text: "Home"

                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: btn_HomeEsteira
                                            hoverEnabled: true

                                            onPressed: {
                                                imgBtnHomeEsteira.source = "CONTENTS/IMAGES/escritoVerde.png"
                                                Task.enableDevice(38,7,true)
                                            }

                                            onReleased:{
                                                imgBtnHomeEsteira.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(38,7,false)
                                            }

                                            onExited: {
                                                imgBtnHomeEsteira.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(38,7,false)
                                            }
                                        }

                                    }

                                    Rectangle {
                                        id: btn_EsteiraJog
                                        width: 90
                                        height: 90
                                        visible: true

                                        Image {
                                            anchors.fill: parent
                                            id: imgEsteiraJog
                                            source: "CONTENTS/IMAGES/escrever.png"
                                            sourceSize: Qt.size(width, height)
                                            asynchronous: true

                                            Text {
                                                font.pointSize: 14
                                                font.family: "Arial"
                                                font.bold: Font.Medium
                                                color: "white"
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignHCenter
                                                anchors.centerIn: parent
                                                text: "Jog"

                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: btn_EsteiraJog
                                            hoverEnabled: true

                                            onPressed: {
                                                imgEsteiraJog.source = "CONTENTS/IMAGES/escritoVerde.png"
                                                Task.enableDevice(37,5,true)
                                            }

                                            onReleased:{
                                                imgEsteiraJog.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(37,5,false)
                                            }

                                            onExited: {
                                                imgEsteiraJog.source = "CONTENTS/IMAGES/escrever.png"
                                                Task.enableDevice(37,5,false)
                                            }
                                        }
                                    }
                                }

                                Row{
                                    spacing: 40

                                    Text {
                                        y: 5
                                        id: lblSentidoEsteira
                                        font.pointSize: Data.fontLabelSize
                                        color: ctrlSentidoEsteira.checked ? "#667ab3" : "black"
                                        font.family: "Arial"
                                        Component.onCompleted: lblSentidoEsteira.text = "Sentido movimento"
                                    }

                                    Switch{
                                        id: ctrlSentidoEsteira
                                        implicitHeight: 50
                                        implicitWidth: 72

                                        onReleased: {
                                            if(ctrlSentidoEsteira.checked){
                                                Data.envioRun = true
                                                lblSentidoEsteira.text = "Sentido movimento"
                                                Task.enableDevice(38,2,true)

                                                Data.envioRun = false

                                            }
                                            else{
                                                Data.envioRun = true
                                                lblSentidoEsteira.text = "Sentido movimento"
                                                Task.enableDevice(38,2,false)

                                                Data.envioRun = false
                                            }
                                        }
                                        indicator: Rectangle{
                                            implicitWidth: 72
                                            implicitHeight: 30
                                            radius: 15
                                            color: ctrlSentidoEsteira.checked ? "#667ab3" : "#ffffff"
                                            border.color: ctrlSentidoEsteira.checked ? "#cccccc" : "#667ab3"
                                            border.width: 2

                                            Rectangle {
                                                x: ctrlSentidoEsteira.checked ? parent.width - width : 0
                                                width: 30
                                                height: 30
                                                radius: 15
                                                color: "#ffffff"
                                                border.color: ctrlSentidoEsteira.checked ? "#cccccc" : "#667ab3"
                                                border.width: 2
                                            }
                                        }
                                        contentItem: Text {
                                            text: ctrlSentidoEsteira.text
                                            font: ctrlSentidoEsteira.font
                                            color: ctrlSentidoEsteira.down ? "#17a81a" : "#21be2b"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }


                            }
                        }
                    }
                }
            }
        }
    }

    TabBar{
        y: 640
        x: 60
        id: tabBarEng
        currentIndex: swipe.currentIndex
        visible: Data.alarmActive ? false : true
        width: parent.width

        Flickable
        {
            flickDeceleration: 0.5
        }

        TabButton{
            id: tabTracao
            text: qsTr("Tração")
            visible: true

            contentItem: Text {
                text: qsTr("Tração")
                font.family: "Arial"
                opacity: enabled ? 1.0 : 0.3
                color: tabTracao.checked ? "#667ab3" : "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 80
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                color: tabTracao.checked ? "white" : "#667ab3"
                border.color: tabTracao.checked ? "#667ab3": "white"
                border.width: 1
                radius: 2
            }
            width: 150
        }

        TabButton{
            id: tabSelagem
            text: qsTr("Selagem")
            visible: true

            contentItem: Text {
                text: tabSelagem.text
                font.family: "Arial"
                opacity: enabled ? 1.0 : 0.3
                color: tabSelagem.checked ? "#667ab3" : "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 80
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                color: tabSelagem.checked ? "white" : "#667ab3"
                border.color: tabSelagem.checked ? "#667ab3": "white"
                border.width: 1
                radius: 2
            }
            width: 150
        }

        TabButton{
            id: tabPortinhola
            text: qsTr("Portinhola")
            visible: true

            contentItem: Text {
                text: tabPortinhola.text
                font.family: "Arial"
                opacity: enabled ? 1.0 : 0.3
                color: tabPortinhola.checked ? "#667ab3" : "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 80
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                color: tabPortinhola.checked ? "white" : "#667ab3"
                border.color: tabPortinhola.checked ? "#667ab3": "white"
                border.width: 1
                radius: 2
            }
            width: 150
        }

        TabButton{
            id: tabEsteira
            text: qsTr("Esteira")
            visible: true

            contentItem: Text {
                text: tabEsteira.text
                font.family: "Arial"
                opacity: enabled ? 1.0 : 0.3
                color: tabEsteira.checked ? "#667ab3" : "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 80
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                color: tabEsteira.checked ? "white" : "#667ab3"
                border.color: tabEsteira.checked ? "#667ab3": "white"
                border.width: 1
                radius: 2
            }
            width: 150
        }


    }

    Loader {
        id: loaderEng

        anchors.top: root.top
        anchors.left: root.left

        height: root.height-(footer.height+footer.height)
        width: root.width
        x: 20
        y: 80

    }

    Component { id: compNull; Item {} }
}





