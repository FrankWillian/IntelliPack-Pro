import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.LocalStorage 2.0
import 'InputFormJS.js' as InputFormJS

Item {
    anchors.fill: parent

    Column{
        spacing: 10
        Row{

            Label{
                text: 'Nome'
            }
            TextField{
                id: nomeTextField
            }
        }
        Row{
            Label{
                text: 'Idade'
            }
            TextField{
                id: idadeTextField

            }
        }

        Button{
            id: salvar
            text: 'Salvar'
            height: 50
            width: parent.width

            onClicked: {
                InputFormJS.input();
            }
        }

        Button{
            id: atras
            text: 'Voltar'
            width: parent.width

            height: 50

            onClicked: {
                stackView.push(dataform)
            }
        }
    }

}
