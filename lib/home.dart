// home_page.dart

import 'package:app_sqlite/dbhelper_contatos.dart';
import 'package:flutter/material.dart';
import 'contato.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware  {
  List<Contato> contatos = [];
  final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext(){
    super.didPopNext();
    carregar();
    print('teste');
  }

  @override
  @protected
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    var helperContatos= DbHelperContatos();
    await helperContatos.conecta();
    var novalista = await helperContatos.getAllContatos();
      setState(()  {
        contatos = novalista;
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(contato.foto),
            ),
            title: Text(contato.nome),
            subtitle: Text(contato.email),
            trailing: Text(contato.telefone),
            onTap: () {
              //cadastrar();
              //carregar();
              // Ação ao tocar no contato (ex.: exibir detalhes)
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add_circle_outline_sharp),

        onPressed: () {
          Navigator.pushNamed(context, "/cadastro");
        },

      ),
    );
  }
}
