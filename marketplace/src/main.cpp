#include <bits/stdc++.h>
#include "authentifier.h"
#include "databridge.h"
#include "guimanager.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>

using namespace std;

int main(int argc, char** argv)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    mp::GuiManager gui;
    gui.initInterface();

    return app.exec();
}
