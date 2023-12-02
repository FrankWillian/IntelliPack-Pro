import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
//import com.opuspac.ihm 1.0
import QtQuick.VirtualKeyboard 2.1  // QtFreeVirtualKeyboard
import 'JSmain.js' as JSmain

import "."

//ApplicationWindow {
Window {
    id: root

    Timer{

        id: timerCombo
        interval: 2000
        running: Data.recComboCarregando
        repeat: false
        onTriggered: {
            Data.recComboCarregando = false
        }
    }

    // Variaveis banco de dados
    property string dbId: "MyDatabase"
    property string dbVersao: "1.0.0"
    property string dbDescricao: "Banco de dados"
    property int dbSize: 1000000
    property var db
    signal escClicked

    visible: true
    //width: Screen.desktopAvailableWidth
    //height: Screen.desktopAvailableHeight

    width: 480
    height: 800

    property var statusMsg

    property string msgComp

    // Propriedades locais ou globais
    property date dateTime: new Date()


    Component.onCompleted: {

        JSmain.executeBanco();

        loaderMain.sourceComponent = compNull
        loaderMain.sourceComponent = compLogo
        loaderMain.width = root.width

        if(!Data.firstCarregando){
            Data.recAtualiza = true
            Data.firstCarregando = false

        }

        /* Forço o VirtualKeyboard abrir como numerico */
        //inputPanel.pimpl.symbolModifier = true;
        //inputPanel.pimpl.shiftModifier = false;
    }

    function sendSignal (register, value)
    {
        Data.envioRun = true
        Task.writeParamt(Number(register),Number(value))
        Data.envioRun = false
    }

    function defaulLoader()
    {
        loaderMain.sourceComponent = compNull
        loaderMain.sourceComponent = compLogo
    }

    Connections {
        target: Task

        onReadyData:    Data.dataModBus = data
        onReadyMD0:     Data.contaSet = data
        onReadyMD1:     Data.posicaoSelagem = data
        onReadyMD2:     Data.tempoSelagem = data
        onReadyMD3:     {

            Data.esteiraAtraso = data
            if(Data.recAtualiza){
                Task.writeParamt(Number(6),Number(Data.esteiraAtraso))
            }

        }
        onReadyMD4:     {

            Data.inicioAtraso = data
            if(Data.recAtualiza){
                Task.writeParamt(Number(8),Number(Data.inicioAtraso))
            }

        }
        onReadyMD5:     {

            Data.ampolaAtraso = data
            if(Data.recAtualiza){
                Task.writeParamt(Number(10),Number(Data.ampolaAtraso))
            }

        }
        onReadyMD6:     {

            Data.filmeParada = data
            if(Data.recAtualiza){
                Task.writeParamt(Number(12),Number(Data.filmeParada))
            }

        }
        onReadyMD7:     {

            Data.arAtraso = data
            if(Data.recAtualiza){
                Task.writeParamt(Number(14),Number(Data.arAtraso))
            }

        }
        onReadyMD8:     {

            Data.duracaoInjAr = data
            if(Data.recAtualiza){
                Task.writeParamt(Number(16),Number(Data.duracaoInjAr))
            }

        }
        onReadyMD9:     Data.tpoPortAberta = data
        onReadyMD10:    {

            Data.esteiraParada = data//
            if(Data.recAtualiza){
                Task.writeParamt(Number(20),Number(Data.esteiraParada))
            }

        }
        onReadyMD11:    {

            Data.portinholaParada = data
            if(Data.recAtualiza){
                Task.writeParamt(Number(22),Number(Data.portinholaParada))
            }

        }
        onReadyMD12:    Data.esteiraVeloc = data
        onReadyMD13:    Data.esteiraAcc = data
        onReadyMD14:    Data.esteiraDec = data
        onReadyMD15:    Data.portinholaVeloc = data
        onReadyMD16:    Data.portinholaAcc = data
        onReadyMD17:    Data.portinholaDec = data
        onReadyMD18:    Data.desligaAr = data

        onReadyMD26:    Data.portinholaVelocMotion = data
        onReadyMD27:    Data.portinholaAccMotion = data
        onReadyMD28:    Data.portinholaDecMotion = data
        onReadyMD29:    Data.portinholaRelatMotion = data
        onReadyMD30:    Data.tracaoVelocMotion = data
        onReadyMD31:    Data.tracaoAccMotion = data
        onReadyMD32:    Data.tracaoDecMotion = data
        onReadyMD33:    Data.tracaoRelatMotion = data
        onReadyMD34:    Data.tracaoVeloc = data
        onReadyMD35:    Data.tracaoAcc = data
        onReadyMD36:    Data.tracaoDec = data
        onReadyMD37:    Data.selagVeloc = data
        onReadyMD38:    Data.selagAcc = data
        onReadyMD39:    Data.selagDec = data
        onReadyMD40:    Data.selagVelocMotion = data
        onReadyMD41:    Data.selagAccMotion = data
        onReadyMD42:    Data.selagDecMotion = data
        onReadyMD43:    Data.selagRelatMotion = data
        onReadyMD44:    Data.esteiraVelocMotion = data
        onReadyMD45:    Data.esteiraAccMotion = data
        onReadyMD46:    Data.esteiraDecMotion = data
        onReadyMD47:    Data.esteiraRelatMotion = data
        onReadyMD48:    Data.receita = data
        onReadyMD49:    Data.produtiMedia = data
        onReadyMD50:    Data.contaGeral = data
        onReadyMD51:    Data.contaAtual = data
        onReadyMD52:    Data.infoHrsEnerg = data
        onReadyMD53:    Data.infoMinEnerg = data
        onReadyMD54:    Data.infoHorasProd = data
        onReadyMD55:    Data.infoMinProd = data
        onReadyMD56:    Data.dataDia = data
        onReadyMD57:    Data.dataMes = data
        onReadyMD58:    Data.hora = data
        onReadyMD59:    Data.min = data
        onReadyMD60:    Data.velocMedia = data

        onReadyTemp:    Data.valueCoreTemp = data
        onConexao:      Data.conexao = erro

        onReadyAlarm:
        {
            //print("Alarme gerado: "+data)
            if (data === "00") {
                Data.alarmActive = false
                popupAlarm.visible = false

            }
            else if(data === "07")
            {
                if(!Data.alarmActive){
                    Data.alarmActive = true
                    popupAlarm.msgTitulo = "Alarme 07 - Porta de proteção aberta"
                    popupAlarm.msgPopup =   "1) Feche a porta e pressione o botão RESET.\n\n
2) Verifique  se o fechamento da porta está correto.\n\n
3) Verifique o funcionamento do sensor magnético e do relé de segurança."
                    popupAlarm.visible = true
                }
            }
            else {
                Data.alarmActive = true
                switch(data) {
                case "01":
                    popupAlarm.msgTitulo = "Alarme 01 - Falha na leitura da fotocélula"
                    popupAlarm.msgPopup =   "1) Verifique se a embalagem possui seta/tarja e está alinhada ao centro da máquina.\n\n
2) O led OUT do sensor pisca quando a seta/tarja passa pela fibra óptica.\n\n
3) Faça a calibração do sensor de fotocélula."
                    break;
                case "02":
                    popupAlarm.msgTitulo = "Alarme 02 - Alarme home da portinhola"
                    popupAlarm.msgPopup = "1) Verifique o funcionamento do motor de selagem e sensor de home.\n\n
2) Verifique se há travamento mecânico no conjunto.\n"
                    break;
                case "03":
                    popupAlarm.msgTitulo = "Alarme 03 - Final da quantidade setada"
                    popupAlarm.msgPopup = "1) Resetar a contagem atual e reiniciar o ciclo.\n"
                    break;
                case "04":
                    popupAlarm.msgTitulo = "Alarme 04 - Presença de produto na selagem"
                    popupAlarm.msgPopup =   "1) Verifique se há produto entre os mordentes.\n\n
