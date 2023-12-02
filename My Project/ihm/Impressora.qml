import QtQuick 2.4
import QtQuick.Controls 2.0
import QtWebKit 3.0
import "."

Item {
    id: root
    Rectangle {

        id: areaAlarme
        color: "transparent"
        border.color: "transparent"
        border.width: 3

        width: parent.width
        height: 365
        y: 60
        x: 20

        WebView {
            id: webViewImpressora
            anchors.fill: parent
            url: "http://10.20.30.4"


        }
    }

}
