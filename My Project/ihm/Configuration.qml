import QtQuick 2.4
import QtQuick.Controls 2.0
import "."

Item {
    id: root

    Connections {
        target: Data

    }


    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Text {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 28
            font.bold: Font.DemiBold
            text: qsTr("Painel de Configurações")
        }

        Rectangle {
            width: 400; height: 75
            anchors.centerIn: parent
            color: "gold"
            radius: 4

            Text {
                anchors.centerIn: parent
                font.pointSize: 12
                font.bold: Font.DemiBold
                text: qsTr("Lançar Popup Pequeno")
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    //print("Lançando popup")
                    popupSmall.msgPopup = "Popup lançado via Painel de Controle"
                    popupSmall.visible = true

                }
            }
        }

        PopupSmall {
            id: popupSmall

            width: parent.width
            height: parent.height

            visible: false

            z: 90

            onCancelClicked: {
                popupSmall.visible = false
            }

            onOkClicked: {
                popupSmall.visible = false
            }
        }


    }


}
