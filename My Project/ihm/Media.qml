import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtMultimedia 5.4
//import Qt.labs.controls 1.0
import QtQuick.Layouts 1.1
import "."


Rectangle {
    width: 350
    height: 550
    y: 15
    x: 0
    id: root

    Rectangle{
        width: 440
        height: 480
        x: -5
        Image {
            width: 280
            height: 280
            id: backgorund
            visible: !Data.playFilme
            anchors.centerIn: parent
            source: "CONTENTS/IMAGES/logo-opuspac.svg"
        }
        Item {
            anchors.fill: parent
            MediaPlayer {
                id: mediaplayer
                // autoPlay: true
                loops: 999
                source: "CONTENTS/IMAGES/Calibração da fotocélula.mp4"
            }
            VideoOutput {
                antialiasing: true
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    color: "#545454"
                    horizontalOffset: 6
                    verticalOffset: 6
                    samples: 28
                    smooth: true
                }
                anchors.fill: parent
                source: mediaplayer


            }

        }
    }
    Row{
        x: 60
        y: 410
        spacing: 80
        Rectangle {
            width: 50
            height: 50
            visible: true
            enabled: true
            Image {
                id: imgMedia
                anchors.fill: parent
                source: "CONTENTS/IMAGES/play-button.png"
                sourceSize: Qt.size(width, height)
                width: 70; height: 70
                asynchronous: true
            }
            MouseArea {
                anchors.fill: parent
                onPressed:  mediaplayer.play();
                onClicked: Data.playFilme = true
            }
        }
        Rectangle {
            width: 50
            height: 50
            visible: true
            enabled: true
            Image {
                anchors.fill: parent
                source: "CONTENTS/IMAGES/pause.png"
                sourceSize: Qt.size(width, height)
                width: 70; height: 70
                asynchronous: true
            }
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    if(Data.playFilme){
                        mediaplayer.pause();
                    }
                }
            }
        }
        Rectangle {
            width: 50
            height: 50
            visible: true
            enabled: true
            Image {
                anchors.fill: parent
                source: "CONTENTS/IMAGES/stop.png"
                sourceSize: Qt.size(width, height)
                width: 70; height: 70
                asynchronous: true
            }
            MouseArea {
                anchors.fill: parent
                onPressed:  mediaplayer.stop();
                onClicked: Data.playFilme = false
            }
        }
    }
}
