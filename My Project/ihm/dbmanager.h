#ifndef DBMANAGER_H
#define DBMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>

class dbmanager : public QObject
{

    Q_OBJECT
public:
    typedef enum field_type_s
    {
        VARCHAR,
        INTEGER,
        DOUBLE,
        TIMESTAMP,
        FIELD_NUM,
    }field_type_e;

    typedef struct fields_s
    {
        QString field_name;
        field_type_e field_type;
    }fields_t;

    ~dbmanager();
    explicit dbmanager(QObject *parent = 0);
    dbmanager(const QString &data);
    bool isOpen() const;

    bool createDatabase(void);
    bool createTable(const QString &table_name, const QVector<fields_t>& fields);
    bool newCodeRegister(const QString &table_name, uint timestamp, const QString &code);
    bool newProduct(const QString &table_name, const QString &product, const QString &code);
    bool removeAllProducts(const QString &table_name);
    QString getProductFromCode(const QString &table_name, const QString &product );

private:
    QString database;
    QSqlDatabase db;
    const QString field_name_str[FIELD_NUM] =
    {"VARCHAR(255)", "INTEGER", "DOUBLE", "TIMESTAMP"};

signals:

public slots:
};

#endif // DBMANAGER_H
