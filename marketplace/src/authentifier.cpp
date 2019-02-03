#include "authentifier.h"
#include <QCryptographicHash>
#include <QByteArray>
#include <QObject>

namespace mp {
Authentifier::Authentifier()
    : _uid()
    , _username()
    , _password()
{
}

Authentifier::~Authentifier()
{
}

bool Authentifier::exists(const std::string& name)
{
    ifstream f(name.c_str());
    return f.good();
}

bool Authentifier::automatic_login()
{
    // case 1. check if data exist on device

    string username;
    string password;

    string line;
    ifstream file("login.data");
    if (file.is_open()) {
        while (getline(file, line)) {
            username = line;
            getline(file, line);
            password = line;
        }
        file.close();
    }

    if (login(username, password)) {
        cout << "Welcome back " << username << " !" << endl;
        return true;
    }
    return false;
}

QString Authentifier::encryptString(const string& str)
{
    QCryptographicHash hashObj(QCryptographicHash::Algorithm::Keccak_512);
    QByteArray arr;
    arr.append(QString::fromStdString(str));
    QByteArray result = hashObj.hash(arr, QCryptographicHash::Algorithm::Keccak_512).toHex();
    QString  cryptedPass(result);
    return cryptedPass;
}

bool Authentifier::manual_login(const string& username, const string& password)
{
    QString cryptedPass = encryptString(password);

    if (login(username, cryptedPass.toStdString())) {
        cout << "Welcome " << username << " !" << endl;

        _username = username;
        _password = password;
        _uid      = username + password; // encrypt with better algo

        if (!exists("login.data")) {
            ofstream file1("login.data", ofstream::app);
            if (file1.is_open()) {
                file1 << username << "\n";
                file1 << cryptedPass.toStdString();
            }
            file1.close();
        }
        return true;
    }
    return false;
}

bool Authentifier::register_user(const string& username, const string& password)
{
    ifstream filc("known.data");
    string line;
    if (filc.is_open()) {
        while (getline(filc, line)) {
            string tusername;
            tusername = line;
            getline(filc, line);

            if (username == tusername) {
                cout << "user exists !" << endl;
                filc.close();
                return false;
            }
        }
        filc.close();
    }

    ofstream file("known.data", ofstream::app);
    if (file.is_open()) {
        file << username << "\n";
        QString cryptedPass = encryptString(password);
        file << cryptedPass.toStdString() << "\n";
    }
    file.close();

    return true;
}

bool Authentifier::login(const string& username, const string& password)
{
    ifstream file("known.data");

    string line;
    if (file.is_open()) {
        while (getline(file, line)) {
            string tusername = line;
            getline(file, line);
            string tpassword = line;

            if (username == tusername && password == tpassword) {
                return true;
            }
        }
    }
    return false;
}

bool Authentifier::logout()
{
    return remove("login.data") != 0 ? false : true;
}

void Authentifier::printInfos()
{
    cout << "_uid      : " << _uid      << endl;
    cout << "_username : " << _username << endl;
    cout << "_password : " << _password << endl;
}
}
