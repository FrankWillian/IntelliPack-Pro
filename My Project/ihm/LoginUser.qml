import QtQuick 2.4
import QtGraphicalEffects 1.0
import "."

Item {
    id: root

    signal login
    signal logOut
    signal cancelClicked

    Component.onCompleted: {

        Data.passwordDigitado = ""
        Data.nameLoginDigitado = ""
    }

    Rectangle {
        width: parent.width*0.4
        height: parent.height*0.4
        color: "white"
        border.width: 6
        border.color: "#667ab3"
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

        Text {
            id: title
            x: 25
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                margins: 20
            }
            font.pointSize: 18
            font.bold: Font.Thin
            font.family: "Arial"
            color: "#667ab3"
            text: qsTr("Login")
        }
        Column{
            spacing: 30
            x: 40
            y: 100

            Row{
                spacing: 60
                Text{
                    id: test
                    font.pointSize: 14
                    font.bold: Font.Thin
                    font.family: "Arial"
                    color: "#667ab3"
                    text: qsTr("Usuário:")
                }

                Rectangle{
                    id: insertUser
                    width: 180
                    height: 30
                    border.width: 2
                    border.color: "black"
                    color: "transparent"
                    radius: 4

                    TextInput {
                        id: txtUser
                        anchors.fill: insertUser
                        font.pointSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        echoMode: TextInput.Normal
                        color: "black"
                        text: Data.nameLoginCarregado == "" ? "" : Data.nameLoginCarregado
                        enabled: Data.nameLoginCarregado == "" ? true : false
                        //readOnly: Data.nameLoginCarregado == "" ? true : false
                        onEditingFinished: { Data.nameLoginDigitado = text }
                        onTextChanged: {
                            var n = text.search("\n")
                            if(n >= 0)
                            {
                                text = text.substring(0,text.length - 1)
                            }
                        }
                    }
                }
            }
            Row{
                spacing: 70
                Text{
                    font.pointSize: 14
                    font.bold: Font.Thin
                    font.family: "Arial"
                    color: "#667ab3"
                    text: qsTr("Senha:")
                    visible: Data.nameLoginCarregado == "" ? true : false
                }
                Rectangle{
                    x: insertUser.x
                    id: insertPassword
                    width: 180
                    height: 30
                    border.width: 2
                    border.color: "black"
                    color: "transparent"
                    radius: 4
                    visible: Data.nameLoginCarregado == "" ? true : false

                    TextInput {
                        id: txi_password
                        anchors.fill: insertPassword
                        font.pointSize: 18
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        echoMode: TextInput.Password
                        inputMethodHints: Qt.ImhPreferNumbers | Qt.ImhDigitsOnly | Qt.ImhFormattedNumbersOnly;
                        validator: RegExpValidator { regExp: /[0-9]+/}
                        maximumLength: 6
                        color: "black"
                        text: Data.passwordDigitado
                        onEditingFinished: { Data.passwordDigitado = text }
                        onTextChanged: {
                            Data.passwordDigitado = text
                            var n = text.search("\n")
                            if(n >= 0)
                            {
                                text = text.substring(0,text.length - 1)
                                Data.passwordDigitado = text
                            }
                        }

                    }
                }
            }

            Row{
                spacing: 65

                Rectangle {
                    id: btn_submit
                    width: 90
                    height: 90
                    radius: 8
                    color: "transparent"

                    Image {
                        anchors.fill: parent
                        width: parent.width
                        height: parent.height
                        source: "CONTENTS/IMAGES/loginInput.png"
                        sourceSize: Qt.size(width, height)
                        asynchronous: true
                        visible: Data.nameLoginCarregado == "" ? true : false
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            login()
                        }
                    }
                }

                Rectangle {
                    id: btn_logout
                    width: btn_submit.width
                    height: btn_submit.height
                    radius: 8
                    color: "transparent"
                    visible: Data.nameLoginCarregado == "" ? false : true

                    Image {
                        anchors.fill: parent
                        width: parent.width
                        height: parent.height
                        source: "CONTENTS/IMAGES/logout.png"
                        sourceSize: Qt.size(width, height)
                        asynchronous: true

                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            logOut()
                        }
                    }
                }

                Rectangle {
                    id: btn_cancel
                    width: btn_submit.width
                    height: btn_submit.height
                    radius: 8
                    color: "transparent"

                    Image {
                        anchors.fill: parent
                        width: parent.width
                        height: parent.height
                        source: "CONTENTS/IMAGES/cancel.png"
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
}