2) Verifique se o produto é compatível com a embalagem.\n\n
3) Faça a calibração do sistema de segurança."
                    break;
                case "05":
                    popupAlarm.msgTitulo =  "Alarme 05 - Falha no movimento de home"
                    popupAlarm.msgPopup =   "1) Verifique o funcionamento do motor de selagem e sensor de home.\n\n
2) Verifique se há travamento mecânico no conjunto de selagem.\n"
                    break;
                case "06":
                    popupAlarm.msgTitulo = "Alarme 06 - Falha no conjunto de corte"
                    popupAlarm.msgPopup =   "1) Verifique o funcionamento do MOTOR do corte.\n\n
2) Verifique o funcionamento do SENSOR do conjunto do corte.\n\n
3) Verifique o funcionamento do relé do corte."
                    break;
                case "08":
                    popupAlarm.msgTitulo = "Alarme 08 - Botão de emergência acionado"
                    popupAlarm.msgPopup =   "1) Gire o botão de emergência no sentido horário e solte-o.\n\n
2) Acione o botão RESET para retirar a falha.\n\n
3) Reserva.\n"
                    break;
                case "09":
                    popupAlarm.msgTitulo = "Alarme 09 - Falha no sensor de fim de selagem"
                    popupAlarm.msgPopup =   "1) Verifique se o mordente móvel está avançando até encostar no mordente quente, caso não esteja ajuste o parâmetro Posição de selagem.\n
