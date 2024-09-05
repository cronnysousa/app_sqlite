import 'package:sqflite/sqflite.dart';

import 'contato.dart';

class DbHelperContatos{
  late Database db;

  DbHelperContatos()
  {
    conecta();
  }

  Future<void> conecta()  async {
    String caminho = await getDatabasesPath();
    db = await openDatabase( caminho + "dbcontatos.db",version: 1 ,
    onCreate: (Database db,int version ) async {
      db.execute('''Create Table contatos (
      id integer primary key autoincrement,
      nome text,
      email text,
      foto text,
      telefone text,
      endereco text 
      )     
      ''');
    }
    );
  }

  Future<int> inserirContato(Contato c)
  async {
    await conecta();
    return await db.insert('contatos', c.toMap());
  }

  Future<int> atualizaContato(Contato c)
  async {
    await conecta();
    return await db.update('contatos',
        c.toMap(),where: "id=?",whereArgs: [c.id] );
  }

  Future<List<Contato>> getAllContatos() async {
    await conecta();
    return  List<Contato>.from(
        (await db.query('contatos'))
        .map((e) => Contato(
            nome: e['nome'].toString(),
            email: e['email'].toString(),
            endereco: e['endereco'].toString(),
            foto: e['endereco'].toString(),
            telefone: e['telefone'].toString(),
            id: int.parse( e['id'].toString())
          )
        )
    );
  }



}