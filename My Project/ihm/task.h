#ifndef TASK_H
#define TASK_H

#include <QObject>
#include <QQmlListProperty>
#include <QThread>
#include <QtConcurrent/QtConcurrentRun>
#include <QTimer>
#include <QDateTime>
#include "opusmodbus.h"
#include "serial.h"
#include "tcpserver.h"
#include "dbmanager.h"

class Task : public QObject
{
    Q_OBJECT
    //Q_DISABLE_COPY(Task)
    Q_PROPERTY(QString state READ state WRITE setState NOTIFY stateChanged)
    Q_PROPERTY(QQmlListProperty<QObject> modelAlarms READ getAlarms NOTIFY alarmChanged)
    Q_PROPERTY(QString scanBarcode READ scanBarcode WRITE setScanBarcode NOTIFY scanBarcodeChanged)
    Q_PROPERTY(QString updatedImage READ updatedImage WRITE setUpdatedImage NOTIFY imageChanged)


public:
    explicit Task(QObject *parent = nullptr);
    ~Task();

    void setListInstance(QList<QObject *> *alarmList){ listAlarms = alarmList; }
    QQmlListProperty<QObject> getAlarms();

    QString state() { return m_msgState; }
    void setState(const QString s) { m_msgState = s; emit stateChanged(); }

    Q_INVOKABLE void writeMB(const int startAddr, const QVariant value);
    void readMB(const int addr);
    Q_INVOKABLE void readMB(const int addr, const int startAddr, const int numValues);
    Q_INVOKABLE bool connectMB(const QString ip, const QString port);
    Q_INVOKABLE void startContador(void);
    Q_INVOKABLE void setPorta(void);
    Q_INVOKABLE void resetPorta(void);
    Q_INVOKABLE void writeInt(quint16 value);
    Q_INVOKABLE void enableDevice(const int reg,const int bit,const bool value);
    Q_INVOKABLE void writeParamt(const int numA, quint16 value);
    Q_INVOKABLE void saveParams(void);
    Q_INVOKABLE void restoreParams(void);
    Q_INVOKABLE void updateSoftware(void);
    Q_INVOKABLE void loadVideos(void);
    Q_INVOKABLE void importCSV(void);

    void sendMB(const int addr);
    void saveTable(const int addr, const quint16 value);
    void sendTable(void);

    bool ValidateScan(const QString& ScanCode,const QString& PrinterCode);

    QString getLocalDateTime(void);

    Q_INVOKABLE void sendSerialCmd(void);
    Q_INVOKABLE QString getPrinterParam(QString param);

    QString scanBarcode() const;

    QString updatedImage() const;

private:
    QString m_msgState;
    OpusModBus *m_modbus;
    bool writeRun = false;
    bool impressoraRq = false;
    bool alarmAtive = false;
    bool auxTelaAlarme = false;


    QList<QObject *> *listAlarms;

    QTimer *m_timer;
    QTimer *m_timerImpressora; //1
    QTimer *m_timerAlarm;
    QTimer *connection_timer;

    QString LocalDateTime;

    serial *PortaSerial;

    TCPServer *Server;
    dbmanager *DB;

    QString m_scanBarcode;
    QString m_printerCode;

    QString m_updatedImage;

    void checkCodes();


Q_SIGNALS:
    void alarmChanged();

    void stateChanged();
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
    void readyTemp(QString data); //Temperatura do Core

    void conexao(QString erro); // Conexão PLC

    void scanBarcodeChanged();

    void imageChanged();

public slots:

    void procTimeout(void);

    void connectImpressora(void);

    void connTimeout(void);

    void alarmResetView(void);

    void procAlarms(const QString);

    void setLocalDateTime(QString);

    void setScanBarcode(QString barcode);

    void setUpdatedImage(QString image);

    void readCode(QString ciclo);

};

#endif // TASK_H
