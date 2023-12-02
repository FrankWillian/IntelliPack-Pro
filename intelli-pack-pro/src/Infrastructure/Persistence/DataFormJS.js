function salvar() {

    db.transaction(function(tx){
        var sql = 'SELECT id,nome,idade FROM persona'
        var rs = tx.executeSql(sql);
        var ix;
        var myiId;
        var myIdade;
        var myNome;

        for(ix = 0; ix < rs.rows.length; ++ix){
            myiId = rs.rows.item(ix).id;
            myNome = rs.rows.item(ix).nome;
            myIdade = rs.rows.item(ix).idade;
            tabela.model.append({
                 id: myiId,
                 nome: myNome,
                 idade: myIdade
            })
        }
    } );

}
