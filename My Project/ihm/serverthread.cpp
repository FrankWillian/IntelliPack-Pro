#include "serverthread.h"
#include <QObject>
#include <QThread>
#include <QDebug>

ServerThread::ServerThread(int ID, QObject *parent) : QThread(parent)
{
    this->socketDescriptor = ID;
}

void ServerThread::run()
{
#ifdef QT_DEBUG
    qDebug() << socketDescriptor << " - Iniciando a Thread";
#endif
    socket = new QTcpSocket();    
    if(!socket->setSocketDescriptor(this->socketDescriptor))
    {
        emit error(socket->error());
        return;
    }

    connect(socket,SIGNAL(readyRead()),this,SLOT(readyRead()),Qt::DirectConnection);
    connect(socket,SIGNAL(disconnected()),this,SLOT(disconnect()),Qt::DirectConnection);

#ifdef QT_DEBUG
    qDebug() << socketDescriptor << " - Cliente desconectado";
#endif

    //Cria um loop infinito
    exec();
}

void ServerThread::readyRead()
{
    QByteArray Data = socket->readAll();

#ifdef QT_DEBUG
    qDebug() << socketDescriptor << " - Data in: " << Data;
#endif

    socket->write(Data);
}

void ServerThread::disconnect()
{
#ifdef QT_DEBUG
    qDebug() << socketDescriptor << " - Disconectado";
#endif

    //Sai da Thread e destrui
    socket->deleteLater();
    exit(0);
}

