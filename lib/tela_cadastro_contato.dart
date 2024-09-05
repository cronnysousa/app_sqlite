import 'package:app_sqlite/contato.dart';
import 'package:app_sqlite/dbhelper_contatos.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Para escolher a foto
import 'dart:io'; // Para lidar com arquivos

class CadastroContatoWidget extends StatefulWidget {
  @override
  _CadastroContatoWidgetState createState() => _CadastroContatoWidgetState();
}

class _CadastroContatoWidgetState extends State<CadastroContatoWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  String? _foto;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _foto = pickedFile.path;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Aqui você pode criar um objeto Contato e fazer o que precisar com ele
      final nome = _nomeController.text;
      final endereco = _enderecoController.text;
      final email = _emailController.text;
      final telefone = _telefoneController.text;
      final foto = _foto;
      
      var contato= Contato(nome: nome, email: email, foto: foto??"", telefone: telefone, endereco: endereco);
      var helper= DbHelperContatos();
      helper.inserirContato( contato).then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Contato cadastrado!')))

      })  ;
      


      // Aqui você pode adicionar a lógica para salvar o contato no banco de dados ou enviar para um servidor
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _foto != null ? FileImage(File(_foto!)) : null,
                  child: _foto == null ? Icon(Icons.camera_alt, size: 50) : null,
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _enderecoController,
                decoration: InputDecoration(labelText: 'Endereço'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o endereço';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}