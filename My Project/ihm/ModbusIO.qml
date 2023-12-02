import QtQuick 2.4
import QtQuick.Controls 2.0
import "."

Item {
    id: root

    property bool varConnMD: false

    property int sizeFontLabel: 12
    property int sizeFontInput: 12




    Connections {
        target: Data

        onDataModBusChanged: {
            log.append(Data.dataModBus)
        }
    }


    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Column {
            id: colOptions
            width: parent.width
            spacing: 10

            // IP e Porta
            Row {
                spacing: 5

                // IP ModBus
                Text {
                    id: txtIP
                    width: colOptions.width/6
                    height: 25
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pointSize: root.sizeFontLabel
                    color: "#424244"
                    font.family: "Helvetica"
                    text: qsTr("IP:")
                }

                Rectangle {
                    id: rectIP

                    width: colOptions.width/4
                    height: 25
                    border.width: 1
                    border.color: "#5d5d5d"
                    //color: "#5f5f5f"
                    color: "transparent"
                    radius: 4

                    TextInput {
                        id: inputIP

                        anchors.fill: parent
                        font.pointSize: root.sizeFontInput
                        font.underline: false
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        echoMode: TextInput.Normal
                        color: Paleta.fontValueFooter
                        /* Configura para abrir o teclado virtual na opção numerico */
                        inputMethodHints: Qt.ImhPreferNumbers | Qt.ImhDigitsOnly | Qt.ImhFormattedNumbersOnly;
                        text: "10.20.30.50"
                    }


                }

                // Porta ModBus
                Text {
                    id: txtPort
                    width: colOptions.width/6
                    height: 25
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pointSize: root.sizeFontLabel
                    color: "#424244"
                    font.family: "Helvetica"
                    text: qsTr("Port:")
                }

                Rectangle {
                    id: rectPort

                    width: colOptions.width/6
                    height: 25
                    border.width: 1
                    border.color: "#5d5d5d"
                    //color: "#5f5f5f"
                    color: "transparent"
                    radius: 4

                    TextInput {
                        id: inputPort

                        anchors.fill: parent
                        font.pointSize: root.sizeFontInput
                        font.underline: false
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        echoMode: TextInput.Normal
                        color: Paleta.fontValueFooter
                        /* Configura para abrir o teclado virtual na opção numerico */
                        inputMethodHints: Qt.ImhPreferNumbers | Qt.ImhDigitsOnly | Qt.ImhFormattedNumbersOnly;
                        text: "502"
                    }


                }


                // Botão Conectar ModBus
                Rectangle {
                    id: btnConnectModBus
                    width: colOptions.width/6
                    height: 25
                    radius: 4
                    color: "#282828"

                    Text {
                        id: txtConectar
                        anchors.centerIn: parent
                        font.pointSize: root.sizeFontLabel
                        font.bold: Font.DemiBold
                        color: "#F1F1F1"
                        text: "CONECTAR"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            varConnMD = Task.connectMB(inputIP.text,inputPort.text)
                        }
                    }
                }


            }

            // Server Address
            Row {
                spacing: 5

                Text {
                    id: txtServerAddress
                    width: colOptions.width/6
                    height: 50
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.family: "Helvetica"
                    font.pointSize: root.sizeFontLabel
                    color: "#424244"
                    wrapMode: Text.Wrap
                    text: qsTr("Server Address:")
                }

                Rectangle {
                    id: rectServerAddress
                    width: colOptions.width/4
                    height: 25
                    anchors.verticalCenter: parent.verticalCenter
                    border.width: 1
                    border.color: "#5d5d5d"
                    //color: "#5f5f5f"
                    color: "transparent"
                    radius: 4

                    TextInput {
                        id: inputServerAddress

                        anchors.fill: parent
                        font.pointSize: root.sizeFontInput
                        font.underline: false
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        echoMode: TextInput.Normal
                        color: Paleta.fontValueFooter
                        /* Configura para abrir o teclado virtual na opção numerico */
                        inputMethodHints: Qt.ImhPreferNumbers | Qt.ImhDigitsOnly | Qt.ImhFormattedNumbersOnly;
                        text: "1"
                    }


                }

            }

            // Labels Columsn (Start Address, Num Values, Value, Command
            Row {
                spacing: 5

                // Start Address
                Text {
                    id: txtStartAddress
                    width: colOptions.width/6
                    height: 25
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pointSize: root.sizeFontLabel
                    color: "#424244"
                    font.family: "Helvetica"
                    text: qsTr("ADDRESS")
                }

                // Numbers Values
                Text {
                    id: txtNumValue
                    width: colOptions.width/6
                    height: 25
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pointSize: root.sizeFontLabel
                    color: "#424244"
                    font.family: "Helvetica"
                    text: qsTr("N. VALUES")
                }

                // Value
                Text {
                    id: txtWriteValue
                    width: colOptions.width/6
                    height: 25
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pointSize: root.sizeFontLabel
                    color: "#424244"
                    font.family: "Helvetica"
                    text: qsTr("VALUE")
                }

                // Command
                Text {
                    id: txtAction
                    width: colOptions.width/6
                    height: 25
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pointSize: root.sizeFontLabel
                    color: "#424244"
                    font.family: "Helvetica"
                    text: qsTr("COMMAND")
                }

            }

            // Read
            Row {
                spacing: 5

                ComboBox {
                    id: cbReadStartAddress
                    width: colOptions.width/6
                    height: 25
                    model: [0,1,2,3,4,5,6,7,8,9,10]
                }

                ComboBox {
                    id: cbReadNumValues
                    width: colOptions.width/6
                    height: 25
                    model: [1,2,3,4,5,6,7,8,9,10]
                }

                Rectangle { width: colOptions.width/6; height: 25; color: "transparent" }
                /*
                Rectangle {
                    id: rectReadNumValues

                    width: colOptions.width/6
                    height: 25
                    border.width: 1
                    border.color: "#5d5d5d"
                    //color: "#5f5f5f"
                    color: "transparent"
                    radius: 4

                    TextInput {
                        id: inputReadNumValues

                        anchors.fill: parent
                        font.pointSize: root.sizeFontInput
                        font.underline: false
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        echoMode: TextInput.Normal
                        color: Paleta.fontValueFooter
                        // Configura para abrir o teclado virtual na opção numerico
                        inputMethodHints: Qt.ImhPreferNumbers | Qt.ImhDigitsOnly | Qt.ImhFormattedNumbersOnly;
                    }

                }
                */

                // Botão Ler ModBus
                Rectangle {
                    id: btnRead
                    visible: root.varConnMD ? true : false
                    width: colOptions.width/6
                    height: 25
                    radius: 4
                    color: "#282828"

                    Text {
                        id: txtReceber
                        anchors.centerIn: parent
                        font.pointSize: root.sizeFontLabel
                        font.bold: Font.DemiBold
                        color: "#F1F1F1"
                        text: "RECEBER"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            //print("Server Address    : "+inputServerAddress.text)
                            //print("Start Address     : "+cbReadStartAddress.currentText)
                            //print("Num Values        : "+cbReadNumValues.currentText)

                            Task.readMB(inputServerAddress.text, cbReadStartAddress.currentText, cbReadNumValues.currentText)
                        }
                    }
                }

                // Botão Contador
                Rectangle {
                    id: btnConta
                    visible: root.varConnMD ? true : false
                    width: colOptions.width/6
                    height: 25
                    radius: 4
                    color: "#282828"

                    Text {
                        id: txtConta
                        anchors.centerIn: parent
                        font.pointSize: root.sizeFontLabel
                        font.bold: Font.DemiBold
                        color: "#F1F1F1"
                        text: "CONTA"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            Task.startContador()
                        }
                    }
                }

            }

            // Write
            Row {
                spacing: 5

                ComboBox {
                    id: cbWriteStartAddress
                    width: colOptions.width/6
                    height: 25
                    model: [0,1,2,3,4,5,6,7,8,9,10]
                }

                ComboBox {
                    id: cbWriteNumValues
                    width: colOptions.width/6
                    height: 25
                    model: [1,2,3,4,5,6,7,8,9,10]
                }

                Rectangle {
                    id: rectWriteValues

                    width: colOptions.width/6
                    height: 25
                    border.width: 1
                    border.color: "#5d5d5d"
                    //color: "#5f5f5f"
                    color: "transparent"
                    radius: 4

                    TextInput {
                        id: inputWriteValues

                        anchors.fill: parent
                        font.pointSize: root.sizeFontInput
                        font.underline: false
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        echoMode: TextInput.Normal
                        color: Paleta.fontValueFooter
                        /* Configura para abrir o teclado virtual na opção numerico */
                        inputMethodHints: Qt.ImhPreferNumbers | Qt.ImhDigitsOnly | Qt.ImhFormattedNumbersOnly;
                    }


                }

                // Botão Escrever ModBUs
                Rectangle {
                    id: btnWrite
                    visible: root.varConnMD ? true : false
                    width: colOptions.width/6
                    height: 25
                    radius: 4
                    color: "#282828"

                    Text {
                        id: txtEnviar
                        anchors.centerIn: parent
                        font.pointSize: root.sizeFontLabel
                        font.bold: Font.DemiBold
                        color: "#F1F1F1"
                        text: "ENVIAR"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            Task.writeMB(inputServerAddress.text, cbReadStartAddress.currentText, cbReadNumValues.currentText)
                        }
                    }
                }

            }

        }

        // Log
        TextArea {
            id: log
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: colOptions.bottom
            anchors.topMargin: 10
            width: colOptions.width
            height: 180
            background: Rectangle {
                anchors.fill: parent
                radius: 2
                color: "#707070"
            }
            font.pointSize: 14
            color: "white"
            //text: Data.dataModBus
        }
    }


}
