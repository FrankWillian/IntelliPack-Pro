#include "dbmanager.h"
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QDebug>

dbmanager::dbmanager(QObject *parent) : QObject(parent)
{

}

dbmanager::dbmanager(const QString &data)
{
    database = data;
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(data);
    if(!db.open()){
#ifdef QT_DEBUG
        qDebug() << "Erro ao tentar abrir database";
#endif
    }
    else{
#ifdef QT_DEBUG
        qDebug() << "Database criado com sucesso";
#endif
    }
}

dbmanager::~dbmanager()
{
    if(db.isOpen()){
        db.close();
    }
}

bool dbmanager::isOpen() const
{
    return db.isOpen();
}

bool dbmanager::createDatabase(void)
{
    bool sucess = false;
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(database);
    if(!db.open()){
#ifdef QT_DEBUG
        qDebug() << "Erro ao tentar abrir database";
#endif
        sucess = false;
    }
    else{
#ifdef QT_DEBUG
        qDebug() << "Database criado com sucesso";
#endif
        sucess = true;
    }

    return sucess;
}

bool dbmanager::createTable(const QString& table_name, const QVector<fields_t>& fields)
{
    QString query_cmd;
    QSqlQuery query;
    bool sucess = false;

    if((table_name == "") || (fields.length() <= 0))
    {
        sucess = false;
    }
    else{
        query_cmd = "CREATE TABLE IF NOT EXISTS " + table_name +
                " (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT";
        for(int i = 0; i < fields.length(); i++)
        {
            query_cmd += ", " +fields[i].field_name + " " +
                    field_name_str[fields[i].field_type] +
                    " NOT NULL";
        }
        query_cmd += ")";
        query.prepare(query_cmd);

        if(!query.exec()){
#ifdef QT_DEBUG
            qDebug() << "Nao foi possivel criar a tabela: " << table_name;
#endif
            sucess = false;
        }else {
#ifdef QT_DEBUG
            qDebug() << "A tabela: " << table_name << " foi criada com sucesso";
#endif
            sucess = true;
        }
    }
    return sucess;
}

bool dbmanager::newCodeRegister(const QString &table_name, uint timestamp, const QString &code)
{
    bool sucess = false;

    if(!table_name.isEmpty() && !code.isEmpty()){
        QSqlQuery query;
        query.prepare("INSERT INTO " + table_name + " (TIMESTAMP, CODIGO) VALUES (:timestamp,:codigo)");
        query.bindValue(":timestamp",QString::number(timestamp));
        query.bindValue(":codigo",code);

        if(query.exec()){
#ifdef QT_DEBUG
            qDebug() << "Registro da tabela " << table_name << " criado com sucesso";
#endif
            sucess = true;
        }else {
#ifdef QT_DEBUG
            qDebug() << "Falha a criar registro: " << query.lastError();
#endif
        }
    }else {
#ifdef QT_DEBUG
        qDebug() << "Erro ao executar query do registro";
#endif
        sucess = false;
    }

    return sucess;
}

bool dbmanager::newProduct(const QString &table_name, const QString &product, const QString &code)
{
    bool sucess = false;

    if(!table_name.isEmpty() && !code.isEmpty()){
        QSqlQuery query;
        query.prepare("INSERT INTO " + table_name + " (PRODUTO, CODIGO) VALUES (:produto,:codigo)");
        query.bindValue(":produto",product);
        query.bindValue(":codigo",code);

        if(query.exec()){
#ifdef QT_DEBUG
            qDebug() << "Registro criado com sucesso";
#endif
            sucess = true;
        }else {
#ifdef QT_DEBUG
            qDebug() << "Falha a criar registro: " << query.lastError();
#endif
        }
    }else {
#ifdef QT_DEBUG
        qDebug() << "Erro ao executar query do registro";
#endif
        sucess = false;
    }

    return sucess;
}

bool dbmanager::removeAllProducts(const QString &table_name)
{
    bool sucess = false;

    if(!table_name.isEmpty()){
        QSqlQuery query;
        query.prepare("DELETE FROM " + table_name);

        if(query.exec()){
#ifdef QT_DEBUG
            qDebug() << "Tabela " << table_name << " limpa com sucesso";
#endif
            sucess = true;
        }else {
#ifdef QT_DEBUG
            qDebug() << "Falha a limpar tabela: " << query.lastError();
#endif
        }
    }else {
#ifdef QT_DEBUG
        qDebug() << "Falha ao apagar os dados da tabela: " << table_name;
#endif
        sucess = false;
    }

    return sucess;
}

QString dbmanager::getProductFromCode(const QString &table_name, const QString &product )
{
    QString prod = "";
    if(!table_name.isEmpty() && !product.isEmpty()){
        QSqlQuery query;
        query.prepare("SELECT CODIGO FROM " + table_name + " WHERE PRODUTO = (:produto)");
        query.bindValue(":produto",product);

        if(query.exec()){
            if(query.next()){
                prod = query.value("CODIGO").toString();
#ifdef QT_DEBUG
                qDebug() << "Leitura realizada " << prod;
#endif
            }
            else{
#ifdef QT_DEBUG
                qDebug() << "Nenhum registro encontrado para o produto " << product;
#endif
            }

        }else {
#ifdef QT_DEBUG
            qDebug() << "Query: " << query.lastQuery();
            qDebug() << "Falha a ler registro: " << query.lastError();
#endif
        }
    }else {
#ifdef QT_DEBUG
        qDebug() << "Erro ao executar query de leitura";
#endif
    }
    return prod;
}


