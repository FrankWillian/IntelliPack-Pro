import QtQuick 2.4
import QtGraphicalEffects 1.0
import "."

Item {
    id: root

    property string msgTitulo
    property string msgPopup

    signal okClicked
    signal cancelClicked


    Rectangle {
        width: parent.width*0.8
        height: parent.height*0.8
        anchors.centerIn: parent
        color: "white"
        border.width: 2
        border.color: Paleta.btnBlueNormal
        radius: 8
        antialiasing: true
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            color: "#90000000"
            horizontalOffset: 8
            verticalOffset: 8
            samples: 24
            smooth: true
        }

        Text {
            id: msg
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                margins: 20
            }
            font.pointSize: 32
            font.bold: Font.DemiBold
            text: root.msgTitulo
        }

        Rectangle {
            anchors.centerIn: parent
            width: parent.width*0.9
            height: parent.height*0.5
            color: "transparent"
            radius: 4

            Text {
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                //verticalAlignment: Text.AlignVCenter
                font.pointSize: 14
                wrapMode: Text.Wrap
                text: root.msgPopup
            }
        }

//Habilite as linhas abaixo para ativar os botões de OK e Cancel no Popup
//        Row {
//            anchors
//            {
//                horizontalCenter: parent.horizontalCenter
//                bottom: parent.bottom
//                margins: 20
//            }
//            spacing: parent.width*0.5

//            Rectangle {
//                id: rectBtnOk
//                width: 80
//                height: 80
//                radius: 8
//                color: "green"

//                Image {
//                    anchors.centerIn: parent
//                    source: "CONTENTS/IMAGES/btn-ok.svg"
//                    width: 64; height: 64
//                    sourceSize: Qt.size(width, height)
//                    asynchronous: true
//                }

//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: {
//                        okClicked()
//                    }
//                }

//            }

//            Rectangle {
//                id: rectBtnCancel
//                width: 80
//                height: 80
//                radius: 8
//                color: "red"

//                Image {
//                    anchors.centerIn: parent
//                    source: "CONTENTS/IMAGES/btn-cancel.svg"
//                    width: 64; height: 64
//                    sourceSize: Qt.size(width, height)
//                    asynchronous: true
//                }

//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: {
//                        cancelClicked()
//                    }
//                }

//            }

//        }

    }
}
