#ifndef SERIAL_H
#define SERIAL_H

#include <QObject>
#include <QSerialPort>
#include <QTimer>

class serial : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString serialString READ getSerialData NOTIFY newSerialData)

public:
    explicit serial(QObject *parent = 0);

signals:
    void newSerialData(int i);
    void setScanBarcode(QString barcode);
    void setUpdatedImage(QString image);

public:
    QString getSerialData();
    void writeCommand();
    void writeSimpleRead();

public slots:
    void openSerialPort();
    void closeSerialPort();
    void writeData(const QByteArray &data);
    void readData();
    void clearChange();

private:
    QSerialPort *serialPort;
    QTimer *serialTimer;
    bool hasChange;
    QString SerialData;
    QByteArray buffer;



};

#endif // SERIAL_H
