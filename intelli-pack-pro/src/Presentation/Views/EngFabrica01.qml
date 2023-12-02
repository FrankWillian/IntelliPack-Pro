import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
//import QtGraphicalEffects 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQml 2.2
import "."

Item {
    id: root

    property string uploadType: "sw"

    Component.onCompleted: {

        if(Data.setUpCtr == "ligado"){
            controlSetUp.checked = true
        }
        if(Data.modoEsteira == "ligado"){
            controlModoEsteira.checked = true

        }
    }

    function sendSignal (register, value)
    {
        Data.envioRun = true
        Task.writeParamt(Number(register),Number(value))
        Data.envioRun = false
    }

    Rectangle {

        id: arquivo
        color: "transparent"
        width: parent.width
        height: 550
        y: 60
        x: 00

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

                if(Data.nameLoginCarregado === Data.nameLoginAdmin)
                {
                    swipe.addPage(pageEngOperador)
                    swipe.addPage(pageEngTecnico1)
                    swipe.addPage(pageEngTecnico2)
                    swipe.addPage(pageDateTime)
                    swipe.addPage(pageUpload)
                }
                else if(Data.nameLoginCarregado === Data.nameLoginSuper)
                {
                    swipe.addPage(pageEngOperador)
                    swipe.addPage(pageEngTecnico1)
                    swipe.removePage(pageEngTecnico2)
                    swipe.removePage(pageDateTime)
                    swipe.removePage(pageUpload)
                }
                else
                {
                    swipe.addPage(pageEngOperador)
                    swipe.removePage(pageEngTecnico1)
                    swipe.removePage(pageEngTecnico2)
                    swipe.removePage(pageDateTime)
                    swipe.removePage(pageUpload)
                }
            }
        }

        PageIndicator{
            id: indicator
            count: swipe.count
            currentIndex: swipe.currentIndex

            //anchors.bottom: swipe.bottom
            //anchors.horizontalCenter: swipe.horizontalCenter
            x: 400
            y: 810

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
            id: pageEngOperador
            visible: false

            Column{
                x: 50
                spacing: 30

                Row{
                    spacing: 60
                    Text {
                        id: test10
                        text: "Reserva"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insert10
                        texto: Data.desligaAr
                        registro: 38
                        x_txt: 270
                    }
                }

                Column{

                    spacing: 60

                    Row{
                        spacing: 158
                        Text {
                            id: labelModoCorte
                            font.pointSize: Data.fontLabelSize
                            color: controlModoEsteira.checked ? "#667ab3" : "black"
                            font.family: "Arial"
                            text: "Modo esteira"
                            height: 50
                        }

                        Switch{

                            id: controlModoEsteira
                            implicitHeight: 50
                            implicitWidth: 72
                            onReleased: {

                                    if(controlModoEsteira.checked){
                                        Data.envioRun = true
                                        Task.enableDevice(36,6,true)
                                        Data.modoEsteira = "ligado"
                                        Data.envioRun = false
                                    } else{
                                        Data.envioRun = true
                                        Task.enableDevice(36,6,false)
                                        Data.modoEsteira = "apagado"
                                        Data.envioRun = false
                                    }



                            }
                            indicator: Rectangle{
                                implicitWidth: 72
                                implicitHeight: 32
                                radius: 16
                                color: controlModoEsteira.checked ? "#667ab3" : "#ffffff"
                                border.color: controlModoEsteira.checked ? "#667ab3" : "#cccccc"
                                border.width: 2

                                Rectangle {
                                    x: controlModoEsteira.checked ? parent.width - width : 0
                                    width: 32
                                    height: 32
                                    radius: 16
                                    color: "white"
                                    border.color: "#999999"
                                    border.width: 2
                                }
                            }
                            contentItem: Text {
                                text: controlModoEsteira.text
                                font: controlModoEsteira.font
                                color: controlModoEsteira.down ? "#17a81a" : "#21be2b"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                    }

                }


            }

            Rectangle {
                x: 45
                y: 620
                z: 90
                id: btnLogin
                width: 90
                height: 90
                visible: !popupLogin.visible

                Image {
                    anchors.fill: btnLogin
                    id: img
                    source: "CONTENTS/IMAGES/user2.png"
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit
                    width: 90; height: 90
                    sourceSize: Qt.size(width, height)


                    MouseArea {
                        anchors.fill: img
                        onClicked: {
                            popupLogin.visible = true
                        }
                    }
                }
            }

            Rectangle {
                x: 190
                y: 620
                z: 90
                id: btnDesbobinador
                width: 90
                height: 90
                visible: true

                Image {
                    id: imgDesbobinador
                    anchors.fill: parent
                    source: "CONTENTS/IMAGES/escrever.png"
                    sourceSize: Qt.size(width, height)
                    asynchronous: true

                    Text {
                        id: textDesbobinador
                        font.pointSize: 12
                        font.family: "Arial"
                        font.bold: Font.Medium
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignHCenter
                        anchors.centerIn: parent
                        text: "Jog\nDesb."

                    }
                }

                MouseArea {
                    anchors.fill: btnDesbobinador
                    hoverEnabled: true

                    onPressed: {
                        imgDesbobinador.source = "CONTENTS/IMAGES/escritoVerde.png"
                        Task.enableDevice(37,3,true)

                    }

                    onReleased:{
                        imgDesbobinador.source = "CONTENTS/IMAGES/escrever.png"
                        Task.enableDevice(37,3,false)
                    }

                    onExited: {
                        imgDesbobinador.source = "CONTENTS/IMAGES/escrever.png"
                        Task.enableDevice(37,3,false)
                    }
                }
            }

            Rectangle {
                x: 335
                y: 620
                z: 90
                id: btnCarregar
                width: 90
                height: 90
                visible: false
                Image {
                    anchors.fill: parent
                    id: imgCarregar
                    source: "CONTENTS/IMAGES/loadRecipe.png"
                    asynchronous: true

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            popupSmallLoad.msgPopup = "Deseja restaurar os parâmetros salvos?"
                            popupSmallLoad.visible = true
                        }
                    }
                }
            }

            Text{
                id: user
                text: Data.nameLoginCarregado
                anchors.top: btnLogin.bottom
                anchors.left: btnLogin.left
                color: Paleta.colorPatern
                font.pointSize: 10
                font.bold: Font.Thin
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                font.capitalization: Font.Thin
                font.weight: Font.Thin
                width: btnLogin.width
            }
        }

        Page{
            id: pageEngTecnico1
            visible: false
            Column{
                x: 50
                spacing: 30

                Row{
                    spacing: 30
                    Text {
                        id: test17
                        text: "Posição selagem (mm)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insert17
                        texto: Data.posicaoSelagem
                        registro: 2
                        x_txt: insert10.x_txt
                    }
                }

                Row{
                    spacing: 30
                    Text {
                        id: test07
                        text: "Tempo selagem (ms)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }

                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insert07
                        texto: Data.tempoSelagem
                        registro: 4
                        x_txt: insert10.x_txt
                    }
                }

                Row{
                    spacing: 30
                    Text {
                        id: testEsteira
                        text: "Atraso esteira (ms)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }

                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insertEsteira
                        texto: Data.esteiraAtraso
                        registro: 6
                        x_txt: insert10.x_txt
                    }
                }

                Row{
                    spacing: 30
                    Text {
                        id: testPortAberta
                        text: "Portinhola aberta (ms)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }

                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insertPortAberta
                        texto: Data.tpoPortAberta
                        registro: 18
                        x_txt: insert10.x_txt
                    }
                }

                Row{

                    Row{

                        x: 0
                        y: 202
                        spacing: 210

                        Text {
                            id: labelSetUp
                            font.pointSize: Data.fontLabelSize
                            color: controlSetUp.checked ? "#667ab3" : "black"
                            font.family: "Arial"

                            Component.onCompleted: labelSetUp.text = "Set Up"
                        }

                        Switch{
                            id: controlSetUp
                            implicitHeight: 50
                            implicitWidth: 72

                            onReleased: {
                                if(controlSetUp.checked){
                                    Data.envioRun = true
                                    labelSetUp.text = "Set Up"
                                    Task.enableDevice(36,5,true)
                                    Data.setUpCtr = "ligado"
                                    Data.envioRun = false

                                } else{
                                    Data.envioRun = true
                                    labelSetUp.text = "Set Up"
                                    Task.enableDevice(36,5,false)
                                    Data.setUpCtr = "apagado"
                                    Data.envioRun = false
                                }
                            }
                            indicator: Rectangle{
                                implicitWidth: 72
                                implicitHeight: 30
                                radius: 15
                                color: controlSetUp.checked ? "#667ab3" : "#ffffff"
                                border.color: controlSetUp.checked ? "#cccccc" : "#667ab3"
                                border.width: 2

                                Rectangle {
                                    x: controlSetUp.checked ? parent.width - width : 0
                                    width: 30
                                    height: 30
                                    radius: 15
                                    color: "#ffffff"
                                    border.color: controlSetUp.checked ? "#cccccc" : "#667ab3"
                                    border.width: 2
                                }
                            }
                            contentItem: Text {
                                text: controlSetUp.text
                                font: controlSetUp.font
                                //opacity: enabled ? 1.0 : 0.3
                                color: controlSetUp.down ? "#17a81a" : "#21be2b"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }

                }



            }
        }
        Page{
            id: pageEngTecnico2
            visible: false
            Column{
                x: 50
                spacing: 30

                Row{
                    spacing: 30
                    Text {
                        id: test02
                        text: "Veloc selagem (%)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insert01
                        texto: Data.selagVeloc
                        registro: 74
                        x_txt: 270
                    }
                }
                Row{
                    spacing: 30
                    Text {
                        id: test222
                        text: "Acc selagem (ms)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }

                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insert13
                        texto: Data.selagAcc
                        registro: 76
                        x_txt: insert01.x_txt
                    }
                }
                Row{
                    spacing: 30
                    Text {
                        id: test33
                        text: "Dec selag (ms)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }

                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insert33
                        texto: Data.selagDec
                        registro: 78
                        x_txt: insert01.x_txt
                    }
                }
                Row{
                    spacing: 30
                    Text {
                        id: test11
                        text: "Velocidade filme (%)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insert11
                        texto: Data.tracaoVeloc
                        registro: 68
                        x_txt: insert01.x_txt
                    }
                }
                Row{
                    spacing: 30
                    Text {
                        id: test13
                        text: "Acc filme (ms)"
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
                        texto: Data.tracaoAcc
                        registro: 70
                        x_txt: insert01.x_txt
                    }
                }
                Row{
                    spacing: 30
                    Text {
                        id: test14
                        text: "Dec filme (ms)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }

                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insert14
                        texto: Data.tracaoDec
                        registro: 72
                        x_txt: insert01.x_txt
                    }
                }
                Row{
                    spacing: 30
                    Text {

                        text: "Veloc portinhola (%)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insert58
                        texto: Data.portinholaVeloc
                        registro: 30
                        x_txt: insert01.x_txt
                    }
                }
                Row{
                    spacing: 30
                    Text {

                        text: "Acc portinhola (ms)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insert19
                        texto: Data.portinholaAcc
                        registro: 32
                        x_txt: insert01.x_txt
                    }
                }
                Row{
                    spacing: 30
                    Text {

                        text: "Dec portinhola (ms)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        //id: insert52
                        texto: Data.portinholaDec
                        registro: 34
                        x_txt: insert01.x_txt
                    }
                }
                Row{
                    spacing: 30
                    Text {

                        text: "Veloc esteira (%)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insert78
                        texto: Data.esteiraVeloc
                        registro: 24
                        x_txt: insert01.x_txt
                    }
                }
                Row{
                    spacing: 30
                    Text {

                        text: "Acc esteira (ms)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        id: insert888
                        texto: Data.esteiraAcc
                        registro: 26
                        x_txt: insert01.x_txt
                    }
                }
                Row{
                    spacing: 30
                    Text {

                        text: "Dec esteira (ms)"
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                    TextBoxOpus
                    {
                        minValue: 0
                        maxValue: 9999
                        //id: insert52
                        texto: Data.esteiraDec
                        registro: 28
                        x_txt: insert01.x_txt
                    }
                }

            }
        }
        Page{
            id: pageDateTime
            visible: false
            Rectangle {
                width: 350
                height: 550
                y: 35
                x: 50
                Calendar {
                    id: calendario
                    width: (parent.width > parent.height ? parent.width * 0.6 - parent.spacing : parent.width)
                    height: (parent.height > parent.width ? parent.height * 0.6 - parent.spacing : parent.height)
                    frameVisible: true
                    weekNumbersVisible: false
                    selectedDate: new Date(2018, Data.valueDataMes - 1, Data.valueDataDia)
                    focus: true
                    minimumDate: new Date(2018, 3, 1)
                    maximumDate: new Date(2020, 0, 1)

                    style: CalendarStyle {
                        gridVisible: false
                        gridColor:  Paleta.colorPatern
                        dayDelegate: Rectangle {
                            gradient: Gradient {
                                GradientStop {
                                    position: 0.00
                                    color: styleData.selected ? "white" : (styleData.visibleMonth && styleData.valid ? Paleta.colorPatern : Paleta.colorPatern);
                                }
                                GradientStop {
                                    position: 0.50
                                    color: styleData.selected ? "#9999ff" : (styleData.visibleMonth && styleData.valid ?Paleta.colorPatern : Paleta.colorPatern);
                                }
                                GradientStop {
                                    position: 0.90
                                    color: styleData.selected ? "#6666ff" : (styleData.visibleMonth && styleData.valid ? Paleta.colorPatern : Paleta.colorPatern);
                                }
                            }

                            Label {
                                text: styleData.date.getDate()
                                anchors.centerIn: parent
                                color: styleData.valid ? "#ffffff" : "black"
                                font.family: Data.fontFamily

                            }

                            Rectangle {
                                width: parent.width
                                height: 1
                                color: Paleta.colorPatern
                                anchors.bottom: parent.bottom
                            }

                            Rectangle {
                                width: 1
                                height: parent.height
                                color: Paleta.colorPatern
                                anchors.right: parent.right
                            }
                        }
                    }
                    onClicked:
                    {
                        sendSignal(112,selectedDate.getDate())
                        sendSignal(114,selectedDate.getMonth() + 1)
                        Task.enableDevice(37,1,true)
                        timerCal.running = true
                    }
                }
            }

            Label
            {
                id: labelHour
                text: Data.hora < 10 ? "0" + String(Data.hora) + " :" : String(Data.hora) + " :"
                font.pixelSize: 64
                font.family: "digital-7"
                x: 60
                y: 400
            }
            Label
            {
                id: labelMin
                text: Data.min < 10 ? " 0" + String(Data.min) : " " + String(Data.min)
                font.pixelSize: 64
                font.family: "digital-7"
                anchors.left: labelHour.right
                anchors.top: labelHour.top
            }
            Rectangle {
                id: btn_upHour
                width: 60
                height: 25
                anchors.bottom: labelHour.top
                anchors.left: labelHour.left
                anchors.bottomMargin: 10

                Image {
                    id: imgUpHour
                    anchors.fill: parent
                    source: "CONTENTS/IMAGES/returnTwo.png"
                    asynchronous: true
                    sourceSize: Qt.size(width, height)

                }
                MouseArea {
                    anchors.fill: btn_upHour
                    hoverEnabled: true

                    onPressed: {
                        if(Number(labelHour.text.substring(0,2)) < 23)
                        {
                            if(Number(labelHour.text.substring(0,2)) < 9)
                            {
                                labelHour.text = "0" + String(Number(labelHour.text.substring(0,2)) + 1) + " :"
                            }
                            else
                            {
                                labelHour.text = String(Number(labelHour.text.substring(0,2)) + 1) + " :"
                            }
                        }
                        else
                        {
                            labelHour.text = "00 :"
                        }
                        sendSignal(116,labelHour.text.substring(0,2))
                        Task.enableDevice(37,1,true)
                        timerCal.running = true
                    }
                }
            }
            Rectangle {
                id: btn_downHour
                width: 60
                height: 25
                anchors.top: labelHour.bottom
                anchors.left: labelHour.left
                anchors.topMargin: 10

                Image {
                    id: imgDownHour
                    anchors.fill: parent
                    source: "CONTENTS/IMAGES/returnMenuOne.png"
                    asynchronous: true
                    sourceSize: Qt.size(width, height)
                }
                MouseArea {
                    anchors.fill: btn_downHour
                    hoverEnabled: true

                    onPressed: {
                        if(Number(labelHour.text.substring(0,2)) > 1)
                        {
                            if(Number(labelHour.text.substring(0,2)) <= 10)
                            {
                                labelHour.text = "0" + String(Number(labelHour.text.substring(0,2)) - 1) + " :"
                            }
                            else
                            {
                                labelHour.text = String(Number(labelHour.text.substring(0,2)) - 1) + " :"
                            }
                        }
                        else
                        {
                            labelHour.text = "23 :"
                        }
                        sendSignal(116,labelHour.text.substring(0,2))
                        Task.enableDevice(37,1,true)
                        timerCal.running = true
                    }
                }
            }
            Rectangle {
                id: btn_upMin
                width: 60
                height: 25
                anchors.bottom: labelMin.top
                anchors.left: labelMin.left
                anchors.bottomMargin: 10
                anchors.leftMargin: 20

                Image {
                    id: imgUpMin
                    anchors.fill: parent
                    source: "CONTENTS/IMAGES/returnTwo.png"
                    asynchronous: true
                    sourceSize: Qt.size(width, height)

                }
                MouseArea {
                    anchors.fill: imgUpMin
                    hoverEnabled: true

                    onPressed: {
                        if(Number(labelMin.text.substring(1,3)) < 59)
                        {
                            if(Number(labelMin.text.substring(1,3)) < 9)
                            {
                                labelMin.text = " 0" + String(Number(labelMin.text.substring(1,3)) + 1) + " "
                            }
                            else
                            {
                                labelMin.text = " " + String(Number(labelMin.text.substring(1,3)) + 1) + " "
                            }
                        }
                        else
                        {
                            labelMin.text = " 00"
                        }
                        sendSignal(118,labelMin.text.substring(1,3))
                        Task.enableDevice(37,1,true)
                        timerCal.running = true
                    }
                }
            }
            Rectangle {
                id: btn_downMin
                width: 60
                height: 25
                anchors.top: labelMin.bottom
                anchors.left: labelMin.left
                anchors.topMargin: 10
                anchors.leftMargin: 20

                Image {
                    id: imgDownMin
                    anchors.fill: parent
                    source: "CONTENTS/IMAGES/returnMenuOne.png"
                    asynchronous: true
                    sourceSize: Qt.size(width, height)
                }
                MouseArea {
                    anchors.fill: btn_downMin
                    hoverEnabled: true

                    onPressed: {
                        if(Number(labelMin.text.substring(1,3)) > 1)
                        {
                            if(Number(labelMin.text.substring(1,3)) <= 10)
                            {
                                labelMin.text = " 0" + String(Number(labelMin.text.substring(1,3)) - 1)
                            }
                            else
                            {
                                labelMin.text = " " + String(Number(labelMin.text.substring(1,3)) - 1)
                            }
                        }
                        else
                        {
                            labelMin.text = " 59"
                        }

                        sendSignal(118,labelMin.text.substring(1,3))
                        Task.enableDevice(37,1,true)
                        timerCal.running = true
                    }
                }
            }
        }
        Page{
            id: pageUpload
            visible: false

            Column{
                x: 50
                spacing: 25
                RowLayout{
                    spacing: 25
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Rectangle {
                        id: btn_update_sw
                        width: 90
                        height: 90

                        Image {
                            id: imgUpdateSW
                            anchors.fill: parent
                            source: "CONTENTS/IMAGES/usbDownload.png"
                            asynchronous: true
                            sourceSize: Qt.size(width, height)
                        }
                        MouseArea {
                            anchors.fill: imgUpdateSW
                            hoverEnabled: true
                            onPressed: {
                                popupUpdate.msgPopup = "Deseja realizar a atualização de software?"
                                uploadType = "sw"
                                popupUpdate.visible = true
                            }
                        }
                    }
                    Text {
                        text: qsTr("Atualização de Software")
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                }
                RowLayout{
                    spacing: 25
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Rectangle {
                        id: btn_update_db
                        width: 90
                        height: 90

                        Image {
                            id: imgUpdateDB
                            anchors.fill: parent
                            source: "CONTENTS/IMAGES/usbDownload.png"
                            asynchronous: true
                            sourceSize: Qt.size(width, height)
                        }
                        MouseArea {
                            anchors.fill: imgUpdateDB
                            hoverEnabled: true
                            onPressed: {
                                popupUpdate.msgPopup = "Deseja realizar o banco de dados?"
                                uploadType = "db"
                                popupUpdate.visible = true
                            }
                        }
                    }
                    Text {
                        text: qsTr("Atualização do Banco de Dados")
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                }
                RowLayout{
                    spacing: 25
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Rectangle {
                        id: btn_updateVideos
                        width: 90
                        height: 90

                        Image {
                            id: imgUpdateVideos
                            anchors.fill: parent
                            source: "CONTENTS/IMAGES/usbDownload.png"
                            asynchronous: true
                            sourceSize: Qt.size(width, height)
                        }
                        MouseArea {
                            anchors.fill: imgUpdateVideos
                            hoverEnabled: true
                            onPressed: {
                                popupUpdate.msgPopup = "Deseja carregar novos vídeos?"
                                uploadType = "vd"
                                popupUpdate.visible = true
                            }
                        }
                    }
                    Text {
                        text: qsTr("Carregamento de videos")
                        font.family: "Arial"
                        color: "black"
                        font.pointSize: Data.fontLabelSize
                        anchors.margins: 2
                    }
                }
            }
        }
    }
    TabBar{
        y: 950
        x: 20
        id: tabBarEng
        currentIndex: swipe.currentIndex
        visible: Data.alarmActive ? false : true
        width: parent.width

        Flickable
        {
            flickDeceleration: 0.2
        }

        TabButton{
            id: tabDevices
            text: qsTr("Eng: 01")
            visible: true

            contentItem: Text {
                text: qsTr("Operador")
                font.family: "Arial"
                opacity: enabled ? 1.0 : 0.3
                color: tabDevices.checked ? "#667ab3" : "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 80
                implicitHeight: 50
                opacity: enabled ? 1 : 0.3
                color: tabDevices.checked ? "white" : "#667ab3"
                border.color: tabDevices.checked ? "#667ab3": "white"
                border.width: 1
                radius: 2
            }
            width: 160
        }

        TabButton{
            id: tabControl
            text: qsTr("Supervisor")
            visible: Data.userLoginAdmin || Data.userLoginSuper ? true : false

            contentItem: Text {
                text: tabControl.text
                font.family: "Arial"
                opacity: enabled ? 1.0 : 0.3
                color: tabControl.checked ? "#667ab3" : "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 80
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                color: tabControl.checked ? "white" : "#667ab3"
                border.color: tabControl.checked ? "#667ab3": "white"
                border.width: 1
                radius: 2
            }
            width: 160
        }

        TabButton{
            id: tabOthers
            text: qsTr("Engenharia Maq.")
            visible: Data.userLoginAdmin ? true : false

            contentItem: Text {
                text: tabOthers.text
                font.family: "Arial"
                opacity: enabled ? 1.0 : 0.3
                color: tabOthers.checked ? "#667ab3" : "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 80
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                color: tabOthers.checked ? "white" : "#667ab3"
                border.color: tabOthers.checked ? "#667ab3": "white"
                border.width: 1
                radius: 2
            }
            width: 160
        }

        TabButton{
            id: tabDateTime
            text: qsTr("Data/Hora")
            visible: Data.userLoginAdmin ? true : false

            contentItem: Text {
                text: tabDateTime.text
                font.family: "Arial"
                opacity: enabled ? 1.0 : 0.3
                color: tabDateTime.checked ? "#667ab3" : "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 80
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                color: tabDateTime.checked ? "white" : "#667ab3"
                border.color: tabDateTime.checked ? "#667ab3": "white"
                border.width: 1
                radius: 2
            }
            width: 160
        }

        TabButton{
            id: tabUpload
            text: qsTr("Upload")
            visible: Data.userLoginAdmin ? true : false

            contentItem: Text {
                text: tabUpload.text
                font.family: "Arial"
                opacity: enabled ? 1.0 : 0.3
                color: tabUpload.checked ? "#667ab3" : "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 80
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                color: tabUpload.checked ? "white" : "#667ab3"
                border.color: tabUpload.checked ? "#667ab3": "white"
                border.width: 1
                radius: 2
            }
            width: 160
        }
    }

    PopupSmall {
        id: popupSmallLoad

        width: parent.width
        height: parent.height

        visible: false
        x: 20
        y: 16

        z: 90

        onCancelClicked: {
            visible = false
        }

        onOkClicked: {
            visible = false
            Task.restoreParams()
            loaderEng.sourceComponent = compNull
            loaderEng.source = "EngFabrica01.qml"
        }
    }

    PopupSmall {
        id: popupUpdate

        width: parent.width
        height: parent.height
        x: 20
        y: 16
        visible: false
        z: 90
        onCancelClicked: {
            visible = false
        }
        onOkClicked: {
            visible = false
            if(uploadType === "sw")
                Task.updateSoftware()
            else if(uploadType === "db")
                Task.importCSV()
            else if(uploadType === "vd")
                Task.loadVideos()
        }
    }

    PopupSmall {
        id: popupSmall

        width: parent.width
        height: parent.height

        visible: false
        x: 20
        y: 16

        z: 90

        onCancelClicked: {
            visible = false
        }

        onOkClicked: {
            visible = false
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





