#include "database.h"
#include <QSqlTableModel>
#include <QSqlQuery>
#include <QObject>
#include <QSqlError>
#include <QDebug>
#include <QSqlQueryModel>

Database::Database(QObject *parent) : QObject(parent), adminStatus(false) // Initialize adminStatus
{
         db = QSqlDatabase::addDatabase("QSQLITE");
         db.setHostName("acidalia");
         db.setDatabaseName("customdb");
         db.setUserName("mojito");
         db.setPassword("J0a1m8");
         bool ok = db.open();

         createTableStaff();
         createTableBus();
         createTableDriver();
         createTableRoutes();
         createTableLostObjects();

         /*
         updateBus();
         updateDrivers();
         updateStaff();
         updateRoute();
         updateLostObject();

         deleteBus();
         deleteDrivers();
         deleteStaff();
         deleteRoute();
         deleteLostObject();*/
//         addStaff("NOM", "prenom","image","Address", 642567324,"email",500000,"28 AOUT 2024");
//         addBus(2,"Toyota MV","Red",60,"CM3TY56","Super");
//         addRoute("Mvog-ada","Mvan","Efouland","la235N","la23465E",2);
//         addLostObject("image","1","28-10-02","i lost my bag its black");
//         addDriver("Tene","jack", "image", "Emana",671714340,"boubailaryou@gmail.com",10000,"29-09-2020");

}

void Database::setIsAdmin(bool value)
{
    adminStatus = value; // Set the admin status
}

bool Database::isAdmin() const
{
    return adminStatus; // Return the current admin status
}

QAbstractItemModel *Database::searchDriver(const QString &searchTerm)
{
    QSqlTableModel *model = new QSqlTableModel(this, db);
        model->setTable("driver");

        // Prepare the query to filter results based on the search term
        model->setFilter(QString("fname LIKE '%%1%' OR lname LIKE '%%1%'").arg(searchTerm));
        model->select();

        // Check if any results were found
        if (model->rowCount() == 0) {
            qDebug() << "No drivers found with the search term:" << searchTerm;
        }

        return model; // Return the filtered model
}

QAbstractItemModel *Database::searchBus(const QString &searchTerm)
{
    QSqlTableModel *model = new QSqlTableModel(this, db);
        model->setTable("bus");

        // Prepare the query to filter results based on the search term
        model->setFilter(QString("busname LIKE '%%1%' OR busmatricule LIKE '%%1%'").arg(searchTerm));
        model->select();

        // Check if any results were found
        if (model->rowCount() == 0) {
            qDebug() << "No buses found with the search term:" << searchTerm;
        }

        return model; // Return the filtered model
}

void Database::searchStaff(const QString &searchTerm)
{
    QSqlQueryModel *model = new QSqlQueryModel(this);
        QString queryString = "SELECT * FROM staff";

        if (!searchTerm.isEmpty()) {
            queryString += " WHERE fname LIKE '%" + searchTerm + "%' OR lname LIKE '%" + searchTerm + "%'";
        }

        model->setQuery(queryString);
        emit staffModelUpdated(model); // Emit signal to notify QML
}

QStringList Database::getBusNames()
{
    QStringList busNames;
        QSqlQuery query("SELECT busname FROM bus");

        while (query.next()) {
            busNames << query.value(0).toString();
        }

        return busNames;
}

QStringList Database::getBusMatricule()
{
    QStringList busMatricule;
        QSqlQuery query("SELECT busmatricule FROM bus");

        while (query.next()) {
            busMatricule << query.value(0).toString();
        }

        return busMatricule;
}

QStringList Database::getDriverId()
{
    QStringList driverIds; // Use a list to store multiple driver IDs
        QSqlQuery query("SELECT id FROM driver"); // Ensure this table name is correct

        if (!query.exec()) {
            qWarning() << "Database query failed:" << query.lastError().text(); // Log any errors
            return driverIds; // Return empty list if query fails
        }

        while (query.next()) {
            driverIds << QString::number(query.value(0).toInt()); // Append each ID to the list
        }

        return driverIds; // Return the list of driver IDs
}

