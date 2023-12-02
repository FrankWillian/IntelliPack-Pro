import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import "."


Rectangle {
    width: 350
    height: 550
    y: 35
    x: 50

    Rectangle{
        y: 5
        width: 350
        height: 140
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
                spacing: 16
                RowLayout {
                    Text {
                        id: labelTempoEnerg
                        color: "#667ab3"
                        font.family: "Arial"
                        font.pointSize: Data.fontLabelSize
                        text: qsTr("Tempos energizado:")

                        Text {
                            id: vlrTempoEnerg
                            x: 220
                            color: "black"
                            font.family: "Arial"
                            font.pointSize: Data.fontValueSize
                            text: Data.infoHrsEnerg
                        }
                        Text {

                            x: 240
                            color: "black"
                            font.family: "Arial"
                            font.pointSize: Data.fontLabelSize
                            text: " :"
                        }
                        Text {

                            x: 260
                            color: "black"
                            font.family: "Arial"
                            font.pointSize: Data.fontValueSize
                            text: Data.infoMinEnerg

                        }
                    }
                }
                RowLayout {
                    Text {
                        id: labelTempoFunc
                        color: "#667ab3"
                        font.family: "Arial"
                        font.pointSize: Data.fontLabelSize
                        text: qsTr("Tempos funcinando:")

                        Text {
                            id: vlrTempoFunc
                            x: 220
                            color: "black"
                            font.family: "Arial"
                            font.pointSize: Data.fontValueSize
                            text: Data.infoHorasProd
                        }
                        Text {
                            x: 240
                            color: "black"
                            font.family: "Arial"
                            font.pointSize: Data.fontLabelSize
                            text: " :"
                        }
                        Text {
                            x: 260
                            color: "black"
                            font.family: "Arial"
                            font.pointSize: 12
                            text: Data.infoMinProd
                        }
                    }
                }
                RowLayout {
                    Text {
                        id: labelProdutividade
                        color: "#667ab3"
                        font.family: "Arial"
                        font.pointSize: Data.fontLabelSize
                        text: qsTr("Produtividade:")
                        Text {
                            id: vlrProdutividade
                            x: 220
                            color: "black"
                            font.family: "Arial"
                            font.pointSize: Data.fontValueSize
                            text: Data.produtiMedia + qsTr(" %")
                        }
                    }
                }
            }
        }
    }

    Rectangle{
        y: 170
        width: 350
        height: 140
        border.color: Paleta.colorPatern
        border.width: 4
        radius: 6
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            color: "black"
            horizontalOffset: 1
            verticalOffset: 1
        }
        ColumnLayout{
            x: 25
            y: 15
            ColumnLayout{
                spacing: 16
                ColumnLayout{
                    spacing: 16
                    RowLayout {
                        Text {
                            id: velocCpm
                            color: "#667ab3"
                            font.family: "Arial"
                            font.pointSize: Data.fontLabelSize
                            text: qsTr("Batidas por minuto:")

                            Text {
                                id: vlrVelocCpm
                                x: 220
                                color: "black"
                                font.family: "Arial"
                                font.pointSize: Data.fontValueSize
                                text: Data.velocMedia
                            }
                        }
                    }
                    RowLayout {
                        Text {
                            id: labelConta
                            color: "#667ab3"
                            font.family: "Arial"
                            font.pointSize: Data.fontLabelSize
                            text: qsTr("Conta geral:")
                            Text {
                                id: vlrConta
                                x: 220
                                color: "black"
                                font.family: "Arial"
                                font.pointSize: Data.fontValueSize
                                text: Data.contaGeral
                            }
                        }
                    }
                    RowLayout {
                        Text {
                            id: labelTempAtual
                            width: 100
                            color: Paleta.colorPatern
                            font.family: Data.fontFamily
                            font.pointSize: Data.fontLabelSize
                            font.bold: Font.Thin
                            horizontalAlignment: Text.AlignLeft
                            text: qsTr("Temp Core:")
                            Text {
                                x: 220
                                id: inputTempAtual
                                color: Paleta.fontValue
                                font.family: Data.fontFamily
                                font.pointSize: Data.fontValueSize
                                font.bold: Font.Thin
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignHCenter
                                text: Data.valueCoreTemp
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: btn_reset
        x: 140
        y: 350
        width: 90
        height: 90
        visible: Data.userLoginAdmin || Data.userLoginSuper ? true : false
        enabled: Data.userLoginAdmin || Data.userLoginSuper ? true : false

        Image {
            id: imgReset
            anchors.fill: parent
            source: "CONTENTS/IMAGES/resetNew.png"
            sourceSize: Qt.size(width, height)
            asynchronous: true
        }
        MouseArea {
            anchors.fill: btn_reset
            hoverEnabled: true

            onPressed: {
                popupSmall.visible = true
                popupSmall.msgPopup = "Deseja realmente zerar os valores?"
            }
        }
    }
    RowLayout{
        spacing: 50
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        y: 440

        Rectangle {
            id: btn_embarcado
            width: 90
            height: 90
            visible:  false
            //visible: Data.userLoginAdmin || Data.userLoginSuper ? true : false
            enabled: Data.userLoginAdmin || Data.userLoginSuper ? true : false

            Image {
                id: imgeEmb
                anchors.fill: parent
                source: "CONTENTS/IMAGES/embedded.png"
                sourceSize: Qt.size(width, height)
                width: 90; height: 90
                asynchronous: true
            }
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    btn_embarcado.scale = 0.95
                    btn_embarcado.color = "transparent"
                }
                onReleased: {
                    btn_embarcado.scale = 1.0
                    btn_embarcado.color = "transparent"
                    loaderMain.width = root.width-(lvMenu.height)
                    loaderMain.source = "Embarcado.qml"
                    tituloHome.text = qsTr("EMBARCADO")
                    tituloHome.x = 120
                }
            }
        }

        Rectangle {
            id: btn_motores
            width: 90
            height: 90
            visible: true

            Image {
                id: imgTracao
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
                    text: "Eixos"

                }
            }
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    btn_embarcado.scale = 0.95
                    btn_embarcado.color = "transparent"
                }
                onReleased: {
                    btn_embarcado.scale = 1.0
                    btn_embarcado.color = "transparent"
                    loaderMain.width = root.width-(lvMenu.height)
                    loaderMain.source = "Motion.qml"
                    tituloHome.text = qsTr("EIXOS")
                    tituloHome.x = 120
                }
            }
        }

        Rectangle {
            id: btn_Media
            width: 90
            height: 90
            visible: true
            enabled: true

            Image {
                id: imgMedia
                anchors.fill: parent
                source: "CONTENTS/IMAGES/videoPlayer.png"
                sourceSize: Qt.size(width, height)
                width: 90; height: 90
                asynchronous: true
            }
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    btn_embarcado.scale = 0.95
                    btn_embarcado.color = "transparent"
                }
                onReleased: {
                    btn_embarcado.scale = 1.0
                    btn_embarcado.color = "transparent"
                    loaderMain.width = root.width-(lvMenu.height)
                    loaderMain.source = "VideoList.qml"
                    tituloHome.text = qsTr("MEDIAPLAYER")
                    tituloHome.x = 120
                }
            }
        }

        Rectangle {
            id: btn_serial
            width: 70
            height: 70
            visible: false

            Image {
                id: imgSerial
                anchors.fill: parent
                source: "CONTENTS/IMAGES/barcode.png"
                sourceSize: Qt.size(width, height)
                width: 70; height: 70
                asynchronous: true
            }
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    btn_serial.scale = 0.95
                    btn_serial.color = "transparent"
                }
                onReleased: {
                    btn_serial.scale = 1.0
                    btn_serial.color = "transparent"
                    loaderMain.width = root.width-(lvMenu.height)
                    loaderMain.source = "Serial.qml"
                    tituloHome.text = qsTr("CONTROLE DE IMPRESSÃO")
                    tituloHome.x = 120
                }
            }
        }
    }

    PopupSmall {
        id: popupSmall
        width: parent.width
        height: parent.height
        x: - 30
        y: - 19
        visible: false
        z: 90

        onCancelClicked: {
            Task.enableDevice(36,3,false)
            popupSmall.visible = false
        }
        onOkClicked: {
            Task.enableDevice(36,3,true)
            popupSmall.visible = false
            popupTimer.running = true
        }
        Timer{
            id: popupTimer
            interval: 300
            running: false
            repeat: false
            onTriggered: Task.enableDevice(36,3,false)
        }
    }
}

