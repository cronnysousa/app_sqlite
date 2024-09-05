// contato.dart

class Contato {
  int? id;
  String nome;
  String email;
  String foto;
  String telefone;
  String endereco;

  Contato({
    this.id,
    required this.nome,
    required this.email,
    required this.foto,
    required this.telefone,
    required this.endereco,
  });

  // Convert a Contato into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'foto': foto,
      'telefone': telefone,
      'endereco': endereco,
    };
  }

  // Implement toString to make it easier to see information about each contato when using the print statement.
  @override
  String toString() {
    return 'Contato{id: $id, nome: $nome, email: $email, foto: $foto, telefone: $telefone, endereco: $endereco}';
  }
}
