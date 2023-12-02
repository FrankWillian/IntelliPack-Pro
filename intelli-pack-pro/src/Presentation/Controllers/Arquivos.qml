import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import "."



Item {
    id: root

    Timer {
        id: timerAtualiza
        interval: 500
        running: Data.recAtualiza
        repeat: false
        onTriggered: {
            Data.recAtualiza = false
            loaderMain.sourceComponent = compNull
            loaderMain.width = root.width-(lvMenu.height)
            loaderMain.source = "Arquivos.qml"
            tituloHome.text = qsTr("FORMATOS")
            tituloHome.x = 150
        }

    }

    Component.onCompleted: {

        control.currentIndex = Data.receita
    }

    function sendSignal (register, value)
    {
        Data.envioRun = true
        Task.writeParamt(Number(register),Number(value))
        Data.envioRun = false
    }

    ComboBox {
        y: 50
        x: 120
        id: control
        width: 180
        enabled: !Data.recComboCarregando



        model: ["60 x 60", "60 x 100", "70 x 130", "90 x 150", "X x Y"]

        onActivated: {
            Data.receita = currentIndex
            Task.writeParamt(Number(96),Number(currentIndex))
            Data.recAtualiza = true
            loaderEng.sourceComponent = compNull
            loaderEng.source = "Arquivos.qml"
            Data.recComboCarregando = true
        }

        delegate: ItemDelegate {
            width: control.width

            contentItem: Text {
                text: modelData
                font.family: Data.fontFamily
                font.pointSize: Data.fontLabelSize
                color: Paleta.colorPatern
                elide: Text.ElideRight

                verticalAlignment: Text.AlignRight

            }
            highlighted: control.highlightedIndex === index

            background: Rectangle {
                border.color:  Paleta.colorPatern
                border.width: 1.5
                color: "#e6ccff"
                radius: 2
            }
        }

        background: Rectangle {
            implicitWidth: 120
            implicitHeight: 40
            border.color: Paleta.colorPatern
            border.width: control.visualFocus ? 2 : 2
            color: "transparent"
            radius: 2

        }

    }

    ColumnLayout{
        y: 120
        x: 120
        spacing: 50

        Row{
            spacing: 30
            Text {
                id: paradaEsteira
                text: "Esteira parada (mm)"
                font.family: "Arial"
                color: "black"
                font.pointSize: Data.fontLabelSize
                anchors.margins: 2
            }
            TextBoxOpus
            {
                minValue: 0
                maxValue: 9999
                id: boxEsteiraParada
                texto: Data.esteiraParada
                registro: 20
                x_txt: 270
            }
        }
        Row{
            spacing: 30
            Text {
                id: paradaNormal
                text: "Filme parada (mm)"
                font.family: "Arial"
                color: "black"
                font.pointSize: Data.fontLabelSize
                anchors.margins: 2
            }
            TextBoxOpus
            {
                minValue: 0
                maxValue: 9999
                id: boxParadaNormal
                texto: Data.filmeParada
                registro: 12
                x_txt: boxEsteiraParada.x_txt
            }
        }
        Row{
            spacing: 30
            Text {
                id: portinhola
                text: "Portinhola parada (mm)"
                font.family: "Arial"
                color: "black"
                font.pointSize: Data.fontLabelSize
                anchors.margins: 2
            }

            TextBoxOpus
            {
                minValue: 0
                maxValue: 9999
                id: boxPortinhola
                texto: Data.portinholaParada
                registro: 22
                x_txt: boxEsteiraParada.x_txt
            }
        }
        Row{
            spacing: 30
            Text {
                id: atrasoInicio
                text: "Atraso inicío (ms)"
                font.family: "Arial"
                color: "black"
                font.pointSize: Data.fontLabelSize
                anchors.margins: 2
            }
            TextBoxOpus
            {
                minValue: 0
                maxValue: 999
                id: boxAtrasoInicio
                texto: Data.inicioAtraso
                registro: 8
                x_txt: boxEsteiraParada.x_txt
            }
        }
        Row{
            spacing: 30
            Text {
                id: atrasoAr
                text: "Atraso ampola (ms)"
                font.family: "Arial"
                color: "black"
                font.pointSize: Data.fontLabelSize
                anchors.margins: 2
            }
            TextBoxOpus
            {
                minValue: 0
                maxValue: 999
                id: boxAmpolaAtraso
                texto: Data.ampolaAtraso
                registro: 10
                x_txt: boxEsteiraParada.x_txt
            }

        }
        Row{
            spacing: 30
            Text {
                id: atrasoInjAr
                text: "Atraso ar (ms)"
                font.family: "Arial"
                color: "black"
                font.pointSize: Data.fontLabelSize
                anchors.margins: 2
            }
            TextBoxOpus
            {
                minValue: 0
                maxValue: 999
                id: boxAtrasoInjAr
                texto: Data.arAtraso
                registro: 14
                x_txt: boxEsteiraParada.x_txt
            }
        }
        Row{
            spacing: 30
            Text {
                id: durInjAr
                text: "Duração ar (ms)"
                font.family: "Arial"
                color: "black"
                font.pointSize: Data.fontLabelSize
                anchors.margins: 2
            }
            TextBoxOpus
            {
                minValue: 0
                maxValue: 999
                id: boxDurInjAr
                texto: Data.duracaoInjAr
                registro: 16
                x_txt: boxEsteiraParada.x_txt
            }
        }
        Text {
            text: "Barcode"
            visible: false
            id: labelBarcode
            font.family: "Arial"
            color: controlBarcode.checked ? "#667ab3" : "black"
            font.pointSize: Data.fontLabelSize
            height: 50
        }
    }
    Switch{
        y: 360
        x: 219
        id: controlBarcode
        implicitHeight: 50
        implicitWidth: 200
        visible: false

        onReleased: {

            if(controlBarcode.checked){
                Data.envioRun = true
                Task.enableDevice(37,4,true)
                Data.barcodeCtr = true
                Data.envioRun = false

            } else{
                Data.envioRun = true
                Task.enableDevice(37,4,false)
                Data.barcodeCtr = false
                Data.envioRun = false
            }

        }
        indicator: Rectangle{
            implicitWidth: 70
            implicitHeight: 32
            radius: 16
            color: controlBarcode.checked ? "#667ab3" : "#ffffff"
            border.color: controlBarcode.checked ? "#667ab3" : "#cccccc"
            border.width: 2

            Rectangle {
                x: controlBarcode.checked ? parent.width - width : 0
                width: 32
                height: 32
                radius: 16
                color: "white"
                border.color: "#999999"
                border.width: 2
            }
        }
        contentItem: Text {
            text: controlBarcode.text
            font: controlBarcode.font
            color: controlBarcode.down ? "#17a81a" : "#21be2b"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Loader {
        id: loaderEng

        anchors.top: root.top
        anchors.left: root.left

        height: root.height-(footer.height+footer.height)
        width: root.width
        x: 20
        y: 80

    }

    Component { id: compNull; Item {} }
}




