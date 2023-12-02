import QtQuick 2.7
import "."

Item
{
    property string texto
    property int registro
    property int x_txt
    property int minValue
    property int maxValue

    function sendSignal (register, value)
    {
        Data.envioRun = true
        Task.writeParamt(Number(register),Number(value))
        Data.envioRun = false
    }

    Rectangle {
        width: 72
        height: 30
        x: x_txt
        border.width: 2
        border.color: "#667ab3"
        color: "transparent"
        radius: 4

        TextInput {
            anchors.fill: parent
            font.pointSize: Data.fontValueSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            echoMode: TextInput.Normal
            color: "black"
            /* Configura para abrir o teclado virtual na opção numerico */
            inputMethodHints: Qt.ImhPreferNumbers | Qt.ImhDigitsOnly | Qt.ImhFormattedNumbersOnly;
            text: texto
            validator: IntValidator{bottom: minValue; top: maxValue}

            onEditingFinished:  {
                if(Number(text) < minValue) { text = String(minValue) }
                if(Number(text) > maxValue) { text = String(maxValue) }
                sendSignal(registro, Number(text))
            }
            onFocusChanged:
            {
                if(focus === false)
                {
                    if(text == "") { text = texto}
                    if(Number(text) < minValue) { text = String(minValue) }
                    if(Number(text) > maxValue) { text = String(maxValue) }
                    sendSignal(registro, Number(text))
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
                    if(text == "") { text = texto}
                    if(Number(text) < minValue) { text = String(minValue) }
                    if(Number(text) > maxValue) { text = String(maxValue) }
                    sendSignal(registro, Number(text))
                }
            }
        }
    }
}
