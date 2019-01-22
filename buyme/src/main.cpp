

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "buyme/includes/buyme.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    bm::BuyMe buyMe;
    buyMe.initInterface();

    return app.exec();
}
