import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
//import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
//import Qt.labs.controls 1.0
import QtQuick.Layouts 1.1
import "."



Rectangle {
    width: 350
    height: 550
    y: 0
    x: 0

    property string imgSerial

    Component.onCompleted: {
        imgSerial = "file://home/root/Imagem.jpeg"
    }

    Connections
    {
        target: Task
        onScanBarcodeChanged: {
            Data.barCode = Task.scanBarcode;
            Data.printerParam = Task.getPrinterParam("NOME");
            console.log(Data.barCode)
            console.log(Data.printerParam)
            if(Data.barCode.trim() !== Data.printerParam.trim()){
                Data.barcodeColor = "red"
                Data.codigoColor = "red"
            }
            else {
                Data.barcodeColor = "green"
                Data.codigoColor = "green"
            }
        }

        onImageChanged: {
            loaderMain.sourceComponent = compNull
            loaderMain.source = "Serial.qml"
        }
    }

    Text{
        id: serialText
        x: 0
        width: parent.width
        height: 150
        font.pointSize: 18
        wrapMode: Text.Wrap
        text: "Barcode: \t" + Data.barCode
        color: Data.barcodeColor
    }

    Text{
        id: printerText
        x: 0
        y: serialText.y + 50
        width: parent.width
        height: 150
        font.pointSize: 18
        wrapMode: Text.Wrap
        text: "Produto: \t" + Data.printerParam
        color: Data.codigoColor
    }

//    Image {
//        id: imgScan
//        y: 100
//        x: 50
//        cache: false
//        source: imgSerial
//        sourceSize: Qt.size(width, height)
//        width: 320; height: 480
//        antialiasing: true
//        layer.enabled: true
//        layer.effect: DropShadow {
//            transparentBorder: true
//            color: "#545454"
//            horizontalOffset: 6
//            verticalOffset: 6
//            samples: 28
//            smooth: true
//        }
//    }

//    Rectangle {
//        id: btn_envia
//        width: 70
//        height: 70
//        x: 0
//        y: 0
//        visible: true

//        Image {
//            id: imgEnviar
//            anchors.fill: parent
//            source: "CONTENTS/IMAGES/ok.png"
//            sourceSize: Qt.size(width, height)
//            width: 70; height: 70
//            asynchronous: true
//        }

//        MouseArea {
//            anchors.fill: parent
//            onClicked: {
//                timerImg.start()
//                Task.sendSerialCmd()
//                //loaderMain.sourceComponent = compNull
//                //loaderMain.source = "Serial.qml"
//                //imgScan.source = "file://home/root/Imagem.jpeg"
//            }
//        }
//    }

    Timer{

        id: timerImg
        interval: 1000
        onTriggered: {
            loaderMain.sourceComponent = compNull
            loaderMain.source = "Serial.qml"
        }

    }
}