QAbstractItemModel* Database::getDriverModel() {
    QSqlTableModel *model = new QSqlTableModel(this, db);
        model->setTable("driver");
        model->select(); // Load data from the driver table

        // Set the role names
        model->setHeaderData(0, Qt::Horizontal, "id");
        model->setHeaderData(1, Qt::Horizontal, "fname");
        model->setHeaderData(2, Qt::Horizontal, "lname");
        model->setHeaderData(3, Qt::Horizontal, "address");
        model->setHeaderData(4, Qt::Horizontal, "phonenum");
        model->setHeaderData(5, Qt::Horizontal, "email");
        model->setHeaderData(6, Qt::Horizontal, "date");
        model->setHeaderData(7, Qt::Horizontal, "status");

        return model; // Return as QAbstractItemModel*
}

QAbstractItemModel *Database::getStaffModel()
{

        QSqlTableModel *model = new QSqlTableModel(this, db);
            model->setTable("staff");
            model->select(); // Load data from the driver table

            // Ensure the model is populated
            if (model->rowCount() == 0) {
                qDebug() << "No data found in the driver table.";
            }
            for (int row = 0; row < model->rowCount(); ++row) {
                qDebug() << "Row" << row << ":"
                         << model->data(model->index(row, 0)).toString() // ID
                         << model->data(model->index(row, 1)).toString() // First Name
                         << model->data(model->index(row, 2)).toString(); // Last Name
            }

            return model; // Return as QAbstractItemModel*
}

QAbstractItemModel *Database::getBusModel()
{

}

QAbstractItemModel *Database::getSetRouteModel()
{

}

QAbstractItemModel *Database::getLostObjectModel()
{

}

int Database::checkstaff(int phonenum, QString password)
{
    QSqlQuery query;
    query.prepare("SELECT status, role, phonenum, password FROM staff WHERE phonenum = (:phonenum) AND password = (:password)");
    query.bindValue(":phonenum", phonenum);
    query.bindValue(":password", password);
    int status=0, role =0, code =0;
    if (query.exec())
    {
       if (query.next())
       {
          // it exists
            qDebug()<<"found user"
;           qDebug()<<query.value(0)<<query.value(1)<<query.value(2)<<query.value(3);
            status = query.value(0).toInt();
            role = query.value(1).toInt();

            // Set admin status based on role
             if (role == 1) // Assuming role 1 is admin
               setIsAdmin(true);
             else
               setIsAdmin(false);

       }
       else{
               qDebug()<<"not found user";
       }
    }
    if(status == 1)
    {
      code = 500;
    }
    else
    {
       code = 330;
    }
    return  code;
}

/*void Database::createTableUser()
{
    bool success = false;

       QSqlQuery query;
       query.prepare("CREATE TABLE people(id INTEGER PRIMARY KEY, name TEXT);");

       if (!query.exec())
       {
           qDebug() << "Couldn't create the table 'people': one might already exist.";
           success = false;
       }


}*/

void Database::createTableDriver()
{
    bool success = false;

       QSqlQuery query;
       query.prepare("CREATE TABLE IF NOT EXISTS driver(id INTEGER PRIMARY KEY AUTOINCREMENT, fname TEXT, lname TEXT, image TEXT, address TEXT, phonenum INTEGER, email TEXT, salary INTEGER, date DATE, role TEXT, status INTEGER);");

       if (!query.exec())
       {
           qDebug() << "Couldn't create the table 'driver': one might already exist.";
           success = false;
       }
}

void Database::createTableBus()
{
    bool success = false;

       QSqlQuery query;
       query.prepare("CREATE TABLE IF NOT EXISTS bus(bus_id INTEGER PRIMARY KEY, busname TEXT, buscolor TEXT, buscapacity INTEGER, busmatricule TEXT, fueltype TEXT, id INTEGER, FOREIGN KEY(bus_id) REFERENCES bus(bus_id));");

       if (!query.exec())
       {
           qDebug() << "Couldn't create the table 'bus': one might already exist.";
           success = false;
       }
}

