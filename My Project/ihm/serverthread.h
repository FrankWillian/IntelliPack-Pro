#ifndef SERVERTHREAD_H
#define SERVERTHREAD_H

#include <QObject>
#include <QThread>
#include <QTcpSocket>
#include <QDebug>


class ServerThread : public QThread
{
    Q_OBJECT
public:
    explicit ServerThread(int ID, QObject *parent = 0);
    void run();    
signals:
    void error(QTcpSocket::SocketError socketerror);
public slots:
    void readyRead();
    void disconnect();

public slots:

private:
    QTcpSocket *socket;    
    qintptr socketDescriptor;

};

#endif // SERVERTHREAD_H
