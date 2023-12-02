import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.LocalStorage 2.0
import 'JSmain.js' as JSmain
import 'InputFormJS.js' as InputFormJS
import "."

Item {

    Text{
        x: 30
        y: 50
        text: 'Dados: '
        color: Paleta.fontLabel
        font.family: Data.fontFamily
        font.pointSize: Data.fontLabelSize
        font.bold: Font.Thin
        horizontalAlignment: Text.AlignLeft
    }

    TextField{
        x: 120
        y: 40
        id: nomeTextField
    }


    Text{
        x: 30
        y: 100
        text: 'Valor: '
        color: Paleta.fontLabel
        font.family: Data.fontFamily
        font.pointSize: Data.fontLabelSize
        font.bold: Font.Thin
        horizontalAlignment: Text.AlignLeft
    }

    TextField{
        x: 120
        y: 90
        id: idadeTextField
    }

    Rectangle {
        id: salvar
        width: 70
        height: 70
        x: 30
        y: 250
        visible: true

        Image {
            id: imgDatabase
            anchors.fill: parent
            source: "CONTENTS/IMAGES/carregar.png"
            sourceSize: Qt.size(width, height)
            width: 70; height: 70
            asynchronous: true

        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                InputFormJS.input();
            }

        }
    }

    Rectangle {
        id: btnvoltar
        width: 70
        height: 70
        x: 200
        y: 250
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
                loaderMain.source = "DataForm.qml"
                tituloHome.text = qsTr("BANCO DADOS")
                tituloHome.x = 120
            }
        }
    }



}
