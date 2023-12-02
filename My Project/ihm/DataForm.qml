import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.LocalStorage 2.0
import 'DataFormJS.js' as DataFormJS
import "."

Item {

    Component.onCompleted: {

        DataFormJS.salvar();
    }

    Rectangle{

        width: parent.width
        height: 400
        y: 40
        x: 10

        color: "transparent"
        border.color:  "#667ab3"
        border.width: 2

        ListView{
            y: 25
            x: 12
            id: tabela
            spacing: 2
            width: parent.width
            height: 400

            //anchors.fill: parent
            model: ListModel {}

            delegate: Row{

                spacing: 20
                Text {
                    text: id
                    color: Paleta.fontLabel
                    font.family: Data.fontFamily
                    font.pointSize: Data.fontLabelSize
                    font.bold: Font.Thin
                    horizontalAlignment: Text.AlignLeft

                }

                Text {
                    text: nome
                    color: Paleta.fontLabel
                    font.family: Data.fontFamily
                    font.pointSize: Data.fontLabelSize
                    font.bold: Font.Thin
                    horizontalAlignment: Text.AlignLeft

                }

                Text {
                    text: idade
                    color: Paleta.fontLabel
                    font.family: Data.fontFamily
                    font.pointSize: Data.fontLabelSize
                    font.bold: Font.Thin
                    horizontalAlignment: Text.AlignLeft

                }

            }
        }

    }

    Rectangle {
        id: btnvoltar
        width: 70
        height: 70
        x: 30
        y: 450
        visible: true

        Image {
            id: imgVoltar
            anchors.fill: parent
            source: "CONTENTS/IMAGES/Voltar.png"
            sourceSize: Qt.size(width, height)
            width: 70; height: 70
            asynchronous: true

        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                btnvoltar.scale = 0.95
                btnvoltar.color = "transparent"
            }

            onReleased: {
                btnvoltar.scale = 1.0
                btnvoltar.color = "transparent"

                loaderMain.width = root.width-(lvMenu.height)
                loaderMain.source = "BancoDados.qml"
                tituloHome.text = qsTr("BANCO DADOS")
                tituloHome.x = 120
            }
        }
    }



}
