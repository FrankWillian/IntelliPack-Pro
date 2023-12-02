#include "task.h"
#include "alarmobject.h"
#include <QDateTime>
#include <QDebug>
#include <QProcess>
#include <QFile>
#include <QDir>
#include <QFontDatabase>
#include <QLocale>
#include <QStorageInfo>
#include <QDirIterator>
#include <QQmlApplicationEngine>
#include "tcpserver.h"
#include "simpleserver.h"

/**
 * @brief Task::Task
 * @param parent
 */
Task::Task(QObject *parent) : QObject(parent)
{
#ifdef QT_DEBUG
    qDebug() << "Task Constructor" << endl;
#endif

    m_modbus = new OpusModBus();

    // Inicialização e configuração do Timer que ficara realizando
    // solicitação do MD0(Start Address 0) e Block Size(1)
    // setInterval(X) : X em ms
    m_timer = new QTimer(this);
    m_timerAlarm = new QTimer(this);
    m_timerImpressora = new QTimer(this);

    m_timerImpressora->start();

#ifdef QT_DEBUG
    m_timer->setInterval(100); // Tempo de atualização
    m_timerAlarm->setInterval(1500); // Tempo minimo de visualização
#else
    m_timer->setInterval(20); // Tempo de atualização
    m_timerImpressora->setInterval(30);
    m_timerAlarm->setInterval(1500); // Tempo minimo de visualização
#endif
    //Initcialização de Timer para monitoramento da conexão do Modbus
    connection_timer = new QTimer(this);
    connection_timer->setInterval(5000); // Tempo de atualiação

    // Conexão entre os sinais da classe OpusModBus -> Task -> QML
    QObject::connect(m_modbus, SIGNAL(readyData(QString)), this, SIGNAL(readyData(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD0(QString)), this, SIGNAL(readyMD0(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD1(QString)), this, SIGNAL(readyMD1(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD2(QString)), this, SIGNAL(readyMD2(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD3(QString)), this, SIGNAL(readyMD3(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD4(QString)), this, SIGNAL(readyMD4(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD5(QString)), this, SIGNAL(readyMD5(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD6(QString)), this, SIGNAL(readyMD6(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD7(QString)), this, SIGNAL(readyMD7(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD8(QString)), this, SIGNAL(readyMD8(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD9(QString)), this, SIGNAL(readyMD9(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD10(QString)), this, SIGNAL(readyMD10(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD11(QString)), this, SIGNAL(readyMD11(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD12(QString)), this, SIGNAL(readyMD12(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD13(QString)), this, SIGNAL(readyMD13(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD14(QString)), this, SIGNAL(readyMD14(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD15(QString)), this, SIGNAL(readyMD15(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD16(QString)), this, SIGNAL(readyMD16(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD17(QString)), this, SIGNAL(readyMD17(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD18(QString)), this, SIGNAL(readyMD18(QString)), Qt::DirectConnection);

    QObject::connect(m_modbus, SIGNAL(readyMD25(QString)), this, SIGNAL(readyMD25(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD26(QString)), this, SIGNAL(readyMD26(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD27(QString)), this, SIGNAL(readyMD27(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD28(QString)), this, SIGNAL(readyMD28(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD29(QString)), this, SIGNAL(readyMD29(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD30(QString)), this, SIGNAL(readyMD30(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD31(QString)), this, SIGNAL(readyMD31(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD32(QString)), this, SIGNAL(readyMD32(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD33(QString)), this, SIGNAL(readyMD33(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD34(QString)), this, SIGNAL(readyMD34(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD35(QString)), this, SIGNAL(readyMD35(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD36(QString)), this, SIGNAL(readyMD36(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD37(QString)), this, SIGNAL(readyMD37(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD38(QString)), this, SIGNAL(readyMD38(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD39(QString)), this, SIGNAL(readyMD39(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD40(QString)), this, SIGNAL(readyMD40(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD41(QString)), this, SIGNAL(readyMD41(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD42(QString)), this, SIGNAL(readyMD42(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD43(QString)), this, SIGNAL(readyMD43(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD44(QString)), this, SIGNAL(readyMD44(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD45(QString)), this, SIGNAL(readyMD45(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD46(QString)), this, SIGNAL(readyMD46(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD46(QString)), this, SLOT(readCode(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD47(QString)), this, SIGNAL(readyMD47(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD48(QString)), this, SIGNAL(readyMD48(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD49(QString)), this, SIGNAL(readyMD49(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD50(QString)), this, SIGNAL(readyMD50(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD51(QString)), this, SIGNAL(readyMD51(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD52(QString)), this, SIGNAL(readyMD52(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD53(QString)), this, SIGNAL(readyMD53(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD54(QString)), this, SIGNAL(readyMD54(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD55(QString)), this, SIGNAL(readyMD55(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD56(QString)), this, SIGNAL(readyMD56(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD57(QString)), this, SIGNAL(readyMD57(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD58(QString)), this, SIGNAL(readyMD58(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD59(QString)), this, SIGNAL(readyMD59(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD60(QString)), this, SIGNAL(readyMD60(QString)), Qt::DirectConnection);
    QObject::connect(m_modbus, SIGNAL(readyMD120(QString)), this, SIGNAL(readyMD120(QString)), Qt::DirectConnection);

    QObject::connect(m_modbus, SIGNAL(readyAlarm(QString)), this, SLOT(procAlarms(QString)));
    QObject::connect(m_modbus, SIGNAL(readyTemp(QString)), this, SIGNAL(readyTemp(QString)), Qt::DirectConnection);
    QObject::connect(m_timer, SIGNAL(timeout()), this, SLOT(procTimeout()));
    QObject::connect(m_timerImpressora, SIGNAL(timeout()), this, SLOT(connectImpressora()));
    QObject::connect(connection_timer, SIGNAL(timeout()), this, SLOT(connTimeout()));
    QObject::connect(m_timerAlarm, SIGNAL(timeout()), this, SLOT(alarmResetView()));

    QObject::connect(m_modbus, SIGNAL(conexao(QString)), this, SIGNAL(conexao(QString)), Qt::DirectConnection);

    QObject::connect(m_modbus, SIGNAL(SendDateTime(QString)), this, SLOT(setLocalDateTime(QString)));

    QFontDatabase fontDatabase;
    if (fontDatabase.addApplicationFont(":/CONTENTS/FONTS/digital-7.ttf") == -1)
    {
        qDebug() << "Falha ao carregar fonte!" << endl;
    }

    QLocale curlocale(QLocale("pt_BR"));
    QLocale::setDefault(curlocale);

    Server = new TCPServer(this);
    Server->StartServer();
    Server->ClientConnect();

    //Abre a porta serial para comunicação com o Scanner
    PortaSerial = new serial(this);
    PortaSerial->openSerialPort();

    QObject::connect(PortaSerial,SIGNAL(setScanBarcode(QString)),this,SLOT(setScanBarcode(QString)), Qt::DirectConnection);
    QObject::connect(PortaSerial,SIGNAL(setUpdatedImage(QString)),this,SLOT(setUpdatedImage(QString)), Qt::DirectConnection);

    DB = new dbmanager("/opt/opuspac/bin/banco.db");

    QVector<dbmanager::fields_s> NovaTabela;
    NovaTabela.append(dbmanager::fields_s{"PRODUTO",dbmanager::VARCHAR});
    NovaTabela.append(dbmanager::fields_s{"CODIGO",dbmanager::VARCHAR});

    DB->createTable("PRODUTO",NovaTabela);

    NovaTabela.clear();
    NovaTabela.append(dbmanager::fields_s{"TIMESTAMP",dbmanager::TIMESTAMP});
    NovaTabela.append(dbmanager::fields_s{"CODIGO",dbmanager::VARCHAR});

    DB->createTable("LEITURA",NovaTabela);

//    QDateTime timestamp;
//    DB->newCodeRegister("LEITURA",timestamp.toTime_t(),"123456");
//    DB->newProduct("PRODUTO","PRODUTO_TESTE","987654321");


    if (this->connectMB("10.20.30.50", "502"))
    {
        // Inicia Timer que irá realizar ler periodicamente o endereço 0
        this->startContador();

        //Inicia o Timer que monitora a conexão
        connection_timer->start();

        this->sendTable();
    }
    else {
#ifdef QT_DEBUG
        qDebug() << "Falha ao conectar/inicializar conexão ModBus" << endl;
#endif
        return;
    }

}

QString Task::getPrinterParam(QString param)
{
    QString codigo, produto;
    produto =  Server->ClientGetPrinterParam(param);
    codigo = DB->getProductFromCode("PRODUTO",produto);
    m_printerCode = codigo;
    return codigo;
}

QString Task::scanBarcode() const
{
    return m_scanBarcode;
}

void Task::setScanBarcode(QString barcode)
{
    QDateTime timestamp;
    DB->newCodeRegister("LEITURA",timestamp.toTime_t(),barcode);
    m_scanBarcode = barcode;
    //PortaSerial->writeCommand();
    this->checkCodes();
    emit scanBarcodeChanged();
}

QString Task::updatedImage() const
{
    return m_updatedImage;
}

void Task::setUpdatedImage(QString image)
{
    emit imageChanged();
}

void Task::readCode(QString ciclo)
{
    static QString code = "";
    //Se mudou o ciclo solicita uma leitura e compara
    if(code == "0" && ciclo == "10"){
        PortaSerial->writeSimpleRead();
    }
    code = ciclo;
}

void Task::checkCodes()
{
    QString printerCode = this->getPrinterParam("NOME");
    //Compara o código do scan com o da impressora e emite um sinal no Modbus
    if(this->ValidateScan(m_scanBarcode.trimmed(),printerCode.trimmed())){
        this->enableDevice(37,3,true);
    }else{
    //Se for diferente, emite o alerta
        this->enableDevice(37,3,false);
    }
}

bool Task::ValidateScan(const QString& ScanCode,const QString& PrinterCode)
{
    bool sucess = false;

    if(ScanCode == PrinterCode){
#ifdef QT_DEBUG
        qDebug() << "Codigos conferem!" << endl;
#endif
        //Envia o sinal Modbus informando que os código conferem
        //writeParamt();
        sucess = true;
    }else {
#ifdef QT_DEBUG
        qDebug() << "Codigos nao conferem!" << endl;
#endif
        //Envia o sinal Modbus informando que os código não conferem
        //writeParamt();
        sucess = false;
    }

    return sucess;
}

/**
 * @brief Task::~Task
 */
Task::~Task()
{
#ifdef QT_DEBUG
    qDebug() << "Task Desconstructor" << endl;
#endif
}

/**
 * @brief Task::getAlarms
 * @details Return model data with values of the alarms
 * @return
 */
QQmlListProperty<QObject> Task::getAlarms()
{
    return QQmlListProperty<QObject>(this, *listAlarms);
}


/**
 * @brief Task::sendMB
 * @param addr
 */
void Task::sendMB(const int addr)
{
#ifdef QT_DEBUG
    qDebug() << "TASK -> [OpusModBus] sendMB" << endl;
#endif
    m_modbus->sendValues(addr);
    //m_modbus->writeValue(addr);
}
/**
 * @brief Task::writeMB
 * @param addr
 * @param startAddr
 * @param numValues
 * @param value
 */
void Task::writeMB(const int startAddr, const QVariant value)
{
#ifdef QT_DEBUG
    qDebug() << "TASK -> [OpusModBus] writeMB" << endl;
#endif
    //m_modbus->writeValue(addr, startAddr, numValues, value);
    m_modbus->writeValue((quint16)(startAddr),(quint16)(value.toInt()));
}

/**
 * @brief Task::readMB
 * @param addr
 */
void Task::readMB(const int addr)
{
#ifdef QT_DEBUG
    qDebug() << "TASK -> [OpusModBus] readMB" << endl;
#endif
    m_modbus->readValue(addr);
}

/**
 * @brief Task::readMB
 * @param addr
 * @param startAddr
 * @param numValues
 */
void Task::readMB(const int addr, const int startAddr, const int numValues)
{
#ifdef QT_DEBUG
    qDebug() << "TASK -> [OpusModBus] readMB" << endl;

    //qDebug() << "Server Address   : " << addr << endl;
    //qDebug() << "Start Address    : " << startAddr << endl;
    //qDebug() << "Num Values       : " << numValues << endl;
#endif

    m_modbus->readValue(addr, startAddr, numValues);
}

/**
 * @brief Task::connectMB
 * @details Funcao primaria para se conectar e inicializar o ModBus
 * @param ip
 * @param port
 * @return
 */
bool Task::connectMB(const QString ip, const QString port)
{
    bool statusConModBus;
#ifdef QT_DEBUG
    qDebug() << "TASK -> [OpusModBus] connectMB" << endl;
#endif

    m_modbus->setIP(ip);
    m_modbus->setPort(port);

    m_modbus->initModBus();

    statusConModBus = m_modbus->connectModBus();

    return statusConModBus;
}

/**
 * @brief Task::startContador
 * @details Funcao que pode ser invocada do QML para iniciar o QTimer
 * que realizar periodicamente solicitação do StartAddress0
 */
void Task::startContador()
{
    if(!writeRun){
        m_timer->start();
    }

}

/**
 * @brief Task::resetPorta
 */
void Task::resetPorta()
{
#ifdef QT_DEBUG
    qDebug() << "TASK -> [OpusModBus] resetPorta" << endl;
#endif
    this->writeMB(4, 1);
}

/**
 * @brief Task::writeInt
 * @param value
 */
void Task::writeInt(quint16 value)
{
#ifdef QT_DEBUG
    qDebug() << "TASK -> [OpusModBus] writeInt(" << value <<")" << endl;
#endif
    this->writeMB(2, value);
}

void Task::writeParamt(const int numA, quint16 value)
{
    writeRun = true;
#ifdef QT_DEBUG
    qDebug() << "TASK -> [OpusModBus] escrevendo Parametro(" << value <<")" << endl;
#endif
    this->writeMB(numA, value);

    this->saveTable(numA,value);

    writeRun = false;
}

void Task::saveParams(void)
{
    m_modbus->saveToFile("modbus_save.csv");
}

void Task::restoreParams(void)
{
    if(QFile::remove("modbus.csv"))
    {
        QFile::copy(QDir::homePath() + "/" + "modbus_save.csv",QDir::homePath() + "/" + "modbus.csv");
        this->sendTable();
        qDebug() << "Parametros restaurados" << endl;
    }
    else
    {
        qDebug() << "Falha ao restaurar" << endl;
    }

}

void Task::updateSoftware(void)
{
    QProcess* usbProcess = new QProcess();
    usbProcess->start("blkid");
    usbProcess->waitForFinished();

    QString output(usbProcess->readAllStandardOutput());

    int start = output.indexOf("/dev/sd",0,Qt::CaseSensitive);

    QString usbPath = output.mid(start, 9);

    QProcess* process = new QProcess();
    process->start("mount "+ usbPath +" /mnt/");
    process->waitForFinished();

    QProcess::ExitStatus Status = process->exitStatus();
    if(Status == 0)
    {
        qDebug() << "Usb Inserted!" << endl;

        QFileInfo check_file("/mnt/UPDATE/ihm");

        if(check_file.exists() && check_file.isFile())
        {
            QFile::remove("/opt/opuspac/bin/ihm");
            QFile::copy("/mnt/UPDATE/ihm","/opt/opuspac/bin/ihm");
        }

        QProcess* umount = new QProcess();
        umount->start("umount /mnt");
        umount->waitForFinished();

        QProcess* reboot = new QProcess();
        reboot->start("reboot");

    }

}

void Task::loadVideos(void)
{
    QProcess* usbProcess = new QProcess();
    usbProcess->start("blkid");
    usbProcess->waitForFinished();

    QString output(usbProcess->readAllStandardOutput());

    int start = output.indexOf("/dev/sd",0,Qt::CaseSensitive);

    QString usbPath = output.mid(start, 9);

    QProcess* process = new QProcess();
    process->start("mount "+ usbPath +" /mnt/");
    process->waitForFinished();

    QProcess::ExitStatus Status = process->exitStatus();
    if(Status == 0)
    {
#ifdef QT_DEBUG
        qDebug() << "Usb Inserted!" << endl;
#endif

        QDir usb_dir("/mnt/VIDEOS");
        QDir video_dir("/opt/opuspac/");

        if(!video_dir.exists("videos"))
            video_dir.mkdir("videos");

        QDir local_dir("/opt/opuspac/videos");

        QStringList videos = usb_dir.entryList(QStringList() << "*.avi" << "*.AVI" << "*.mp4" << "*.MP4", QDir::Files);

        foreach (QString arquivo, videos) {
            QFileInfo check_file(local_dir.absolutePath() + "/" + arquivo);
            //Se o arquivo já existe localmente, então substitui
            if(check_file.exists() && check_file.isFile())
            {
                QFile::remove(local_dir.absolutePath() + "/" + arquivo);
                QFile::copy(usb_dir.absolutePath() + "/" + arquivo,local_dir.absolutePath() + "/" + arquivo);
            }
            //Caso contrário simplesmente copia
            else
            {
                QFile::copy(usb_dir.absolutePath() + "/" + arquivo,local_dir.absolutePath() + "/" + arquivo);
            }
        }

        QProcess* umount = new QProcess();
        umount->start("umount /mnt");
        umount->waitForFinished();
    }
}

void Task::importCSV(void)
{
    QProcess* usbProcess = new QProcess();
    usbProcess->start("blkid");
    usbProcess->waitForFinished();

    QString output(usbProcess->readAllStandardOutput());

    int start = output.indexOf("/dev/sd",0,Qt::CaseSensitive);

    QString usbPath = output.mid(start, 9);

    QProcess* process = new QProcess();
    process->start("mount "+ usbPath +" /mnt/");
    process->waitForFinished();

    QProcess::ExitStatus Status = process->exitStatus();
    if(Status == 0)
    {
        qDebug() << "Usb Inserted!" << endl;

        QFileInfo check_file("/mnt/PRODUTOS/import.csv");

        if(check_file.exists() && check_file.isFile()){
            QFile file("/mnt/PRODUTOS/import.csv");
            if(!file.open(QIODevice::ReadOnly)){
                qDebug() << "Nao foi possivel abrir o arquivo";
            }
            else{
                DB->removeAllProducts("PRODUTO");
                while(!file.atEnd()){
                    QByteArray line = file.readLine();
                    QString produto = line.split(',')[0];
                    QString codigo = line.split(',')[1];
                    DB->newProduct("PRODUTO",produto,codigo);
                }
            }
        }
        else{
            qDebug() << "Arquivo csv nao encontrado" << endl;
        }
        QProcess* umount = new QProcess();
        umount->start("umount /mnt");
        umount->waitForFinished();
    }

}

void Task::sendTable(void)
{
    QFile arquivo;
    QVector<QString> TabelaCSV;
    QString linha;

    arquivo.setFileName(QDir::homePath() + "/" + "modbus.csv");

    //Abro o arquivo
    if(arquivo.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QTextStream in(&arquivo);
        QStringList lista;
        while (!in.atEnd()) {
            linha = in.readLine();
            lista = linha.split(",");
            m_modbus->writeValue((quint16)(lista[0].toInt()),(quint16)(lista[1].toInt()));
        }
    }
}

void Task::saveTable(const int addr, const quint16 value)
{
    QFile arquivo;
    QVector<QString> TabelaCSV;
    QStringList Lista;
    QString reg;
    bool find = false;

    arquivo.setFileName(QDir::homePath() + "/" + "modbus.csv");

    //Abro o arquivo
    if(arquivo.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QTextStream in(&arquivo);
        //Salvo todos as linhas do arquivo em um vetor de strings
        while (!in.atEnd()) {
            TabelaCSV.append(in.readLine());
        }

        //Busco pela ocorrência do endereço nos registros da tabela
        for(int i = 0;i < TabelaCSV.size();i++)
        {
            //Pega somente o endereço da string completa
            Lista = TabelaCSV[i].split(",");
            reg = Lista[0];

            //Caso encontre, substitui o valor do endereço pelo novo valor
            if(reg == QString::number(addr))
            {
                TabelaCSV.replace(i,QString::number(addr) + "," + QString::number(value));
                find = true;
                break;
            }
        }
    }

    //Se não encontrou o registro, adiciona um novo
    if(find == false)
    {
        TabelaCSV.append(QString::number(addr) + "," + QString::number(value));
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

void Task::enableDevice(const int reg,const int bit,const bool value)
{
    int valor = 0;
#ifdef QT_DEBUG
    qDebug() << "TASK -> [OpusModBus] Habilitando e desabilita device (" << valor <<")" << endl;
#endif
    //Tenta encontrar o valor atual do registro na tabela local
    //Se não encontrar retonará zero
    valor = m_modbus->seekValue(reg);

    //Se o valor for true, seta o bit relativo a posição do item
    if(value)
        valor |= (1 << bit);
    //Caso contrário reseta o bit
    else
        valor &=~(1 << bit);

    this->writeMB(reg, valor);
}

/**
 * @brief Task::setPorta
 */
void Task::setPorta()
{
#ifdef QT_DEBUG
    qDebug() << "TASK -> [OpusModBus] setPorta" << endl;
#endif
    this->writeMB(4, 0x1);
}


/**
 * @brief Task::setLocalDateTime
 */
void Task::setLocalDateTime(QString localDateTime)
{
    Task::LocalDateTime = localDateTime;
}

/**
 * @brief Task::getLocalDateTime
 */
QString Task::getLocalDateTime(void)
{
    return Task::LocalDateTime;
}

/**
 * @brief Task::connTimeout
 * @details Slot chamado pelo QTimer ao disparar o sinal de conn_timeout()
 */
void Task::connTimeout()
{
    static int count = 0;
#ifdef QT_DEBUG
    qDebug() << "Modbus Connecion Monitor" << endl;
#endif
    if(!m_modbus->isConnected())
    {
        count++;
#ifdef QT_DEBUG
        qDebug() << "Modbus is not connected - Reconnection retry: " << count << endl;
#endif
        m_modbus->connectModBus();
        emit conexao("Desconectado");
    }
    else
    {
        count = 0;
        emit conexao("Conectado");
#ifdef QT_DEBUG
        qDebug() << "Modbus is connected" << endl;
#endif
    }

    QString subString = "";
#if defined(__arm__) || defined(__TARGET_ARCH_ARM) || defined(_M_ARM) || defined(__aarch64__)
    QString program = "/usr/bin/vcgencmd";
    QStringList arguments;
    arguments << "measure_temp";

    QProcess *myProcess = new QProcess();
    myProcess->start(program, arguments);
    myProcess->waitForFinished(1000);

    QString result = myProcess->readAllStandardOutput();
    subString = result.mid(5,4);
#elif defined(__x86_64) || defined(__x86_64__) || defined(__amd64) || defined(_M_X64)
    subString.append("0");
#endif

    subString.append(" C");

    emit readyTemp(subString);


}

/**
 * @brief Task::procTimeout
 * @details Slot chamado pelo QTimer ao disparar o sinal de timeout()
 */
void Task::procTimeout()
{
#ifdef QT_DEBUG
    qDebug() << "[C++] Timer timeout" << endl;
#endif
    //Read all address at once
    this->readMB(OpusModBus::serverAddr,0,125);

    this->sendMB(OpusModBus::serverAddr);

}

void Task::connectImpressora(){


    if(!impressoraRq){

        //Cria o servidor que irá comunicar com o Software Opus


        qDebug() << "Conectar Impressora" << endl;

        impressoraRq = true;

    }

    //emit conexao("Teste");

}

void Task::alarmResetView()
{
     if(auxTelaAlarme && !alarmAtive){ auxTelaAlarme = false; }
}

/**
 * @brief Task::procAlarms
 * @details Function process all sinals generate in alarmes any Class OpusModBus
 * @param alarm
 */
void Task::procAlarms(const QString alarm)
{
    QString msgAlarm("");
#ifdef QT_DEBUG
    qDebug() << "TASK -> [procAlarms] : " << alarm << endl;
#endif

    if(!alarmAtive && !auxTelaAlarme){

       emit readyAlarm(alarm);

       // Emite o alarme que o modelAlarm foi modificado, ainda não utilizado, mas mecanismo esta pronto
       emit alarmChanged();


    }

    // Se for Alarme 00 não tem nenhum alarm, retorna!
    if (alarm.contains("00")) { alarmAtive = false; return; }

    if      (alarm.contains("01")) { msgAlarm = "Falha na leitura da fotocélula"; }
    else if (alarm.contains("02")) { msgAlarm = "Alarme reserva"; }
    else if (alarm.contains("03")) { msgAlarm = "Final da quantidade setada"; }
    else if (alarm.contains("04")) { msgAlarm = "Presença de produto na selagem"; }
    else if (alarm.contains("05")) { msgAlarm = "Falha no movimento de home"; }
    else if (alarm.contains("06")) { msgAlarm = "Falha no conjunto de corte"; }
    else if (alarm.contains("07")) { msgAlarm = "Porta de proteção aberta"; }
    else if (alarm.contains("08")) { msgAlarm = "Botão de emergência acionado"; }
    else if (alarm.contains("09")) { msgAlarm = "Falha no sensor de fim de selagem"; }
    else if (alarm.contains("10")) { msgAlarm = "Sensor externo de segurança produto desativado"; }
    else if (alarm.contains("11")) { msgAlarm = "Falha na impressora"; }
    else if (alarm.contains("12")) { msgAlarm = "Falha de temperatura"; }
    else if (alarm.contains("13")) { msgAlarm = "Objeto na Cortina de luz"; }
    else if (alarm.contains("14")) { msgAlarm = "Sensor direito de segurança produto desativado"; }
    else if (alarm.contains("15")) { msgAlarm = "Portinhola"; }

    // Emite o alarme para o QML notificar via Popup(
    if(!alarmAtive && !auxTelaAlarme){
        listAlarms->insert(0,new AlarmObject(0,this->LocalDateTime,msgAlarm));
        alarmAtive = true;
        auxTelaAlarme= true;
        m_timerAlarm->start();
    }

}

void Task::sendSerialCmd(void)
{
    PortaSerial->writeCommand();
}



