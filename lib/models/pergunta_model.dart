class PerguntaModel {
  String id;
  String nome;
  String ramo;
  String email;
  String descricao;
  String titulo;

  PerguntaModel(
      {this.id, this.nome, this.ramo, this.email, this.descricao, this.titulo});

  PerguntaModel.fromMap(Map map) {
    this.id = map['id'];
    this.nome = map['nome'];
    this.ramo = map['ramo'];
    this.email = map['email'];
    this.descricao = map['descricao'];
    this.titulo = map['titulo'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'nome': this.nome,
      'ramo': this.ramo,
      'email': this.email,
      'descricao': this.descricao,
      'titulo': this.titulo,
    };

    return map;
  }
}
