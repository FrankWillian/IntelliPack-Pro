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
        width: parent.width*0.86
        height: 420
        anchors.centerIn: parent
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
            x: 20
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                margins: 20
            }
            width: parent.width
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 14
            font.bold: Font.Thin
            font.family: "Arial"
            color: "#667ab3"
            text: root.msgTitulo

        }




        Rectangle {
            anchors.centerIn: parent
            width: parent.width*0.9
            height: parent.height*0.5
            color: "transparent"
            radius: 4

            Text {
                id: msg
                font.family: "Arial"
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignJustify
                font.pointSize: 12
                wrapMode: Text.Wrap
                text: root.msgPopup
            }


        }

    }
}
