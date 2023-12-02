#ifndef SIMPLESERVER_H
#define SIMPLESERVER_H

#include <QObject>
#include <QDebug>
#include <QTcpServer>
#include <QTcpSocket>

class SimpleServer : public QObject
{
    Q_OBJECT
public:
    explicit SimpleServer(QObject *parent = 0);

signals:

public slots:
    void newConnection();

private:
    QTcpServer *server;
    QTcpSocket *socket;
};

#endif // SIMPLESERVER_H