void Database::createTableStaff()
{
    bool success = false;

       QSqlQuery query;
       query.prepare("CREATE TABLE IF NOT EXISTS staff(id INTEGER PRIMARY KEY AUTOINCREMENT, fname TEXT, lname TEXT, image TEXT, address TEXT, phonenum INTEGER, email TEXT, password TEXT, salary INTEGER, date DATE, role INTEGER, status INTEGER);");

       if (!query.exec())
       {
           qDebug() << "Couldn't create the table 'staff': one might already exist.";
           success = false;
       }
}

void Database::createTableRoutes()
{
    bool success = false;

       QSqlQuery query;
       query.prepare("CREATE TABLE IF NOT EXISTS route(id INTEGER PRIMARY KEY AUTOINCREMENT, source TEXT, destination TEXT, stopname TEXT, stoplong TEXT, stoplat TEXT,bus_id INTEGER, FOREIGN KEY(bus_id) REFERENCES bus(bus_id));");

       if (!query.exec())
       {
           qDebug() << "Couldn't create the table 'route': one might already exist.";
           success = false;
       }
}

void Database::createTableLostObjects()
{
    bool success = false;

       QSqlQuery query;
       query.prepare("CREATE TABLE IF NOT EXISTS lostobject(id INTEGER PRIMARY KEY AUTOINCREMENT, image TEXT, matricule TEXT, postdate DATETIME, description TEXT);");

       if (!query.exec())
       {
           qDebug() << "Couldn't create the table 'lostobject': one might already exist.";
           success = false;
       }
}

//add elements

QString Database::addStaff(QString fname, QString lname, QString imagePath ,QString address,int phonenum, QString email, int salary, QString date)
{
    QString response ="";
      // you should check if args are ok first...
    QString defaultPassword = "staFF123@";
        int role = 2; // Default role
        int status = 1; // Default status

      QSqlQuery query;
      query.prepare("INSERT INTO staff (fname,lname, image, address,phonenum,email,password,salary, date, role, status) "
                    "VALUES (:fname, :lname, :image, :address, :phonenum, :email, :password, :salary, :date, :role, :status)");
//          query.bindValue(":id", id);
          query.bindValue(":fname", fname);
          query.bindValue(":lname", lname);
          query.bindValue(":image", imagePath); // Bind the image path
          query.bindValue(":address", address);
          query.bindValue(":phonenum", phonenum);
          query.bindValue(":email", email);
          query.bindValue(":password", defaultPassword);
          query.bindValue(":salary", salary);
          query.bindValue(":date", date);
          query.bindValue(":role", role);
          query.bindValue(":status", status);
      if(query.exec())
      {
          response = "success";
      }
      else
      {
           qDebug() << "addStaff error:"
                    << query.lastError();
           response = "error";
      }

      return response;
}

QString Database::addDriver(QString fname, QString lname, QString imagePath , QString address, int phonenum, QString email, int salary, QString date)
{
    QString response ="";
      // you should check if args are ok first...

    int status = 1; // Default status
    QString role = "Driver";
      QSqlQuery query;
      query.prepare("INSERT INTO driver (fname,lname, image,address,phonenum,email,salary, date,role,status) "
                    "VALUES (:fname, :lname, :image, :address, :phonenum, :email, :salary, :date,:role, :status)");
//          query.bindValue(":id", id);
          query.bindValue(":fname", fname);
          query.bindValue(":lname", lname);
          query.bindValue(":image", imagePath); // Bind the image path
          query.bindValue(":address", address);
          query.bindValue(":phonenum", phonenum);
          query.bindValue(":email", email);
          query.bindValue(":salary", salary);
          query.bindValue(":date", date);
          query.bindValue(":status", status);
      if(query.exec())
      {
          response = "success";
      }
      else
      {
           qDebug() << "addDriver error:"
                    << query.lastError();
           response = "error";
      }

     return response;
}

