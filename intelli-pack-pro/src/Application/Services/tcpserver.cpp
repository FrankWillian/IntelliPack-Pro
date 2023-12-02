#include "tcpserver.h"
#include <QObject>
#include <QTcpServer>
#include <QDebug>
#include <QTextCodec>
#include "serverthread.h"

TCPServer::TCPServer(QObject *parent) : QTcpServer(parent)
{
    clientSocket = new QTcpSocket(this);
}

void TCPServer::StartServer()
{
    if(!this->listen(QHostAddress::Any,21000))
    {
#ifdef QT_DEBUG
        qDebug() << "Nao foi possivel iniciar o servidor" << endl;
#endif
    }
    else
    {
#ifdef QT_DEBUG
        qDebug() << "Servidor iniciado" << endl;
#endif
    }
}

void TCPServer::incomingConnection(qintptr socketDescriptor)
{
#ifdef QT_DEBUG
    qDebug() << socketDescriptor << "Conectando...";
#endif
    ServerThread *thread = new ServerThread(socketDescriptor,this);

    connect(thread,SIGNAL(finished()),thread,SLOT(deleteLater()));
    thread->start();
}

void TCPServer::ClientConnect()
{    
    clientSocket->connectToHost("10.20.30.4",21000);
    if(clientSocket->waitForConnected(3000))
    {
#ifdef QT_DEBUG
        qDebug() << "Cliente conectado!";
#endif
        //ClientGetPrinterParam("CODIGO");
    }
    else
    {
#ifdef QT_DEBUG
        qDebug() << "Cliente não conectado!";
#endif
        clientSocket->close();
    }
}

void TCPServer::ClientDisconnect()
{
    if(clientSocket->isOpen()){
#ifdef QT_DEBUG
        qDebug() << "Desconectando o cliente!";
#endif
        clientSocket->disconnect();
        clientSocket->close();
    }
}

QString TCPServer::ClientGetPrinterParam(QString param)
{
    QByteArray dataIn;
    QString ret;
    if(clientSocket->isOpen())
    {
        //QByteArray data = QByteArrayLiteral("\x02~FR|" + param + "|\x03");
        QByteArray data = QByteArrayLiteral("\x02~FR|");
        data.append(param);
        data.append(QByteArrayLiteral("|\x03"));
        clientSocket->write(data);
        clientSocket->waitForBytesWritten(100);
        clientSocket->waitForReadyRead(1000);
#ifdef QT_DEBUG
        qDebug() << "Lendo da impressora: " << clientSocket->bytesAvailable();        

#endif
        dataIn = clientSocket->readAll();
#ifdef QT_DEBUG
        qDebug() << dataIn;
#endif
        QByteArray subStr = dataIn.mid(7 + param.length(),dataIn.length() - 9 - param.length());

        ret = QTextCodec::codecForMib(106)->toUnicode(subStr);

        return ret;

    }

    return "";
}
