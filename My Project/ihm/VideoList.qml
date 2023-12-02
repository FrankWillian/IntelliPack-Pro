import QtQuick 2.7
import QtMultimedia 5.4
import Qt.labs.folderlistmodel 2.2

Item {
    id: root
    width: parent.width
    height: parent.height

    property bool menuExpanded: true
    property string pathVideos: "file:///opt/opuspac/videos"
    property color bgPlayerVideo: "#b3c1c9"
    property color bgExpandMenu: "#a5b2ba"
    property color bgListView: "#dbe4ee"

    // Listagem do nome dos arquivos dos videos
    FolderListModel {
        id: videosModel
        sortField: FolderListModel.Name
        showDirsFirst: true
        showDotAndDotDot: false
        showFiles: true
        showHidden: false
        folder: pathVideos
        nameFilters: ["*.mp4", "*.avi"]

        // Caso algum video seja adicionado no diretorio ira atualizar o ListView
        // sem reiniciar a aplicação
        onFolderChanged: {
            _lv.update()
        }
    }

    // Componet para cada item do video
    Component {
        id: videoDelegate
        Item {
            width: 400; height: 50
            Row {
                id: _row
                anchors.fill: parent
                Rectangle {
                    width: parent.width*0.8
                    height: parent.height
                    color: "transparent"
                    radius: 4
                    Text {
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        font.family: "Arial"
                        font.pixelSize: 16
                        text: fileBaseName
                        anchors.margins: 12
                    }
                }
                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.height-19; height: parent.height-19
                    sourceSize: Qt.size(width,height)
                    source: "CONTENTS/IMAGES/playS.png"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (lv.x == 0) {
                                lv.x = -420;
                                root.menuExpanded = false

                                player.source = pathVideos+"/"+fileName
                                player.play()
                            }
                            else {
                                lv.x = 0
                                root.menuExpanded = true
                            }
                        }
                    }
                }
            }
            Rectangle {
                anchors.top: _row.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: 380
                height: 2
                color: "#7733ff"
            }
        }
    }
    // Retangulo com ListView
    Rectangle {
        id: lv
        width: 400
        height: 530
        x: 0
        y: 0

        color: "#eee6ff"

        Flickable{

            maximumFlickVelocity: 0.2

            ListView {
                id: _lv
                width: 400
                height: 400
                x: 0
                y: 40
                spacing: 0
                model: videosModel
                delegate: videoDelegate
            }
        }


    }

    // Retangulo laterial para expandir a listagem de videos
    Rectangle {
        id: barExpandMenu
        anchors.left: lv.right
        //anchors.leftMargin: root.menuExpanded ? 3 : 0
        width: 50
        height: 530
        color: "#bb99ff"

        Image {
            id: imgExpandMenu
            anchors.verticalCenter: parent.verticalCenter
            width: 40; height: 40
            rotation: root.menuExpanded ? 0 : 180
            sourceSize: Qt.size(width,height)
            source: "CONTENTS/IMAGES/right.svg"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (lv.x == 0) {
                    lv.x = -420;
                    root.menuExpanded = false
                }
                else {
                    lv.x = 0
                    root.menuExpanded = true
                }
            }
        }
    }

    // Area de reprodução do video
    Rectangle {
        anchors.left: barExpandMenu.right
        border.color: "white"
        width: 350
        height: 540
        x: 50

        MediaPlayer {
            id: player
            loops: 999

            // Ao terminar o video, força abrir a lista de videos
            onStopped: {
                console.log("Video reprodução terminou.")
                lv.x = 0
                root.menuExpanded = true
            }



        }

        VideoOutput {
            x: 370
            y: - 134
            id: videoOutput
            //anchors.fill: frame
            source: player
            orientation: 2
            width: 800
            height: 295


            transform: Rotation{
                angle: 90
            }
        }
    }

    Row{
        x: 93
        y: 555
        spacing: 80
        visible: root.menuExpanded ? false : true

        Rectangle {
            width: 35
            height: 35
            visible: true
            enabled: true
            id: buttonPlay

            Image {
                id: imgMedia
                anchors.fill: buttonPlay
                source: "CONTENTS/IMAGES/playS.png"
                sourceSize: Qt.size(width, height)
                 width: 35; height: 35
                asynchronous: true
            }
            MouseArea {
                anchors.fill: buttonPlay
                onPressed:  player.play();
            }
        }

        Rectangle {
            width: 35
            height: 35
            visible: true
            enabled: true
            id: buttonPause

            Image {
                anchors.fill: buttonPause
                source: "CONTENTS/IMAGES/pauseS.png"
                sourceSize: Qt.size(width, height)
                 width: 35; height: 35
                asynchronous: true


            }

            MouseArea {
                anchors.fill: buttonPause
                onPressed: player.pause();
            }

        }

        Rectangle {
            width: 35
            height: 35
            visible: true
            enabled: true
            id: buttonStop

            Image {
                anchors.fill: buttonStop
                source: "CONTENTS/IMAGES/stopS.png"
                sourceSize: Qt.size(width, height)
                width: 35; height: 35
                asynchronous: true
            }
            MouseArea {
                anchors.fill: buttonStop
                onPressed:  player.stop();
            }
        }
    }
}