QString Database::addBus(int id, QString busname, QString buscolor, int buscapacity, QString busmatricule, QString fueltype)
{
    QString response ="";
      // you should check if args are ok first...
      QSqlQuery query;
      query.prepare("INSERT INTO bus (id, busname, buscolor, buscapacity, busmatricule, fueltype) "
                    "VALUES (:id, :busname, :buscolor, :buscapacity, :busmatricule, :fueltype)");
          query.bindValue(":id", id);
          query.bindValue(":busname", busname);
          query.bindValue(":buscolor", buscolor);
          query.bindValue(":buscapacity", buscapacity);
          query.bindValue(":busmatricule", busmatricule);
          query.bindValue(":fueltype", fueltype);
      if(query.exec())
      {
          response = "success";
      }
      else
      {
           qDebug() << "addBus error:"
                    << query.lastError();
           response = "error";
      }

      return response;
}

QString Database::addRoute(QString source, QString destination, QString stopname, QString stoplong, QString stoplat, int bus_id)
{
    QString response ="";
      // you should check if args are ok first...
      QSqlQuery query;
      query.prepare("INSERT INTO route (source, destination, stopname, stoplong, stoplat, bus_id) "
                    "VALUES (:source, :destination, :stopname, :stoplong, :stoplat, :bus_id)");
//      query.bindValue(":id", id);
          query.bindValue(":source", source);
          query.bindValue(":destination", destination);
          query.bindValue(":stopname", stopname);
          query.bindValue(":stoplong", stoplong);
          query.bindValue(":stoplat", stoplat);
          query.bindValue(":bus_id", bus_id); // Foreign key
      if(query.exec())
      {
          response = "success";
      }
      else
      {
           qDebug() << "addRoute error:"
                    << query.lastError();
           response = "error";
      }

      return response;
}

QString Database::addLostObject(QString imagePath, QString matricule, QString postdate, QString description)
{
    QString response ="";
      // you should check if args are ok first...
      QSqlQuery query;
      query.prepare("INSERT INTO lostobject (image, matricule, postdate, description) "
                    "VALUES (:image, :matricule, :postdate, :description)");
//          query.bindValue(":id", id);
          query.bindValue(":image", imagePath);
          query.bindValue(":matricule", matricule);
          query.bindValue(":postdate", postdate);
          query.bindValue(":description", description);
      if(query.exec())
      {
          response = "success";
      }
      else
      {
           qDebug() << "addLostObject error:"
                    << query.lastError();
           response = "error";
      }

            return response;
}

//Update elements

void Database::updateStaff(int id, QString fname, QString lname, QString address, int phonenum, QString email, int salary, QString date, int role, int status)
{
    bool success = false;
    QSqlQuery query;
    query.prepare("UPDATE staff SET fname = :fname, lname = :lname, address = :address, phonenum = :phonenum, email = :email, salary = :salary, date = :date, role = :role, status = :status WHERE id = :id");

    query.bindValue(":id", id);
    query.bindValue(":fname", fname);
    query.bindValue(":lname", lname);
    query.bindValue(":address", address);
    query.bindValue(":phonenum", phonenum);
    query.bindValue(":email", email);
    query.bindValue(":salary", salary);
    query.bindValue(":date", date);
    query.bindValue(":role", role);
    query.bindValue(":status", status);

    if(query.exec())
    {
        success = true;
    }
    else
    {
         qDebug() << "updateStaff error:"
                  << query.lastError();
    }
}

void Database::updateDrivers(int id, QString fname, QString lname, QString address, int phonenum, QString email, int salary, QString date, int status)
{
    bool success = false;
    QSqlQuery query;
    query.prepare("UPDATE driver SET fname = :fname, lname = :lname, address = :address, phonenum = :phonenum, email = :email, salary = :salary, date = :date, status = :status WHERE id = :id");

    query.bindValue(":id", id);
    query.bindValue(":fname", fname);
    query.bindValue(":lname", lname);
    query.bindValue(":address", address);
    query.bindValue(":phonenum", phonenum);
    query.bindValue(":email", email);
    query.bindValue(":salary", salary);
    query.bindValue(":date", date);
    query.bindValue(":status", status);

    if(query.exec())
    {
        success = true;
    }
    else
    {
         qDebug() << "updateDriver error:"
                  << query.lastError();
    }
}

