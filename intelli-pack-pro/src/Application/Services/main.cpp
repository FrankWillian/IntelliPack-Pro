#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlComponent>
#include <QQmlContext>      //rootContext()->SetContextProperty()
#include <QQmlEngine>       //qmlRegisterType
#include "task.h"
#include "simpleserver.h"
#include "tcpserver.h"
#include "serial.h"

int main(int argc, char *argv[])
{

    qputenv("QT_QPA_PLATFORM_PLUGIN_PATH", QByteArray("/usr/lib/qt5/plugins/platforms"));
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    // Tem que criar um QList<QObject> antes de criar a classe Task
    QList<QObject*> alarmList;

    // Criando objeto da classe Task, uma unica instancia!
    Task taskObj;
    // Passo o endereço do QList<QObject> criado neste momento
    // dentro da classe é só trabalhar com listAlarms->append()
    taskObj.setListInstance(&alarmList);
    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("Task", &taskObj);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
