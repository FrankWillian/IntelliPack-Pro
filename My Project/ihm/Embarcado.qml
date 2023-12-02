import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
//import Qt.labs.controls 1.0
import QtQuick.Layouts 1.1
import "."


Rectangle {
    width: 350
    height: 550
    y: 35
    x: 50

    Component.onCompleted: {

        if(Data.modoOpusOne){
            controlLogo.checked = true

        }


    }

    Rectangle{
        y: 5
        width: 350
        height: 122
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

    Text {
        x: 05
        y: 305

        id: labelLogo
        font.pointSize: Data.fontLabelSize
        color: controlLogo.checked ? "#667ab3" : "black"
        font.family: "Arial"
        text: "OpusOne"
        height: 50
    }

    Switch{
        x: 120
        y: 300

        id: controlLogo
        implicitHeight: 50
        implicitWidth: 72

        onReleased: {
            if(controlLogo.checked){
                Data.modoOpusOne = true
                Data.valueLogo = "qrc:/CONTENTS/IMAGES/logo-opuspac.svg"
                Data.nameLoginAdmin = "opuspac"



            } else{
                Data.modoOpusOne = false
                Data.valueLogo = "qrc:/CONTENTS/IMAGES/logoInobag.png"
                Data.nameLoginAdmin = "inobag"
            }
        }
        indicator: Rectangle{
            implicitWidth: 72
            implicitHeight: 32
            radius: 16
            color: controlLogo.checked ? "#667ab3" : "#ffffff"
            border.color: controlLogo.checked ? "#667ab3" : "#cccccc"
            border.width: 2

            Rectangle {
                x: controlLogo.checked ? parent.width - width : 0
                width: 32
                height: 32
                radius: 16
                color: "white"
                border.color: "#999999"
                border.width: 2
            }
        }
        contentItem: Text {
            text: controlLogo.text
            font: controlLogo.font
            color: controlLogo.down ? "#17a81a" : "#21be2b"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

    }






    Column {
        x: 25
        y: 220
        spacing: 40

        Rectangle{

            width: 280
            height: 22
            radius: 4

            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: "black"
                horizontalOffset: 1
                verticalOffset: 1
            }

            ProgressBar {

                //value: Data.valueProdutiMedia / 100
                value: slider.value


                style: ProgressBarStyle {
                    background: Rectangle {
                        radius: 4
                        color: "lightgray"
                        border.color: "#333399"
                        border.width: 1.2
                        implicitWidth: 280
                        implicitHeight: 22
                    }
                    progress: Rectangle {
                        color: Paleta.colorPatern
                        border.color: "#333399"
                    }
                }
            }



        }

        Slider {
            id:slider
            value: Data.valueProdutiMedia / 100

            style: SliderStyle {
                groove: Rectangle {
                    implicitWidth: 280
                    implicitHeight: 10
                    color: "#a3a3c2"
                    radius: 8

                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        color: "black"
                        horizontalOffset: 1.5
                        verticalOffset: 1.5
                    }
                }
                handle: Rectangle {
                    anchors.centerIn: parent
                    color: control.pressed ? "#cccccc" : Paleta.colorPatern
                    border.color: "#cccccc"
                    border.width: 2
                    implicitWidth: 34
                    implicitHeight: 34
                    radius: 12
                }
            }
        }


    }

    Label {
        y: 350
        x: - 30
        id: emb
        text: "Embalagem"
        font.pixelSize: 22
        font.italic: true
        color: "steelblue"
    }

    GroupBox {
        y: 360
        x: - 30
        id: control

        Layout.fillWidth: true
        RowLayout {
            spacing: 30
            ExclusiveGroup { id: tabPositionGroup }
            CheckBox {
                text: "70 x 130"
                exclusiveGroup: tabPositionGroup
                style: CheckBoxStyle {
                    indicator: Rectangle {
                            implicitWidth: 16
                            implicitHeight: 16
                            radius: 3
                            border.color: control.activeFocus ? "darkblue" : "gray"
                            border.width: 1
                            Rectangle {
                                visible: control.checked
                                color: "#555"
                                border.color: "#333"
                                radius: 1
                                anchors.margins: 4
                                anchors.fill: parent
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    emb.text = "Frank"
                                }


                            }

                    }
                }
            }

            CheckBox {
                text: "70 x 150"
                exclusiveGroup: tabPositionGroup
                style: CheckBoxStyle {
                    indicator: Rectangle {
                            implicitWidth: 16
                            implicitHeight: 16
                            radius: 3
                            border.color: control.activeFocus ? "darkblue" : "gray"
                            border.width: 1
                            Rectangle {
                                visible: control.checked
                                color: "#555"
                                border.color: "#333"
                                radius: 1
                                anchors.margins: 4
                                anchors.fill: parent
                            }
                    }
                }

            }

            CheckBox {
                text: "70 x 200"
                exclusiveGroup: tabPositionGroup
                style: CheckBoxStyle {
                    indicator: Rectangle {
                            implicitWidth: 16
                            implicitHeight: 16
                            radius: 3
                            border.color: control.activeFocus ? "darkblue" : "gray"
                            border.width: 1
                            Rectangle {
                                visible: control.checked
                                color: "#555"
                                border.color: "#333"
                                radius: 1
                                anchors.margins: 4
                                anchors.fill: parent
                            }
                    }
                }

            }

        }
    }



}
