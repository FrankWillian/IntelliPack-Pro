#ifndef OPUSMODBUS_H
#define OPUSMODBUS_H

#include <QObject>
#include <QModbusDataUnit>
#include <QTimer>

class QModbusClient;
class QModbusReply;

class OpusModBus : public QObject
{
    Q_OBJECT

public:
    explicit OpusModBus(QObject *parent = nullptr);

    void readValue(int addr);
    void readValue(const int numValues, const int addr, const int startAddr);
    void writeValue(int addr, const QVariant value);
    void writeValue(quint16 reg, quint16 value);
    void writeValue(const int addr, const int startAddr, const int numValues, const QVariant value);
    void storeValue(quint16 reg, quint16 value);
    void saveToFile(QString fileName);
    quint16 seekValue(quint16 reg);
    void sendValues(int addr);
    void initModBus();
    bool connectModBus();

    void setIP(const QString ip) { m_ipMB = ip; }
    QString getIP() const { return m_ipMB; }
    void setPort(const QString port) { m_portMB = port; }
    QString getPort() const { return m_portMB; }

    // Variavel estatica para qualquer um sem ter que criar objeto possa obter este valor
    static int serverAddr;
    void setServerAddr(const int sa) { serverAddr = sa; }
    int getServerAddr() const { return serverAddr; }

    //Retorna o status de conexão do Modbus
    bool isConnected();

    //Request Reconnection
    void RequestReconn();

    enum MessagesAddress
    {
        MA_ContaSet = 0,
        MA_PosSelagem = 2,
        MA_TpoSelagem = 4,
        MA_EsteiraAtraso = 6,
        MA_InicioAtraso = 8,
        MA_AmpolaAtraso = 10,
        MA_FilmeParada = 12,
        MA_ArAtraso = 14,
        MA_DuracaoInjAr = 16,
        MA_TpoPortAberta = 18,
        MA_EsteiraParada = 20,
        MA_PortinholaParada = 22,
        MA_EsteiraVeloc = 24,
        MA_EsteiraAcc = 26,
        MA_EsteiraDec = 28,
        MA_PortVeloc = 30,
        MA_PortAcc = 32,
        MA_PortDec = 34,
        MA_DesligAr = 36,

        MA_Alarmes = 44,

        MA_Estado = 50,
        MA_PortVelocMotion = 52,
        MA_PortAccMotion = 54,
        MA_PortDecMotion = 56,
        MA_PortRelatMotion = 58,
        MA_TracaoVelocMotion = 60,
        MA_TracaoAccMotion = 62,
        MA_TracaoDecMotion = 64,
        MA_TracaoRelatMotion = 66,
        MA_TracaoVeloc = 68,
        MA_TracaoAcc = 70,
        MA_TracaoDec = 72,
        MA_SelagVeloc = 74,
        MA_SelagAcc = 76,
        MA_SelagDec = 78,
        MA_SelagVelocMotion = 80,
        MA_SelagAccMotion = 82,
        MA_SelagDecMotion = 84,
        MA_SelagRelatMotion = 86,
        MA_EsteiraVelocMotion = 88,
        MA_EsteiraAccMotion = 90,
        MA_EsteiraDecMotion = 92,
        MA_EsteiraRelatMotion = 94,

        // Somente leitura
        MA_receita = 96,//
        MA_ProdutiMedia = 98,//
        MA_ContaGeral = 100,//
        MA_ContaAtual = 102,
        MA_InfoHrsEnerg = 104,//
        MA_InfoMinEnerg = 106,//
        MA_InfoHorasProd = 108,//
        MA_InfoMinProd = 110,//
        MA_DataDia = 112,//
        MA_DataMes = 114,//
        MA_Hora = 116,//
        MA_Min = 118,//
        MA_VelocMedia = 120,//
        MA_teste19 = 240,//

        MA_MAX
    };

private:
    typedef struct s_WriteMsgMirror
    {
        quint16 Register;
        quint16 Value;
    }t_WriteMsgMirror;

    QModbusReply *lastRequest;
    QModbusClient *modbusDevice;
    QVector<quint16> m_holdingRegisters;

    QString m_ipMB;
    QString m_portMB;
    qint32 m_readStartAddr;
    qint32 m_readNumValues;
    qint32 m_writeStartAddr;
    qint32 m_writeNumValues;

    QString m_conectMsg;

    QVector<t_WriteMsgMirror> m_WriteMsgMirror;
    QVector<t_WriteMsgMirror> m_ReadMsgMirror;

    QModbusDataUnit readRequest() const;
    QModbusDataUnit writeRequest() const;

    void procData(const QModbusDataUnit *du);

    bool flagReconnec = false;

signals:
    void readyData(QString data);
    void readyMD0(QString data);
    void readyMD1(QString data);
    void readyMD2(QString data);
    void readyMD3(QString data);
    void readyMD4(QString data);
    void readyMD5(QString data);
    void readyMD6(QString data);
    void readyMD7(QString data);
    void readyMD8(QString data);
    void readyMD9(QString data);
    void readyMD10(QString data);
    void readyMD11(QString data);
    void readyMD12(QString data);
    void readyMD13(QString data);
    void readyMD14(QString data);
    void readyMD15(QString data);
    void readyMD16(QString data);
    void readyMD17(QString data);
    void readyMD18(QString data);

    void readyMD25(QString data);
    void readyMD26(QString data);
    void readyMD27(QString data);
    void readyMD28(QString data);
    void readyMD29(QString data);
    void readyMD30(QString data);
    void readyMD31(QString data);
    void readyMD32(QString data);
    void readyMD33(QString data);
    void readyMD34(QString data);
    void readyMD35(QString data);
    void readyMD36(QString data);
    void readyMD37(QString data);
    void readyMD38(QString data);
    void readyMD39(QString data);
    void readyMD40(QString data);
    void readyMD41(QString data);
    void readyMD42(QString data);
    void readyMD43(QString data);
    void readyMD44(QString data);
    void readyMD45(QString data);
    void readyMD46(QString data);
    void readyMD47(QString data);
    void readyMD48(QString data);
    void readyMD49(QString data);

    // Somente leitura
    void readyMD50(QString data);
    void readyMD51(QString data);
    void readyMD52(QString data);
    void readyMD53(QString data);
    void readyMD54(QString data);
    void readyMD55(QString data);
    void readyMD56(QString data);
    void readyMD57(QString data);
    void readyMD58(QString data);
    void readyMD59(QString data);
    void readyMD60(QString data);

    void readyMD120(QString data);

    void readyMD70(QString data);


    void readyAlarm(QString data);
    void readyTemp(QString data);

    void conexao(QString erro);

    void SendDateTime(QString date);

public slots:

private slots:
    void onStateChanged(int state);
    void readReady();



};

#endif // OPUSMODBUS_H
