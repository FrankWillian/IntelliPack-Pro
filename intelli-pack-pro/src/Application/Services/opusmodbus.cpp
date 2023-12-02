#include "opusmodbus.h"
#include <QDateTime>
#include <QDebug>
#include <QModbusTcpClient>
#include <QFile>
#include <QQmlEngine>       //qmlRegisterType
#include <QDir>
#include "task.h"

/**
 * Inicialização das variaveis estaticas da classe OpusModBus
 */
int OpusModBus::serverAddr(1);

#ifdef QT_DEBUG
/**
 * @brief logging
 * @param func
 * @param msg
 * @return
 */
static QString logging(const char *func, const char *msg)
{
    // Data                  Funcao         Mensagem
    // [06/09/2017 20:14:56] <OpusModBus> : OpusModBus Created

    QString fmtMsg;
    QString fmtFunc(func);
    QDateTime dateNow = QDateTime::currentDateTime();

    fmtMsg.append("[" + QDateTime::fromString(dateNow.toString()).toString("dd/MM/yyyy hh:mm:ss") + "] ");
    //fmtMsg.append(QString("<")+func+QString(">"));
    fmtMsg.append("<"+fmtFunc+">");
    fmtMsg.append(" : ");
    fmtMsg.append(msg);

    return fmtMsg;
}

#endif
/**
 * @brief OpusModBus::OpusModBus
 * @param parent
 */
OpusModBus::OpusModBus(QObject *parent)
    : QObject(parent)
    , modbusDevice(nullptr)
    , m_holdingRegisters(10, 0u)
    , m_ipMB("127.0.0.1")
    , m_portMB("502")
    , m_readStartAddr(0)
    , m_readNumValues(10)
    , m_writeStartAddr(0)
    , m_writeNumValues(10)
{
#ifdef QT_DEBUG
    qDebug().noquote() << logging(__func__, "Construtor classe OpusModBus") << endl;
#endif

}

/**
 * @brief OpusModBus::readRequest
 * @return
 */
QModbusDataUnit OpusModBus::readRequest() const
{
    const auto table = static_cast<QModbusDataUnit::RegisterType> (QModbusDataUnit::HoldingRegisters);

    int startAddress = this->m_readStartAddr;
    //Q_ASSERT(startAddress >= 0 && startAddress < 10);

    // do not go beyond 10 entries
    //int numberOfEntries = qMin(10, 10 - startAddress);
    int numberOfEntries = this->m_readNumValues;

    return QModbusDataUnit(table, startAddress, numberOfEntries);
}

/**
 * @brief OpusModBus::writeRequest
 * @return
 */
QModbusDataUnit OpusModBus::writeRequest() const
{
    const auto table = static_cast<QModbusDataUnit::RegisterType> (QModbusDataUnit::HoldingRegisters);

    int startAddress = this->m_writeStartAddr;
    Q_ASSERT(startAddress >= 0 && startAddress < 10);

    // do not go beyond 10 entries
    //int numberOfEntries = qMin(10, 10 - startAddress);
    int numberOfEntries = this->m_writeNumValues;

    return QModbusDataUnit(table, startAddress, numberOfEntries);
}

/**
 * @brief OpusModBus::procData
 * @param du
 */