2) Verifique o sensor de fim de selagem..\n"
                    break;
                case "10":
                    popupAlarm.msgTitulo = "Alarme 10 - Sensor externo de segurança produto desativado"
                    popupAlarm.msgPopup =  "1) Verifique o funcionamento do sensor externo da segurança do produto e faça a calibração do mesmo.\n"
                    break;
                case "11":
                    popupAlarm.msgTitulo = "Alarme 11 - Falha na impressora"
                    popupAlarm.msgPopup =  "1) Verifique o status do impresssor e faça as correções necessárias.\n"
                    break;
                case "12":
                    popupAlarm.msgTitulo = "Alarme 12 - Falha de temperatura"
                    popupAlarm.msgPopup =   "1) Aguarde que a temperatura no controlador se equalize.\n
2) Caso persista a falha, verifique o funcionamento do controlador de temperatura, relé de estado sólido, resistências e termopar.\n"
                    break;
                case "13":
                    popupAlarm.msgTitulo = "Alarme 13 - Reserva"
                    popupAlarm.msgPopup = "1) Reserva.\n"
                    break;
                case "14":
                    popupAlarm.msgTitulo = "Alarme 14 - Tamanho do formato incompatível"
                    popupAlarm.msgPopup =  "1) Verifique se a medida da bobina é a mesma selecionada na receita..\n\n
2) A passagem do filme esta correta?.\n\n
3) Diminua a pressão da mola da embreagem.\n"
                    break;
                case "15":
                    popupAlarm.msgTitulo = "Alarme 15 - Falha de produto no alimentador"
                    popupAlarm.msgPopup = "1) Verifique se há ampolas no alimentador.\n\n
