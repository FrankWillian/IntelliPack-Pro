import QtQuick 2.4
import QtQuick.Controls 2.0
import "."

Item {
    id: root

    property int sizeFontLabel: 12
    property int sizeFontInput: 12

    Rectangle {

        id: areaAlarme
        color: "transparent"
        border.color: lv.count === 0 ? "#667ab3" : "transparent";
        border.width: 2

        width: 700
        height: 850
        y: 60
        x: 30

        ListView {
            x: 3
            y: 10
            id: lv
            width: 500
            height: 640
            spacing: 20
            highlightMoveVelocity : 0.2

            move: Transition {
                NumberAnimation { properties: "x,y"; duration: 1000 }
            }

            model: Task.modelAlarms

            delegate:  Row {
                y: 3
                spacing: 10

                /*
                Rectangle {
                    border.width: 2; border.color: "#667ab3"; width: 50; height: 35;
                    radius: 8; color: index % 2 ? "#F0F8FF" : "#E0FFFF";

                    Text {
                        anchors.centerIn: parent
                        text: id
                        color: "black"
                        font.family: Data.fontFamily
                    }
                }
                */

                Rectangle {
                    border.width: 2; width: 250; height: 45
                    color: index % 2 ? "white" : "#667ab3"; radius: 8
                    border.color: "#667ab3"
                    Text {
                        anchors.centerIn: parent
                        text: datetime
                        horizontalAlignment: Text.AlignJustify
                        font.family: Data.fontFamily
                        font.pixelSize: 18
                        color: index % 2 ? "#667ab3" : "white";
                    }
                }
                Rectangle {
                    border.width: 2; width: 400; height: 45
                    color: index % 2 ? "white" : "#667ab3"; radius: 8
                    border.color: "#667ab3"

                    Text {
                        width: parent.width - 10
                        anchors.centerIn: parent
                        text: info
                        horizontalAlignment: Text.AlignJustify
                        font.family: "Arial"
                        font.pixelSize: 18
                        color: index % 2 ? "#667ab3" : "white";
                        wrapMode: Text.Wrap
                    }
                }

            }

        }

    }

}
