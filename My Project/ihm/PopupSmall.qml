import QtQuick 2.4
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import "."

Item {
    id: root

    property string msgPopup

    signal okClicked
    signal cancelClicked


    Rectangle {

        width: 680
        height: 400
        x: 0
        y: 0
        color: "white"
        border.width: 6
        border.color: Paleta.btnBlueNormal
        radius: 8

        antialiasing: true
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            color: "#545454"
            horizontalOffset: 8
            verticalOffset: 8
            samples: 28
            smooth: true
        }

        Rectangle {
            x: 59
            y: 25
            width: parent.width*0.7
            height: parent.height*0.5
            color: "transparent"
            radius: 4

            Text {
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: Data.fontFamily
                font.pointSize: Data.fontLabelSize
                text: root.msgPopup
                color: "black"
            }
        }

//Habilite as linhas abaixo para ativar os botões de OK e Cancel no Popup
        Row {
            id: rowBtns
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                margins: 20
            }
            spacing: parent.width*0.2

            Rectangle {
                id: rectBtnOk
                width: 90
                height: 90
                radius: 8
                color: "transparent"

                Image {
                    anchors.centerIn: parent
                    source: "CONTENTS/IMAGES/ok.png"
                    width: 90; height: 90
                    sourceSize: Qt.size(width, height)
                    asynchronous: true
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        okClicked()
                    }
                }

            }

            Rectangle {
                id: rectBtnCancel
                width: 90
                height: 90
                radius: 8
                color: "transparent"

                Image {
                    anchors.centerIn: parent
                    source: "CONTENTS/IMAGES/excluir.png"
                    width: 90; height: 90
                    sourceSize: Qt.size(width, height)
                    asynchronous: true
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        cancelClicked()
                    }
                }

            }

        }

    }
}