void OpusModBus::procData(const QModbusDataUnit *du)
{
    const QModbusDataUnit unit = *du;
    quint16 address = static_cast<quint16>(this->MessagesAddress::MA_ContaSet);
    qint16 day = 0, month = 0, hour = 0, min = 0;
    QString dateTime;
#ifdef QT_DEBUG
    //qDebug().noquote() << logging(__func__, QString("Tamanho do bloco a ser lido: %1").arg(unit.valueCount()).toStdString().c_str()) << endl;
#endif
    do
    {
        //Store the received value locally in order to be restore further
        storeValue(address, unit.value(address));
        switch (address)
        {
        case this->MessagesAddress::MA_ContaSet:
            emit readyMD0(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_PosSelagem:
            emit readyMD1(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_TpoSelagem:
            emit readyMD2(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_EsteiraAtraso:
            emit readyMD3(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_InicioAtraso:
            emit readyMD4(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_AmpolaAtraso:
            emit readyMD5(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_FilmeParada:
            emit readyMD6(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_ArAtraso:
            emit readyMD7(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_DuracaoInjAr:
            emit readyMD8(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_TpoPortAberta:
            emit readyMD9(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_EsteiraParada:
            emit readyMD10(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_PortinholaParada:
            emit readyMD11(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_EsteiraVeloc:
            emit readyMD12(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_EsteiraAcc:
            emit readyMD13(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_EsteiraDec:
            emit readyMD14(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_PortVeloc:
            emit readyMD15(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_PortAcc:
            emit readyMD16(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_PortDec:
            emit readyMD17(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_DesligAr:
            emit readyMD18(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_Estado:
            emit readyMD25(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_PortVelocMotion:
            emit readyMD26(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_PortAccMotion:
            emit readyMD27(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_PortDecMotion:
            emit readyMD28(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_PortRelatMotion:
            emit readyMD29(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_TracaoVelocMotion:
            emit readyMD30(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_TracaoAccMotion:
            emit readyMD31(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_TracaoDecMotion:
            emit readyMD32(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_TracaoRelatMotion:
            emit readyMD33(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_TracaoVeloc:
            emit readyMD34(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_TracaoAcc:
            emit readyMD35(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_TracaoDec://
            emit readyMD36(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_SelagVeloc://
            emit readyMD37(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_SelagAcc://
            emit readyMD38(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_SelagDec://
            emit readyMD39(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_SelagVelocMotion://
            emit readyMD40(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_SelagAccMotion:
            emit readyMD41(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_SelagDecMotion:
            emit readyMD42(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_SelagRelatMotion:
            emit readyMD43(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_EsteiraVelocMotion:
            emit readyMD44(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_EsteiraAccMotion:
            emit readyMD45(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_EsteiraDecMotion:
            emit readyMD46(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_EsteiraRelatMotion:
            emit readyMD47(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_receita:
            emit readyMD48(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_ProdutiMedia://
            emit readyMD49(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_ContaGeral://
            emit readyMD50(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_ContaAtual://
            emit readyMD51(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_InfoHrsEnerg://
            emit readyMD52(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_InfoMinEnerg://
            emit readyMD53(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_InfoHorasProd://
            emit readyMD54(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_InfoMinProd://
            emit readyMD55(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_DataDia://
            emit readyMD56(QString::number(unit.value(address)));
            day = unit.value(address);
            break;
        case this->MessagesAddress::MA_DataMes://
            emit readyMD57(QString::number(unit.value(address)));
            month = unit.value(address);
            break;
        case this->MessagesAddress::MA_Hora://
            emit readyMD58(QString::number(unit.value(address)));
            hour = unit.value(address);
            break;
        case this->MessagesAddress::MA_Min://
            emit readyMD59(QString::number(unit.value(address)));
            min = unit.value(address);
            break;
        case this->MessagesAddress::MA_VelocMedia://
            emit readyMD60(QString::number(unit.value(address)));
            break;
        case this->MessagesAddress::MA_teste19://
            emit readyMD120(QString::number(unit.value(address)));
            break;

        case this->MessagesAddress::MA_Alarmes:
        {
            quint16 valueAlarm = unit.value(address);
#ifdef QT_DEBUG
            qDebug().noquote() << logging(__func__, QString("Endereço de Alarme 44").toStdString().c_str()) << endl;
#endif

            if      (valueAlarm & (1<<0))  {  emit readyAlarm("01");  }
            else if (valueAlarm & (1<<1))  {  emit readyAlarm("02");  }
            else if (valueAlarm & (1<<2))  {  emit readyAlarm("03");  }
            else if (valueAlarm & (1<<3))  {  emit readyAlarm("04");  }
            else if (valueAlarm & (1<<4))  {  emit readyAlarm("05");  }
            else if (valueAlarm & (1<<5))  {  emit readyAlarm("06");  }
            else if (valueAlarm & (1<<6))  {  emit readyAlarm("07");  }
            else if (valueAlarm & (1<<7))  {  emit readyAlarm("08");  }
            else if (valueAlarm & (1<<8))  {  emit readyAlarm("09");  }
            else if (valueAlarm & (1<<9))  {  emit readyAlarm("10");  }
            else if (valueAlarm & (1<<10)) {  emit readyAlarm("11");  }
            else if (valueAlarm & (1<<11)) {  emit readyAlarm("12");  }
            else if (valueAlarm & (1<<12)) {  emit readyAlarm("13");  }
            else if (valueAlarm & (1<<13)) {  emit readyAlarm("14");  }
            else if (valueAlarm & (1<<14)) {  emit readyAlarm("15");  }
            else if (valueAlarm & (1<<15)) {  emit readyAlarm("16");  }
            else if (valueAlarm == 0)      {  emit readyAlarm("00");  }
            break;
        }
        default:
            break;
        }
    }while(address++ < static_cast<quint16>(this->MessagesAddress::MA_MAX));

    //Check if received a valid date and time, and update system values
    //    month = 10;
    //    min = 10;
    //    hour = 10;
    //    day = 10;

    if((month != 0) && (day != 0))
    {
        dateTime = QString::number(day) + "/" + QString::number(month) + " " + QString::number(hour) + ":" + QString::number(min);
    }

    emit SendDateTime(dateTime);
}

/**
 * @brief OpusModBus::readValue
 * @param addr
 */
void OpusModBus::readValue(int addr)
{
#ifdef QT_DEBUG
    //qDebug() << "Start Address   : " << this->m_readStartAddr << endl;
    //qDebug() << "Num Values      : " << this->m_readNumValues << endl;
#endif
    if (!modbusDevice)
        return;

    if (auto *reply = modbusDevice->sendReadRequest(readRequest(), addr)) {
        if (!reply->isFinished())
            connect(reply, &QModbusReply::finished, this, &OpusModBus::readReady);
        else
            delete reply; // broadcast replies return immediately
    } else {

        emit conexao("Desconectado");
#ifdef QT_DEBUG
        qDebug().noquote() << logging(__func__, QString("Erro: %1").arg(
                                          modbusDevice->errorString()
                                          ).toStdString().c_str()) << endl;
#endif
    }

}

/**
 * @brief OpusModBus::readValue
 * @param addr
 * @param startAddr
 * @param numValues
 */
void OpusModBus::readValue(const int addr, const int startAddr, const int numValues)
{
    this->m_readNumValues = numValues;
    this->m_readStartAddr = startAddr;

    this->readValue(addr);
}

/**
 * @brief OpusModBus::writeValue
 * @param addr
 * @param value
 */
void OpusModBus::writeValue(int addr, const QVariant value)
{
    if (!modbusDevice)
        return;

    // Iniciando DataUnit para escrita com 0
    QModbusDataUnit writeUnit(QModbusDataUnit::HoldingRegisters, this->m_writeStartAddr, 1);

    // Inserindo o valor da escrita na posicao que é o Start Address(offset) do endereço
    // base HoldingRegister
    bool result = false;
    quint16 newValue = value.toString().toUShort(&result, 10);
    if (result)
    {
        this->m_holdingRegisters[this->m_writeStartAddr] = newValue;
    }

    // Preenchendo o DataUnit para escrita
    for (uint i = 0; i < writeUnit.valueCount(); i++) {
        writeUnit.setValue(i, this->m_holdingRegisters[i + writeUnit.startAddress()]);
        // Descomento somente para depurar os campos
#ifdef QT_DEBUG
        //qDebug() << "StartAddress: "<< writeUnit.startAddress() <<" ["<<
        //            i+writeUnit.startAddress()<<"] " <<
        //            this->m_holdingRegisters[i + writeUnit.startAddress()] << endl;
#endif
    }


    // Enviando o DataUnit
    if (auto *reply = modbusDevice->sendWriteRequest(writeUnit, addr)) {
        if (!reply->isFinished()) {
            connect(reply, &QModbusReply::finished, this, [this, reply]() {
                if (reply->error() == QModbusDevice::ProtocolError) {
#ifdef QT_DEBUG
                    qDebug().noquote() << logging(__func__, QString("Erro resposta: %1 (ModBus excecao: %2)").arg(
                                                      reply->errorString(),
                                                      reply->rawResult().exceptionCode()
                                                      ).toStdString().c_str()) << endl;
#endif
                } else if (reply->error() != QModbusDevice::NoError) {
#ifdef QT_DEBUG
                    qDebug().noquote() << logging(__func__, QString("Erro resposta: %1 (codigo: %2)").arg(
                                                      reply->errorString(),
                                                      reply->error()
                                                      ).toStdString().c_str()) << endl;
#endif
                }
                reply->deleteLater();
            });
        } else {
            // broadcast replies return immediately
            reply->deleteLater();
        }
    } else {
#ifdef QT_DEBUG
        qDebug().noquote() << logging(__func__, QString("Erro: %1").arg(
                                          modbusDevice->errorString()
                                          ).toStdString().c_str()) << endl;
#endif
    }
}

/**
 * @brief OpusModBus::writeValue
 * @param reg
 * @param value
 */
void OpusModBus::writeValue(quint16 reg, quint16 value)
{

    //Iniciando uma variável para salvar na tabela de mirror de escrita
    t_WriteMsgMirror mirror;
    mirror.Register = reg;
    mirror.Value = value;

    //Procura pela ocorrência do item na tabela
    int i = 0;
    int find_index = -1;

    while(i < m_WriteMsgMirror.size())
    {
        if(m_WriteMsgMirror[i].Register == mirror.Register)
        {
            find_index = i;
            break;
        }
        else
        {
            i++;
        }
    }

    //Se encontrar, sobrescreve o item
    if(find_index != -1)
    {
        m_WriteMsgMirror.replace(find_index, mirror);
    }
    //Se não encontrar, adiciona o item a lista
    else
    {
        m_WriteMsgMirror.append(mirror);
    }
}

/**
 * @brief OpusModBus::storeValue
 * @param reg
 * @param value
 */
void OpusModBus::storeValue(quint16 reg, quint16 value)
{

    //Iniciando uma variável para salvar na tabela de mirror de escrita
    t_WriteMsgMirror mirror;
    mirror.Register = reg;
    mirror.Value = value;

    //Procura pela ocorrência do item na tabela
    int i = 0;
    int find_index = -1;

    while(i < m_ReadMsgMirror.size())
    {
        if(m_ReadMsgMirror[i].Register == mirror.Register)
        {
            find_index = i;
            break;
        }
        else
        {
            i++;
        }
    }

    //Se encontrar, sobrescreve o item
    if(find_index != -1)
    {
        m_ReadMsgMirror.replace(find_index, mirror);
    }
    //Se não encontrar, adiciona o item a lista
    else
    {
        m_ReadMsgMirror.append(mirror);
    }
}

/**
 * @brief OpusModBus::saveToFile
 * @param fileName
 */
void OpusModBus::saveToFile(QString fileName)
{
    QFile arquivo;
    QVector<QString> TabelaCSV;
    QStringList Lista;
    QString reg;

    //Removo qualquer arquivo já existente
    QFile::remove(QDir::homePath() + "/" + fileName);

    //Crio um novo arquivo
    arquivo.setFileName(QDir::homePath() + "/" + fileName);

    //Varro todos os registros salvos e salvo na tabela de strings
    for(int i = 0;i < m_ReadMsgMirror.size();i++)
    {
        TabelaCSV.append(QString::number(m_ReadMsgMirror[i].Register) + "," + QString::number(m_ReadMsgMirror[i].Value));
    }

    arquivo.close();

    //Abro o arquivo novamente para escrever a tabela alterada
    if(arquivo.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QTextStream out(&arquivo);

        for(int i = 0;i < TabelaCSV.size();i++)
        {
            out << TabelaCSV[i] << "\n";
        }
    }
    arquivo.close();
}

/**
 * @brief OpusModBus::seekValue
 * @param reg
 * @return
 */
quint16 OpusModBus::seekValue(quint16 reg)
{
    //Procura pela ocorrência do item na tabela
    int i = 0;
    int find_index = -1;
    quint16 ret = 0;

    for(i = 0;i < m_WriteMsgMirror.size();i++)
    {
        if(m_WriteMsgMirror[i].Register == reg)
        {
            find_index = i;
            break;
        }
    }

    if(find_index == -1)
    {
        ret = 0;
    }
    else
    {
        ret = m_WriteMsgMirror[i].Value;
    }

    return ret;
}

/**
 * @brief OpusModBus::sendValues
 * @param addr
 */
void OpusModBus::sendValues(int addr)
{
    if (!modbusDevice)
        return;

    //Descobre a messagem cujo valor de registro é o maior dentro da tabela
    quint16 index_maior = 0;

    for(int i = 0;i < m_WriteMsgMirror.size();i++)
    {
        if(m_WriteMsgMirror[i].Register > index_maior) {index_maior = m_WriteMsgMirror[i].Register;}
    }

    // Iniciando DataUnit para escrita
    QModbusDataUnit writeUnit(QModbusDataUnit::HoldingRegisters, 0, static_cast<int>(index_maior + 1));

    // Preenchendo o DataUnit para escrita
    for (uint i = 0; i < writeUnit.valueCount(); i++)
    {
        quint16 valor = 0x0000;
        //Faz uma busca pela tabela mirror para descubrir se o registro existe dentro dela
        //caso sim, preenche a DataUnit com o valor da tabela, caso contrário, preenche como 0x0000
        for(int index = 0;index < m_WriteMsgMirror.size();index++)
        {
            if(i == m_WriteMsgMirror[index].Register)
            {
                valor = m_WriteMsgMirror[index].Value;
                break;
            }
        }

        writeUnit.setValue(i, valor);
        // Descomento somente para depurar os campos
#ifdef QT_DEBUG
        qDebug() << "StartAddress: "<< writeUnit.startAddress() <<" ["<<
                    i <<"] " << valor << endl;
#endif
    }


    // Enviando o DataUnit
    if (auto *reply = modbusDevice->sendWriteRequest(writeUnit, addr)) {
        if (!reply->isFinished()) {
            connect(reply, &QModbusReply::finished, this, [this, reply]() {
                if (reply->error() == QModbusDevice::ProtocolError) {
#ifdef QT_DEBUG
                    qDebug().noquote() << logging(__func__, QString("Erro resposta: %1 (ModBus excecao: %2)").arg(
                                                      reply->errorString(),
                                                      reply->rawResult().exceptionCode()
                                                      ).toStdString().c_str()) << endl;
#endif
                } else if (reply->error() != QModbusDevice::NoError) {
#ifdef QT_DEBUG
                    qDebug().noquote() << logging(__func__, QString("Erro resposta: %1 (codigo: %2)").arg(
                                                      reply->errorString(),
                                                      reply->error()
                                                      ).toStdString().c_str()) << endl;
#endif
                }
                reply->deleteLater();
            });
        } else {
            // broadcast replies return immediately
            reply->deleteLater();
        }
    } else {
#ifdef QT_DEBUG
        qDebug().noquote() << logging(__func__, QString("Erro: %1").arg(
                                          modbusDevice->errorString()
                                          ).toStdString().c_str()) << endl;
#endif
    }
}

/**
 * @brief OpusModBus::writeValue
 * @param addr
 * @param startAddr
 * @param numValues
 * @param value
 */
void OpusModBus::writeValue(const int addr, const int startAddr, const int numValues, const QVariant value)
{
    this->m_writeNumValues = numValues;
    this->m_writeStartAddr = startAddr;

    this->writeValue(addr, value);
}

/**
 * @brief OpusModBus::initModBus
 */
void OpusModBus::initModBus()
{
#ifdef QT_DEBUG
    qDebug().noquote() << logging(__func__, "Iniciando ModBus") << endl;
#endif

    if (modbusDevice) {
        modbusDevice->disconnectDevice();
        delete modbusDevice;
        modbusDevice = nullptr;
    }

    modbusDevice = new QModbusTcpClient(this);

    connect(modbusDevice, &QModbusClient::errorOccurred, [this](QModbusDevice::Error) {
#ifdef QT_DEBUG
        qDebug() << modbusDevice->errorString() << endl;
#endif
    });

    if (!modbusDevice) {
#ifdef QT_DEBUG
        qDebug().noquote() << logging(__func__, "Could not create ModBus Master") << endl;
#endif
    } else {
        connect(modbusDevice, &QModbusClient::stateChanged,
                this, &OpusModBus::onStateChanged);
    }

}

/**
 * @brief OpusModBus::connectModBus
 * @return
 */
bool OpusModBus::connectModBus()
{
#ifdef QT_DEBUG
    qDebug().noquote() << logging(__func__, "Conectando ModBus") << endl;
#endif
    emit conexao("Conectado");
    if (!modbusDevice)
        return false;

    if (modbusDevice->state() != QModbusDevice::ConnectedState) {
#ifdef QT_DEBUG
        qDebug().noquote() << logging(__func__, QString("IP: %1 Porta: %2").arg(getIP(),getPort()).toStdString().c_str()) << endl;
#endif
        // Set Port MODBUS and IP
        modbusDevice->setConnectionParameter(QModbusDevice::NetworkPortParameter, getPort().toInt());
        modbusDevice->setConnectionParameter(QModbusDevice::NetworkAddressParameter, getIP());

        modbusDevice->setTimeout(1000);
        modbusDevice->setNumberOfRetries(3);

        if (!modbusDevice->connectDevice()) {
#ifdef QT_DEBUG
            qDebug().noquote() << logging(__func__, QString("Falha ao conectar no dispositivo: %1").arg(modbusDevice->errorString()).toStdString().c_str() ) << endl;
#endif
            return false;
        }

    } else {
#ifdef QT_DEBUG
        qDebug().noquote() << logging(__func__, "ModBus conectado, desconectando aguarde...") << endl;
#endif
        modbusDevice->disconnectDevice();
    }

    return true;
}

/**
 * @brief OpusModBus::onStateChanged
 * @param state
 */
void OpusModBus::onStateChanged(int state)
{
    //bool connected = (state != QModbusDevice::UnconnectedState);

    if (state == QModbusDevice::UnconnectedState) {
#ifdef QT_DEBUG
        qDebug().noquote() << logging(__func__, "Desconectado") << endl;
#endif
    }
    else if (state == QModbusDevice::ConnectedState) {
#ifdef QT_DEBUG
        qDebug().noquote() << logging(__func__, "Conectado") << endl;
#endif
    }

}

/**
 * @brief OpusModBus::readReady
 */
void OpusModBus::readReady()
{
    auto reply = qobject_cast<QModbusReply *>(sender());
    if (!reply)
        return;

    if (reply->error() == QModbusDevice::NoError) {
        const QModbusDataUnit unit = reply->result();
#ifdef QT_DEBUG
        //qDebug().noquote() << logging(__func__, QString("Tamanho do bloco a ser lido: %1").arg(unit.valueCount()).toStdString().c_str()) << endl;
#endif
        this->procData(&unit);

    } else if (reply->error() == QModbusDevice::ProtocolError) {
#ifdef QT_DEBUG
        qDebug().noquote() << logging(__func__, QString("Recebido erro Frank 1: %1 (ModBus excecao: 0x%2)").arg(
                                          reply->errorString(),
                                          reply->rawResult().exceptionCode()
                                          ).toStdString().c_str()) << endl;
#endif
    } else {
        emit conexao("Desconectado");
#ifdef QT_DEBUG
        qDebug().noquote() << logging(__func__, QString("Recebido erro Frank 2: %1 (codigo: %2)").arg(
                                          reply->errorString(),
                                          reply->error()
                                          ).toStdString().c_str()) << endl;
#endif

        this->RequestReconn();
    }

    reply->deleteLater();
}

/**
 * @brief OpusModBus::isConnected
 * @return
 */
bool OpusModBus::isConnected()
{
    bool ret = true;
    auto status = modbusDevice->state();

    if(OpusModBus::flagReconnec == true)
    {
        OpusModBus::flagReconnec = false;
        ret = false;
    }
    else
    {
        switch (status)
        {
        case QModbusDevice::UnconnectedState:
        case QModbusDevice::ConnectingState:
        case QModbusDevice::ClosingState:
            ret = false;
            break;
        case QModbusDevice::ConnectedState:
            ret = true;
            break;
        default:
            ret = false;
            break;
        }
    }

    return ret;
}

void OpusModBus::RequestReconn()
{
    OpusModBus::flagReconnec = true;
}