2) Verifique o funcionamento do motor.\n\n"

                    break;
                }
                popupAlarm.visible = true
            }
        }
    }


    // Rotacao Display
    Item {
        id: displayRef
        rotation: 270
        width: Screen.desktopAvailableHeight
        height: Screen.desktopAvailableWidth

        anchors.centerIn: parent

        // Titulo da Tela
        Rectangle{
            id: titulo
            x: 12
            y: 12
            color: "#667ab3"
            width: 770
            implicitHeight: 80
            opacity: 1
            border.color: "#667ab3"
            border.width: 2
            radius: 3

            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: "black"
                horizontalOffset: 4
                verticalOffset: 4
            }

            Text {
                id: tituloHome
                text: qsTr("OPUS35")
                color: "white"
                font.family: "Arial"
                font.pixelSize: 36
                opacity:  1
                anchors.centerIn: titulo
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }

        // Component para aparecer o Logo
        Component {
            id: compLogo

            Rectangle {
                anchors.centerIn: loaderMain
                width: root.width*0.8; height: root.height*0.8
                color: "transparent"


                Image {
                    id: imgLogoInobag
                    x: 125
                    y: 350
                    source: Data.valueLogo
                    fillMode: Image.PreserveAspectFit
                    width: parent.width*0.4; height: parent.height*0.4
                    sourceSize: Qt.size(width,height)
                    asynchronous: true
                }

                Text{
                    x: -6
                    y: 450
                    id: textBarcode
                    visible: Data.barcodeCtr
                    color: Paleta.fontLabel
                    font.family: Data.fontFamily
                    font.pointSize: Data.fontLabelSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    text: qsTr("Medicamento: ")
                }

                Text{
                    x: 119
                    y: 452
                    id: nomeMedicamento
                    visible: Data.barcodeCtr
                    color: Paleta.fontValue
                    font.family: Data.fontFamily
                    font.pointSize: Data.fontValueSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    text: Data.medicamento
                }

                Rectangle {
                    id: btn_impressora
                    width: 70
                    height: 70
                    x: 380
                    y: 150
                    visible: false

                    Image {
                        id: imgImpressora
                        anchors.fill: parent
                        source: "CONTENTS/IMAGES/printer.png"
                        sourceSize: Qt.size(width, height)

                        asynchronous: Data.impressoraVisivel
                    }

                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            btn_impressora.scale = 0.95
                            btn_impressora.color = "transparent"
                        }

                        onReleased: {
                            btn_impressora.scale = 1.0
                            btn_impressora.color = "transparent"

                            loaderMain.width = root.width-(lvMenu.height)
                            loaderMain.source = "Impressora.qml"
                            tituloHome.text = qsTr("IMPRESSORA")
                            tituloHome.x = 120
                        }
                    }
                }

                Rectangle {
                    id: btn_rolo
                    width: 90
                    height: 90
                    x: 670
                    y: 60

                    Connections{
                        target: Task

                        onReadyMD25:
                        {
                            Data.estado = data

                            if(Data.estado === "1" && Data.roloSolto)
                            {
                                imgRolo.source = "CONTENTS/IMAGES/lockNew.png"
                                Task.enableDevice(36,2,false)
                                Task.writeParamt(Number(50),Number(Data.estado))
                                Data.roloSolto = false

                            }
                        }

                    }
                    Image {
                        id: imgRolo
                        anchors.fill: parent
                        source: Data.valueRoloSolto === "20" ? "CONTENTS/IMAGES/lockNew.png" : "CONTENTS/IMAGES/unlock.png"
                        sourceSize: Qt.size(width, height)
                        asynchronous: true

                        Text {
                            id: textRolo
                            font.pointSize: 10
                            font.family: "Arial"
                            font.bold: Font.Thin
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignHCenter
                            anchors.centerIn: parent
                            //text: "Rolo\nPreso"
                        }
                    }
                    MouseArea {
                        anchors.fill: btn_rolo
                        hoverEnabled: true

                        onPressed: {
                            if(!Data.roloSolto)
                            {
                                Data.roloSolto = true
                                imgRolo.source = "CONTENTS/IMAGES/unlock.png"
                                Task.enableDevice(36,2,true)

                            }
                            else
                            {
                                Data.roloSolto = false
                                imgRolo.source = "CONTENTS/IMAGES/lockNew.png"
                                Task.enableDevice(36,2,false)

                            }
                        }
                    }
                }

                Row {
                    x: 285
                    y: 750
                    spacing: 200

                    Row{

                        spacing: 20

                        Text {
                            opacity:  1
                            y: 28
                            color: rec_SetConta.y > 500 ? "transparent" : "transparent"
                            font.family: Data.fontFamily
                            font.pointSize: Data.fontLabelSize
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                            text: qsTr("Reserva:")
                        }

                        Rectangle{
                            id: posFilme
                            y: 25
                            width: 80
                            height: 30
                            border.width: 2
                            border.color: rec_SetConta.y > 500 ? "transparent" : "transparent"
                            color: "transparent"
                            radius: 4


                        }
                    }

                    Column{
                        spacing: 25

                        Rectangle {
                            id: btn_tracao
                            width: 90
                            height: 90
                            visible: Data.alarmActive ? false : true

                            Image {
                                id: imgTracao
                                anchors.fill: parent
                                source: "CONTENTS/IMAGES/escrever.png"
                                sourceSize: Qt.size(width, height)
                                asynchronous: true

                                Text {
                                    id: textEscrito
                                    font.pointSize: 16
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
                                anchors.fill: btn_tracao
                                hoverEnabled: true

                                onPressed: {
                                    imgTracao.source = "CONTENTS/IMAGES/escritoVerde.png"
                                    Task.enableDevice(36,1,true)
                                    timerTraction.start()
                                }

                                onReleased:{
                                    imgTracao.source = "CONTENTS/IMAGES/escrever.png"
                                    Task.enableDevice(36,1,false)
                                }

                                onExited: {
                                    imgTracao.source = "CONTENTS/IMAGES/escrever.png"
                                    Task.enableDevice(36,1,false)
                                }
                            }

                        }

                        Rectangle {
                            id: btn_ampola
                            width: 90
                            height: 90
                            visible: Data.alarmActive ? false : true

                            Image {
                                id: imgApola
                                anchors.fill: parent
                                source: "CONTENTS/IMAGES/escrever.png"
                                sourceSize: Qt.size(width, height)
                                asynchronous: true

                                Text {
                                    id: textApola
                                    font.pointSize: 16
                                    font.family: "Arial"
                                    font.bold: Font.Medium
                                    color: "white"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignHCenter
                                    anchors.centerIn: parent
                                    text: "Jog\nAmpola"

                                }
                            }

                            MouseArea {
                                anchors.fill: btn_ampola
                                hoverEnabled: true

                                onPressed: {
                                    imgApola.source = "CONTENTS/IMAGES/escritoVerde.png"
                                    Task.enableDevice(37,2,true)

                                }

                                onReleased:{
                                    imgApola.source = "CONTENTS/IMAGES/escrever.png"
                                    Task.enableDevice(37,2,false)
                                }

                                onExited: {
                                    imgApola.source = "CONTENTS/IMAGES/escrever.png"
                                    Task.enableDevice(37,2,false)
                                }
                            }

                        }


                    }


                    Timer {
                        id: timerTraction
                        interval: 5000
                        onTriggered: {
                            imgTracao.source = "CONTENTS/IMAGES/escrever.png"
                            Task.enableDevice(36,1,false)
                        }
                    }
                }

                Rectangle {
                    x: 90
                    y: 915

                    implicitWidth: 240
                    implicitHeight: 46
                    color: "#667ab3"
                    radius: 2

                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        color: "black"
                        horizontalOffset: 2
                        verticalOffset: 2
                    }

                    Text {
                        font.family: "Arial"
                        opacity:  1
                        color:  "white"
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        font.pointSize: Data.fontLabelSize
                        text: qsTr("Conta")
                    }
                }

                Text {
                    opacity:  1
                    //y: txtInt_conta.activeFocus && inputPanel.y < 600 ? inputPanel.y - 150 : 569
                    y: 992
                    color: Paleta.fontLabel
                    font.family: Data.fontFamily
                    font.pointSize: Data.fontLabelSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    text: qsTr("Set:")

                    Behavior on y {
                        NumberAnimation { easing.type: Easing.InBack; easing.amplitude: 5.0; easing.period: 19.0; duration: 510 }
                    }
                }


                Rectangle{
                    id: rec_SetConta
                    y: 990
                    //y: txtInt_conta.activeFocus && inputPanel.y < 600 ? inputPanel.y - 150 : 565
                    x: 50

                    width: 100
                    height: 30
                    border.width: 2
                    border.color: "#667ab3"
                    color: "transparent"
                    radius: 4

                    Behavior on y {
                        NumberAnimation { easing.type: Easing.InBack; easing.amplitude: 5.0; easing.period: 19.0; duration: 510 }
                    }

                    TextInput {
                        id: txtInt_conta
                        anchors.fill: rec_SetConta
                        font.pointSize: Data.fontValueSize
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        echoMode: TextInput.Normal
                        color: "black"
                        /* Configura para abrir o teclado virtual na opção numerico*/
                        inputMethodHints: Qt.ImhPreferNumbers | Qt.ImhDigitsOnly | Qt.ImhFormattedNumbersOnly;
                        text: Data.contaSet
                        validator: IntValidator {bottom: 0; top: 9999}

                        onEditingFinished:  {
                            if(Number(text) < 0) { text = "0" }
                            if(Number(text) > 9999) { text = "9999" }
                            sendSignal(0, Number(text))
                        }
                        onFocusChanged: {
                            if(focus === false)
                            {
                                if(text == "") { text = Data.valueContaSet}
                                if(Number(text) < 0) { text = "0" }
                                if(Number(text) > 9999) { text = "9999" }
                                sendSignal(0, Number(text))
                            }
                            else
                            {
                                text = ""
                            }
                        }
                        onDisplayTextChanged:
                        {
                            var n = text.search("\n")
                            if(n >= 0)
                            {
                                text = text.substring(0,text.length - 1)
                                if(text == "") { text = Data.valueContaSet}
                                if(Number(text) < 0) { text = "0" }
                                if(Number(text) > 9999) { text = "9999" }
                                sendSignal(0, Number(text))
                            }
                        }
                    }
                }

                Text {
                    id: labelContaAtual
                    width: 37
                    //y: btn_zeraConta.y + 30
                    y: 992
                    x: 220
                    color: Paleta.fontLabel
                    font.family: Data.fontFamily
                    font.pointSize: Data.fontLabelSize
                    font.bold: Font.Thin
                    horizontalAlignment: Text.AlignLeft
                    text: qsTr("Atual:")
                }
                Text {
                    id: inputContaAtual
                    //y: btn_zeraConta.y + 30
                    y: 990
                    x: labelContaAtual.x + 70
                    color: Paleta.fontValue
                    font.family: Data.fontFamily
                    font.pointSize: Data.fontValueSize
                    font.bold: Font.Thin
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignHCenter
                    text: Data.contaAtual

                }

                Rectangle {
                    id: btn_zeraConta
                    width: 90
                    height: 90
                    y: 640
                    x: 670
                    visible: Data.alarmActive ? false : true

                    Image {
                        id: imgZera
                        anchors.fill: parent
                        source: "CONTENTS/IMAGES/resetNew.png"
                        sourceSize: Qt.size(width, height)
                        asynchronous: true
                    }

                    MouseArea {
                        anchors.fill: btn_zeraConta
                        hoverEnabled: true

                        onPressed: {
                            popupSmall1.visible = true
                            popupSmall1.msgPopup = "Deseja realmente zerar todos valores?"
                        }
                    }
                }
            }
        }

        PopupSmall {
            id: popupSmall1

            width: parent.width*2.8
            height: parent.height*1.8

            y:  parent.height*0.12
            x:  parent.height*0.05

            visible: false

            z: 90

            onCancelClicked: {
                Task.enableDevice(36,0,false)
                popupSmall1.visible = false
            }

            onOkClicked: {
                Task.enableDevice(36,0,true)
                popupSmall1.visible = false
                popupTimer.running = true
            }

            Timer{
                id: popupTimer
                interval: 300
                running: false
                repeat: false
                onTriggered: Task.enableDevice(36,0,false)
            }

        }

        // Component para limpar Loader
        Component { id: compNull; Item {} }

        // Tela com cor random de fundo apenas para testes de carregando dinamico com Loader
        Component {
            id: compBlank

            Rectangle {
                anchors.centerIn: loaderMain
                width: root.width*0.8; height: root.height*0.8
                color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)

                Text {
                    anchors.centerIn: parent
                    font.pointSize: 40
                    color: "white"
                    text: msgComp
                }
            }
        }

        // Componente de cada menu
        Component {
            id: itemsMenu
            Row{

                Rectangle {
                    id: rectItem
                    width: 90
                    height: 90
                    radius: 4
                    color: "transparent"

                    Image {
                        id: icon
                        anchors.fill: rectItem
                        source: iconPath
                        width: 70; height: 70
                        sourceSize: Qt.size(width, height)
                        asynchronous: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            rectItem.scale = 0.95
                            rectItem.color = "transparent"
                        }

                        onReleased: {
                            rectItem.scale = 1.0
                            rectItem.color = "transparent"

                            if(!Data.alarmActive){

                                if (name == "Home")
                                {
                                    loaderMain.sourceComponent = compNull
                                    loaderMain.sourceComponent = compLogo
                                    loaderMain.width = root.width
                                    tituloHome.text = qsTr("HOME")
                                    tituloHome.x = 200
                                    if(Data.userLoginSuper === true){
                                        Data.userLoginSuper = false
                                        Data.nameLoginCarregado = ""
                                    }
                                }

                                else if (name == "")
                                {

                                    var compPopup = Qt.createComponent("Popup.qml");
                                    loaderMain.width = root.width-(lvMenu.width+lvMenu.spacing*2)
                                    loaderMain.sourceComponent = compPopup
                                    loaderMain.item.msgTitulo = "Titulo"
                                    loaderMain.item.msgPopup = "Lorem Ipsum sobreviveu não só a cinco \
                             séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado."
                                    loaderMain.item.onCancelClicked.connect( defaulLoader )
                                    loaderMain.item.onOkClicked.connect( defaulLoader )


                                    /*
                            for (var i=0; i<5; i++) {
                                var object = component.createObject(container);
                                object.x = (object.width + 10) * i;
                            }
                            */

                                }
                                else if (name == "Arquivos")
                                {
                                    loaderMain.width = root.width-(lvMenu.height)
                                    loaderMain.source = "Arquivos.qml"
                                    tituloHome.text = qsTr("FORMATOS")
                                    tituloHome.x = 150
                                }
                                else if (name == "AlarmView")
                                {
                                    loaderMain.width = root.width-(lvMenu.height)
                                    loaderMain.source = "AlarmView.qml"
                                    tituloHome.text = qsTr("ALARMES")
                                    tituloHome.x = 150
                                }
                                else if (name == "Engenharia")
                                {
                                    loaderMain.width = root.width-(lvMenu.height)
                                    loaderMain.source = "EngFabrica01.qml"
                                    tituloHome.text = qsTr("ENGENHARIA")
                                    tituloHome.x = 120

                                }

                                else if (name == "Info")
                                {
                                    loaderMain.width = root.width-(lvMenu.height)
                                    loaderMain.source = "Informacao.qml"
                                    tituloHome.text = qsTr("INFORMAÇÃO")
                                    tituloHome.x = 120

                                }

                                /*
                        else if (name == "Engenharia")
                        {
                            loaderMain.width = root.width-(lvMenu.width+lvMenu.spacing*2)
                            loaderMain.source = "ModbusIO.qml"
                        }
                        */
                                else {
                                    msgComp = index
                                    loaderMain.width = root.width-(lvMenu.width+lvMenu.spacing*2)
                                    loaderMain.sourceComponent = compNull
                                    loaderMain.sourceComponent = compBlank
                                }
                            }
                        }
                    }
                }
            }
        }

        // ListView do Menu lateral esquerdo
        ListView {
            id: lvMenu
            anchors.bottom: footer.top
            x: 25
            anchors.margins: 10
            z: 90
            width: 850
            height: 90
            cacheBuffer: 5
            clip: true
            spacing: 76
            orientation: ListView.Horizontal

            //model: 10

            model: MenuModel {}
            delegate: itemsMenu
        }

        // Loader: Responsavel por carregar qualquer conteudo (Componente, .QML) no centro da aplicação
        Loader {
            id: loaderMain
            anchors.top: root.top
            anchors.left: root.left
            height: root.height-(footer.height+footer.height)
            width: root.width
            x: 20
            y: 80
        }

        // Popup dos Alarmes
        PopupAlarm {
            id: popupAlarm

            width: parent.width
            height: parent.height


            visible: false

            z: 90

            onCancelClicked: {
                // Só deixo fechar se não ocorrer mais alarme
                if (!Data.alarmActive) {
                    popupAlarm.visible = false
                }
            }

            onOkClicked: {
                // Só deixo fechar se não ocorrer mais alarme
                if (!Data.alarmActive) {
                    popupAlarm.visible = false
                }
            }
        }

        PopupSmall {
            id: popupSmall

            width: parent.width*2.8
            height: parent.height*1.2
            y:  parent.height*0.12
            x:  parent.height*0.05
            visible: false
            z: 81

            onCancelClicked: {
                Data.nameLoginDigitado = ""
                Data.passwordDigitado = ""
                Data.nameLoginCarregado = ""
                Data.userLoginAdmin = false
                Data.userLoginSuper = false
                popupSmall.visible = false
                popupLogin.visible = true
            }

            onOkClicked: {
                Data.nameLoginDigitado = ""
                Data.passwordDigitado = ""
                Data.nameLoginCarregado = ""
                Data.userLoginAdmin = false
                Data.userLoginSuper = false
                popupSmall.visible = false
                popupLogin.visible = true
            }
        }

        // Popup dos Alarmes
        LoginUser {
            id: popupLogin

            width: parent.width*2.1
            height: parent.height*1
            y:  parent.height*0.12
            x:  parent.height*0.05

            visible: false

            z: 80

            onCancelClicked: {
                popupLogin.visible = false
                inputPanel.state = ""
            }

            onLogin: {

                if(Data.nameLoginDigitado == Data.nameLoginAdmin && Data.passwordDigitado == Data.passwordAdmin){
                    popupLogin.visible = false
                    Data.nameLoginDigitado = ""
                    Data.passwordDigitado = ""
                    Data.nameLoginCarregado = Data.nameLoginAdmin
                    Data.userLoginAdmin = true
                    Data.userLoginSuper = false
                    //Recarrega a página para não ficar com o column desalinhado
                    loaderMain.sourceComponent = compNull
                    loaderMain.source = "EngFabrica01.qml"
                    inputPanel.state = ""
                }
                else if(Data.nameLoginDigitado == Data.nameLoginSuper && Data.passwordDigitado == Data.passwordSuper){
                    popupLogin.visible = false
                    Data.nameLoginDigitado = ""
                    Data.passwordDigitado = ""
                    Data.nameLoginCarregado = Data.nameLoginSuper
                    Data.userLoginSuper = true
                    Data.userLoginAdmin = false
                    //Recarrega a página para não ficar com o column desalinhado
                    loaderMain.sourceComponent = compNull
                    loaderMain.source = "EngFabrica01.qml"
                    inputPanel.state = ""
                }
                else
                {
                    popupSmall.visible = true
                    popupLogin.visible = false
                    popupSmall.msgPopup = "Usuário ou senha incorreto.\nTente novamente"
                }
            }

            onLogOut: {
                Data.nameLoginCarregado = ""
                Data.userLoginAdmin = false
                Data.userLoginSuper = false
                Data.nameLoginDigitado = ""
                Data.passwordDigitado = ""
                popupLogin.visible = false
                loaderMain.sourceComponent = compNull
                loaderMain.source = "EngFabrica01.qml"

            }
        }



        // Rodape
        Rectangle {
            id: footer
            width: root.width
            height: 40
            anchors.bottom: parent.bottom
            color: Paleta.bgFooter
            x: 40

            property int rodapeFontLabelSize: 16
            property int rodapeFontValueSize: 14


            Row{
                spacing: 90
                Row {
                    spacing: 15
                    // Data e hora
                    Text {
                        color: Paleta.fontLabelFooter
                        font.pointSize: footer.rodapeFontLabelSize
                        font.bold: Font.Thin
                        font.family: "Arial"
                        text: "Data:"
                    }

                    Text {
                        id: labelDateTime
                        color: Paleta.fontValueFooter
                        font.pointSize: footer.rodapeFontValueSize
                        font.bold: Font.Thin
                        font.family: "Arial"
                        text: Data.dataDia+ " / " + Data.dataMes
                    }

                    Text {
                        color: Paleta.fontLabelFooter
                        font.pointSize: footer.rodapeFontLabelSize
                        font.bold: Font.Thin
                        font.family: "Arial"
                        text: " Hora:"
                    }

                    Text {
                        color: Paleta.fontValueFooter
                        font.pointSize: footer.rodapeFontValueSize
                        font.bold: Font.Thin
                        font.family: "Arial"
                        text:  Number(Data.valueMin) < 10 ? Data.hora + " : 0"+ Data.min : Data.hora + " : "+ Data.min
                    }
                }

                Row{
                    Text {
                        id: labelConexao
                        color: Paleta.fontLabelFooter
                        font.pointSize: footer.rodapeFontLabelSize
                        font.bold: Font.Thin
                        font.family: "Arial"
                        text: Data.conexao
                    }
                }

                // Versao
                Row {
                    spacing: 15

                    Text {
                        id: labelVersion
                        color: Paleta.fontLabelFooter
                        font.pointSize: footer.rodapeFontLabelSize
                        font.bold: Font.Thin
                        font.family: "Arial"
                        text: qsTr("Versão:")
                    }
                    Text {
                        id: valueVersion
                        anchors.bottom: parent.bottom
                        color: Paleta.fontValueFooter
                        font.pointSize: footer.rodapeFontValueSize
                        font.bold: Font.Thin
                        font.family: "Arial"
                        text: Data.version
                    }
                }

            }

        }


        InputPanel {
            id: inputPanel
            z: 99
            y: displayRef.height
            height: 250
            smooth: false
            anchors.left: displayRef.left
            anchors.right: displayRef.right

            states: State {
                name: "visible"
                when: Qt.inputMethod.visible
                PropertyChanges {
                    target: inputPanel
                    y: displayRef.height - inputPanel.height

                }
            }
            transitions: Transition {
                from: ""
                to: "visible"
                reversible: true
                ParallelAnimation {
                    NumberAnimation {
                        properties: "y"
                        duration: 400
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

    }


    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            root.dateTime = new Date()
        }
    }



    Timer{

        id: timerTextInput
        interval: 20000
        running: inputPanel.state == "visible"
        repeat: false
        onTriggered: {
            inputPanel.state = ""
        }
    }
}