void Database::updateBus(int bus_id, QString busname, QString buscolor, int buscapacity, QString busmatricule, QString fueltype)
{
    bool success = false;
    QSqlQuery query;
    query.prepare("UPDATE bus SET busname = :busname, buscolor = :buscolor, buscapacity = :buscapacity, busmatricule = :busmatricule, fueltype = :fueltype WHERE bus_id = :bus_id");

    query.bindValue(":bus_id", bus_id);
    query.bindValue(":busname", busname);
    query.bindValue(":buscolor", buscolor);
    query.bindValue(":buscapacity", buscapacity);
    query.bindValue(":busmatricule", busmatricule);
    query.bindValue(":fueltype", fueltype);

    if(query.exec())
    {
        success = true;
    }
    else
    {
         qDebug() << "updateBus error:"
                  << query.lastError();
    }
}

void Database::updateRoute(int id, QString source, QString destination, QString stopname, QString stoplong, QString stoplat, int bus_id)
{
    bool success = false;
    QSqlQuery query;
    query.prepare("UPDATE route SET source = :source, destination = :destination, stopname = :stopname, stoplong = :stoplong, stoplat = :stoplat, bus_id = :bus_id WHERE id = :id");

    query.bindValue(":id", id);
    query.bindValue(":source", source);
    query.bindValue(":destination", destination);
    query.bindValue(":stopname", stopname);
    query.bindValue(":stoplong", stoplong);
    query.bindValue(":stoplat", stoplat);
    query.bindValue(":bus_id", bus_id);

    if(query.exec())
    {
        success = true;
    }
    else
    {
         qDebug() << "updateRoute error:"
                  << query.lastError();
    }
}

void Database::updateLostObject(int id, QString image, QString matricule, QString postdate, QString description)
{
    bool success = false;
    QSqlQuery query;
    query.prepare("UPDATE lostobject SET image = :image, matricule = :matricule, postdate = :postdate, description = :description WHERE id = :id");

    query.bindValue(":id", id);
    query.bindValue(":image", image);
    query.bindValue(":matricule", matricule);
    query.bindValue(":postdate", postdate);
    query.bindValue(":description", description);

    if(query.exec())
    {
        success = true;
    }
    else
    {
         qDebug() << "updateLostObject error:"
                  << query.lastError();
    }
}

//Delete elements

void Database::deleteStaff(int id)
{
    bool success = false;
    QSqlQuery query;
    query.prepare("DELETE FROM staff WHERE id = :id");
    query.bindValue(":id", id);

    if(query.exec())
    {
        success = true;
    }
    else
    {
         qDebug() << "deleteStaff error:"
                  << query.lastError();
    }
}

void Database::deleteDrivers(int id)
{
    bool success = false;
    QSqlQuery query;
    query.prepare("DELETE FROM driver WHERE id = :id");
    query.bindValue(":id", id);

    if(query.exec())
    {
        success = true;
    }
    else
    {
         qDebug() << "deleteDriver error:"
                  << query.lastError();
    }
}

void Database::deleteBus(int bus_id)
{
    bool success = false;
    QSqlQuery query;
    query.prepare("DELETE FROM bus WHERE bus_id = :bus_id");
    query.bindValue(":bus_id", bus_id);

    if(query.exec())
    {
        success = true;
    }
    else
    {
         qDebug() << "deleteBus error:"
                  << query.lastError();
    }
}

void Database::deleteRoute(int id)
{
    bool success = false;
    QSqlQuery query;
    query.prepare("DELETE FROM route WHERE id = :id");
    query.bindValue(":id", id);

    if(query.exec())
    {
        success = true;
    }
    else
    {
         qDebug() << "deleteRoute error:"
                  << query.lastError();
    }
}

void Database::deleteLostObject(int id)
{
    bool success = false;
    QSqlQuery query;
    query.prepare("DELETE FROM lostobject WHERE id = :id");
    query.bindValue(":id", id);

    if(query.exec())
    {
        success = true;
    }
    else
    {
         qDebug() << "deleteLostObject error:"
                  << query.lastError();
    }
}



