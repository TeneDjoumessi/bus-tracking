#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QtSql>
#include <QAbstractItemModel>

class Database : public QObject
{
    Q_OBJECT
public:
    explicit Database(QObject *parent = nullptr);

   Q_INVOKABLE void setIsAdmin(bool value); // Set admin status
   Q_INVOKABLE bool isAdmin() const; // Get admin status

    // New search methods
        Q_INVOKABLE QAbstractItemModel* searchDriver(const QString &searchTerm);
        Q_INVOKABLE QAbstractItemModel* searchBus(const QString &searchTerm);
        Q_INVOKABLE void searchStaff(const QString &searchTerm); // Add this line

    // Add the new method here
   Q_INVOKABLE QStringList getBusNames(); // Method to get bus names
    Q_INVOKABLE QStringList getBusMatricule(); // Method to get bus matricule
    Q_INVOKABLE QStringList getDriverId(); // Method to get driver IDs

//    Q_INVOKABLE QSqlTableModel* getDriverModel(); // New method
    Q_INVOKABLE QAbstractItemModel* getDriverModel(); // Change return type
    Q_INVOKABLE QAbstractItemModel* getStaffModel();
    Q_INVOKABLE QAbstractItemModel* getBusModel();
    Q_INVOKABLE QAbstractItemModel* getSetRouteModel();
    Q_INVOKABLE QAbstractItemModel* getLostObjectModel();

signals:
    void staffModelUpdated(QSqlQueryModel *model); // Signal to notify QML of model updates
public slots:

   Q_INVOKABLE int checkstaff(int phonenum, QString password);

    QString addStaff( QString fname, QString lname, QString imagePath ,QString address,int phonenum, QString email, int salary, QString date);
    QString addDriver(QString fname, QString lname, QString imagePath, QString address, int phonenum, QString email, int salary, QString date);
    QString addBus(int id, QString busname, QString buscolor, int buscapacity, QString busmatricule, QString fueltype);
    QString addRoute(QString source, QString destination, QString stopname, QString stoplong, QString stoplat, int bus_id);
    QString addLostObject(QString imagePath, QString matricule, QString postdate, QString description);

    void updateStaff(int id, QString fname, QString lname, QString address, int phonenum, QString email, int salary, QString date, int role, int status);
    void updateDrivers(int id, QString fname, QString lname, QString address, int phonenum, QString email, int salary, QString date, int status);
    void updateBus(int bus_id, QString busname, QString buscolor, int buscapacity, QString busmatricule, QString fueltype);
    void updateRoute(int id, QString source, QString destination, QString stopname, QString stoplong, QString stoplat, int bus_id);
    void updateLostObject(int id, QString image, QString matricule, QString postdate, QString description);

    void deleteStaff(int id);
    void deleteDrivers(int id);
    void deleteBus(int bus_id);
    void deleteRoute(int id);
    void deleteLostObject(int id);
private:
     QSqlDatabase db;
     bool adminStatus; // Variable to store admin status

      void createTableDriver();
       void createTableBus();
        void createTableStaff();
         void createTableRoutes();
          void createTableLostObjects();


};

#endif // DATABASE_H
