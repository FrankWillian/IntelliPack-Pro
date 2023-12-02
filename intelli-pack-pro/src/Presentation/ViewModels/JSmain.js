function executeBanco() {

    db = LocalStorage.openDatabaseSync(dbId,dbVersao,dbDescricao,dbSize);

    db.transaction(function(tx){
        var sql = 'CREATE TABLE IF NOT EXISTS persona'
                + '(id INTEGER PRIMARY KEY AUTOINCREMENT,'
                + 'nome TEXT NOT NULL, idade INTEGER NOT NULL)';
        tx.executeSql(sql);
    } );

}
