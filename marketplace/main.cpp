#include <bits/stdc++.h>
#include "authentificator.h"
#include "databridge.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>

using namespace std;

int main(int argc, char** argv) {

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    int choice;
    mp::Authentificator auth;
    mp::DataBridge net;

    if (auth.automatic_login()) {
        cout << "Main page !" << endl;
    } else {
        /*
        while (choice != 4) {
            cout << "1. manual login" << endl;
            cout << "2. register"     << endl;
            cout << "3. logout"       << endl;
            cout << "4. exit"         << endl;

            cin  >> choice;
            bool result = false;

            switch (choice) {
            case 1:
                result = auth.manual_login();
                break;
            case 2:
                auth.register_user();
                break;
            case 3:
                auth.logout();
                break;
            default:
                break;
            }

            if (result == true) {
                cout << "Main page !" << endl;
                break;
            }
        }
        */
    }

    return app.exec();
}
