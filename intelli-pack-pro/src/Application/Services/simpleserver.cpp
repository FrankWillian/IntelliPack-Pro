#include "simpleserver.h"


SimpleServer::SimpleServer(QObject *parent) : QObject(parent)
{
    server = new QTcpServer(this);

    if(!server->listen(QHostAddress::Any,21000))
    {
#ifdef QT_DEBUG
        qDebug() << "Servidor nao foi iniciado";
#endif
        return;
    }
    else
    {
#ifdef QT_DEBUG
        qDebug() << "Servidor iniciado";
#endif
    }

    connect(server,SIGNAL(newConnection()),this,SLOT(newConnection()));
}

void SimpleServer::newConnection()
{

    QTcpSocket *socket = server->nextPendingConnection();
    QByteArray Data = socket->readAll();
    connect(socket,SIGNAL(disconnected()),socket,SLOT(deleteLater()));

    socket->write("Raspy \r\n");
    socket->flush();

    socket->waitForBytesWritten(3000);


    socket->disconnectFromHost();
    //socket->close();

}
