pragma Singleton
import QtQuick 2.4

QtObject {


    // Versao
    readonly property string version: "OPUS35"

    // Padrao Opus
    property int fontLabelSize: 16
    property int fontValueSize: 14
    property string fontFamily: "Arial"

    // Controls
    property string modoEsteira: "apagado"
    property string modoNormalCtr: "apagado"
    property string agrupadorCtr: "apagado"
    property bool barcodeCtr: false

    property string setUpCtr: "apagado"

    property string medicamento: ""

    // Modbus
    property string dataModBus: "LOG:"


    // Seguranca
    property string nameLoginAdmin: "opuspac"
    property string nameLoginSuper: "supervisor"
    property string nameLoginDigitado: ""
    property string nameLoginCarregado: ""
    property bool   userLoginAdmin: false
    property bool   userLoginSuper: false
    property string passwordAdmin: "192837"
    property string passwordSuper: "172839"
    property string passwordDigitado: ""

    // PLC >> QML
    property string contaSet: "0"                   //MD0
    property string posicaoSelagem: "0"             //MD1
    property string tempoSelagem: "0"               //MD2
    property string esteiraAtraso: "0"              //MD3
    property string inicioAtraso: "0"               //MD4
    property string ampolaAtraso: "0"               //MD5
    property string filmeParada: "0"                //MD6
    property string arAtraso: "0"                   //MD7
    property string duracaoInjAr: "0"               //MD8
    property string tpoPortAberta: "0"              //MD9
    property string esteiraParada: "0"              //MD10
    property string portinholaParada: "0"           //MD11
    property string esteiraVeloc: "0"               //MD12
    property string esteiraAcc: "0"                 //MD13
    property string esteiraDec: "0"                 //MD14
    property string portinholaVeloc: "0"            //MD15
    property string portinholaAcc: "0"              //MD16
    property string portinholaDec: "0"              //MD17
    property string desligaAr: "0"                  //MD18

    property string estado: "0"                     //MD25
    property string portinholaVelocMotion: "0"      //MD26
    property string portinholaAccMotion: "0"        //MD27
    property string portinholaDecMotion: "0"        //MD28
    property string portinholaRelatMotion: "0"      //MD29
    property string tracaoVelocMotion: "0"          //MD30
    property string tracaoAccMotion: "0"            //MD31
    property string tracaoDecMotion: "0"            //MD32
    property string tracaoRelatMotion: "0"          //MD33
    property string tracaoVeloc: "0"                //MD34
    property string tracaoAcc: "0"                  //MD35
    property string tracaoDec: "0"                  //MD36
    property string selagVeloc: "0"                 //MD37
    property string selagAcc: "0"                   //MD38
    property string selagDec: "0"                   //MD39
    property string selagVelocMotion: "0"           //MD40
    property string selagAccMotion: "0"             //MD41
    property string selagDecMotion: "0"             //MD42
    property string selagRelatMotion: "0"           //MD43
    property string esteiraVelocMotion: "0"         //MD44
    property string esteiraAccMotion: "0"           //MD45
    property string esteiraDecMotion: "0"           //MD46
    property string esteiraRelatMotion: "0"         //MD47
    property string receita: "0"                    //MD48
    property string produtiMedia: "0"               //MD49
    property string contaGeral: "0"                 //MD50
    property string contaAtual: "0"                 //MD51
    property string infoHrsEnerg: "0"               //MD52
    property string infoMinEnerg: "0"               //MD53
    property string infoHorasProd: "0"              //MD54
    property string infoMinProd: "0"                //MD55
    property string dataDia: "0"                    //MD56
    property string dataMes: "0"                    //MD57
    property string hora: "0"                       //MD58
    property string min: "0"                        //MD59
    property string velocMedia: "0"                 //MD60

    property string valuePosicaoFilme: "0"
    property string valueSelagVelocAbert: "0"
    property string valueDecSelag: "0"
    property string valueInicioAbertura: "0" 
    property string valueQtdEsteira: "0"
    property string valueTpoAgrupador: "0"
    property string valueQtdAgrupador: "0"
    property string valueDesligaEsteira: "0"
    property string valueAtrasoPort: "0"
    property string valueDuracaoPort: "0"

    // Novas Variaveis


     property string valueTeste: "0"

    property string valueCoreTemp: "0"

    property string conexao: "Conectado"

    // Flag que sinaliza que algum alarme esta ativo
    property bool alarmActive: false
    property bool alarmeVis: true

    property bool envioRun: false

    //Flag que sinaliza se o botão de rolo esta solto ou preso
    property bool roloSolto: true

    //Flag que sinaliza se o botão de rolo esta solto ou preso
    property bool check: false

    //Habilite essa flag para visualizar o botão de Impressão no menu principal
    property bool impressoraVisivel: true

    //Seta modo de trabalho salvo
    property bool atualizaModo: false
    property bool atualizaControls: false

    property bool recAtualiza: false

    property bool recComboCarregando: false
    property bool firstCarregando: false

    property string valueLogo: "qrc:/CONTENTS/IMAGES/logo-opuspac.svg"

    property bool modoOpusOne: false

    property string testeModbus: ""

    property string barCode: ""

    property string printerParam: ""

    property bool playFilme: false

    property string barcodeColor: "black"
    property string codigoColor: "black"

}
