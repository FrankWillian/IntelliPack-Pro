import QtQuick 2.7
import "."

Item
{
    property string etiqueta
    property int espaco
    property string texto_txtbox
    property int registro_txtbox
    property int x_txtbox

    Row{
        spacing: espaco
        Text {
            text: etiqueta
            font.family: "Arial"
            color: "black"
            font.pointSize: Data.fontLabelSize
            anchors.margins: 2
            anchors.verticalCenter: txtbox.verticalCenter
        }

        TextBoxOpus
        {
            id: txtbox
            texto: texto_txtbox
            registro: registro_txtbox
            x_txt: x_txtbox
        }
    }
}
