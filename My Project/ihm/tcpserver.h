#ifndef TCPSERVER_H
#define TCPSERVER_H

#include <QObject>
#include <QTcpServer>

class TCPServer : public QTcpServer
{
    Q_OBJECT
public:
    explicit TCPServer(QObject  *parent = 0);
    void StartServer();
    void ClientConnect();
    void ClientDisconnect();
    QString ClientGetPrinterParam(QString param);

protected:
    void incomingConnection(qintptr socketDescriptor);

private:
    QTcpSocket *clientSocket;
};

#endif // TCPSERVER_H
