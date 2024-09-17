#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "database.h"
#include <QQmlContext>
#include <SqlQueryModel.h>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Database bd;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("db",&bd);
    qmlRegisterType<SqlQueryModel>("SQL", 1, 0, "SqlQueryModel");
    const QUrl url("qrc:/main.qml");
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl){
            QCoreApplication::exit(-1);
        }
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
