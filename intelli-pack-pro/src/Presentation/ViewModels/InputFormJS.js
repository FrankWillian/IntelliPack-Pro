function input() {
    var nome = nomeTextField.text;
    var idade = idadeTextField.text;
    db.transaction(function(tx){
        var sql = 'INSERT INTO persona (nome,idade) VALUES (\''
                + nome + '\',' + idade + ')';

        tx.executeSql(sql);



    });

}
