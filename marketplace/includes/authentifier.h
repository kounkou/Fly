#ifndef __AUTHENTIFIER_H__
#define __AUTHENTIFIER_H__

#include <bits/stdc++.h>

using namespace std;

namespace mp {
class Authentifier {
public:
    Authentifier();
    ~Authentifier();

    bool exists(const std::string& name);
    bool automatic_login();
    bool manual_login(const string &username, const string &password);
    bool register_user(const string& username, const string& password);
    bool login(const string& username, const string& password);
    bool logout();
    void printInfos();

private:
    string _uid;
    string _username;
    string _password; // encrypted
};
}

#endif
