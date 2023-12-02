#include "serial.h"
#include <QDebug>
#include <QTextCodec>
#include <QPixmap>
#include <QFile>
#include <QImage>

serial::serial(QObject *parent) : QObject(parent)
{
    serialPort = new QSerialPort(this);
    connect(serialPort, SIGNAL(readyRead()), this, SLOT(readData()));

    hasChange = false;
    serialTimer = new QTimer(this);
    serialTimer->start(100);
    connect(serialTimer,SIGNAL(timeout()),this,SLOT(clearChange()));
}

void serial::openSerialPort()
{
    serialPort->setPortName("/dev/ttyACM0");
    serialPort->setBaudRate(QSerialPort::Baud115200);
    serialPort->setDataBits(QSerialPort::Data8);
    serialPort->setParity(QSerialPort::NoParity);
    serialPort->setStopBits(QSerialPort::OneStop);
    serialPort->setReadBufferSize(0);
    if(serialPort->open(QIODevice::ReadWrite))
    {
#ifdef QT_DEBUG
        qDebug() << "Porta Serial aberta com sucesso!";
#endif
    }
    else
    {
#ifdef QT_DEBUG
        qDebug() << "Não foi possível abrir porta serial";
#endif
    }
}

void serial::closeSerialPort()
{
    if(serialPort->isOpen())
    {
#ifdef QT_DEBUG
        qDebug() << "Fechando porta serial";
#endif
        serialPort->close();
    }
}

void serial::writeData(const QByteArray &data)
{
    serialPort->write(data);
}

void serial::writeCommand()
{
    QByteArray data = QByteArrayLiteral("\026M\rIMGSNP1P0T150W1B;IMGSHP6F.");
    serialPort->write(data);
}

void serial::writeSimpleRead()
{
    QByteArray data = QByteArrayLiteral("\026T\r");
    serialPort->write(data);
}

QString serial::getSerialData()
{
    return SerialData;
}

void serial::readData()
{
    QByteArray cache = serialPort->readAll();
    buffer.append(cache);
    //SerialData = QTextCodec::codecForMib(1015)->toUnicode(data);
    hasChange = true;
}

void serial::clearChange()
{
    if(hasChange)
    {
        hasChange = false;
        emit newSerialData(0);
    }
    else
    {
        emit newSerialData(1);
        if(buffer.size() > 0)
        {
#ifdef QT_DEBUG
            qDebug() << "Buffer:" << buffer;
#endif
            //É uma imagem
            if(buffer.size() > 100)
            {
                buffer.remove(buffer.size() - 22,22);
                buffer.remove(0,36);
#ifdef QT_DEBUG
                qDebug() << "Buffer size:" << buffer.size();
#endif
                QFile file("Imagem.jpeg");
                file.open(QIODevice::WriteOnly);
                file.write(buffer);
                file.close();
                setUpdatedImage(file.fileName());
            }
            //É a leitura do código de barras
            else
            {
                QString str = QTextCodec::codecForMib(106)->toUnicode(buffer);
                setScanBarcode(str.trimmed());
            }
            buffer.clear();
        }
    }
}
