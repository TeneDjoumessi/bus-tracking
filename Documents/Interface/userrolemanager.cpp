// UserRoleManager.h
#ifndef USERROLERMANAGER_H
#define USERROLERMANAGER_H

#include <QObject>
#include <QtQml/qqmlregistration.h>

class UserRoleManager : public QObject
{
    Q_OBJECT
    QML_NAMED_ELEMENT(UserRoleManager)

public:
    UserRoleManager(QObject* parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE int getUserRole(const QString& userName);
    Q_INVOKABLE void setUserRole(const QString& userName, int role);

private:
    QSqlDatabase getDatabaseConnection();
};

#endif // USERROLERMANAGER_H
