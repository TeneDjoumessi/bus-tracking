// DatabaseConnection.qml
import QtQuick 2.15
import QtQuick.Sql 5.15

QtObject {
    id: databaseManager
    property SqlDatabase database: SqlDatabase {
        id: database
        driver: "QSQLITE"
        databaseName: "users.db"
    }

    function connect() {
        database.open()
    }

    function disconnect() {
        database.close()
    }

    function getUserCredentials(username, password) {
        var query = database.exec("SELECT * FROM users WHERE username = ? AND password = ?", [username, password])
        if (query.next()) {
            return {
                "id": query.value("id"),
                "username": query.value("username"),
                "password": query.value("password")
            }
        } else {
            return null
        }
    }

    function getDatabaseConnection() {
        var db = LocalStorage.openDatabaseSync("TrackMedb", "1.0", "My Database", 1000000);
        db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT, role INTEGER)');
        });
        return db;
    }

    function getUserRole(userName) {
        var db = getDatabaseConnection();
        var role = -1;
        db.transaction(function(tx) {
            var result = tx.executeSql('SELECT role FROM users WHERE name = ?', [userName]);
            if (result.rows.length > 0) {
                role = result.rows.item(0).role;
            }
        });
        return role;
    }

    function setUserRole(userName, role) {
        var db = getDatabaseConnection();
        db.transaction(function(tx) {
            var result = tx.executeSql('SELECT id FROM users WHERE name = ?', [userName]);
            if (result.rows.length > 0) {
                tx.executeSql('UPDATE users SET role = ? WHERE name = ?', [role, userName]);
            } else {
                tx.executeSql('INSERT INTO users (name, role) VALUES (?, ?)', [userName, role]);
            }
        });
    }
}



