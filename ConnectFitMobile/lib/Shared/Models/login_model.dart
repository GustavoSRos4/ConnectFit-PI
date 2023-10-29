class LoginModel {
  final String? nome;
  final String? cpf;
  final String? dataNas;
  final String? telefone;
  final String? cep;
  final String? logradouro;
  final String? numero;
  final String? cidade;
  final String? bairro;
  final String? estado;
  final String? pais;
  final String? usuario;
  final String? email;
  final String? senha;

  LoginModel({
    this.nome,
    this.cpf,
    this.dataNas,
    this.telefone,
    this.cep,
    this.logradouro,
    this.numero,
    this.cidade,
    this.bairro,
    this.estado,
    this.pais,
    this.usuario,
    this.email,
    this.senha,
  });

  LoginModel copyWith({
    String? nome,
    String? cpf,
    String? dataNas,
    String? telefone,
    String? cep,
    String? logradouro,
    String? numero,
    String? cidade,
    String? bairro,
    String? estado,
    String? pais,
    String? usuario,
    String? email,
    String? senha,
  }) {
    return LoginModel(
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      dataNas: dataNas ?? this.dataNas,
      telefone: telefone ?? this.telefone,
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      numero: numero ?? this.numero,
      cidade: cidade ?? this.cidade,
      bairro: bairro ?? this.bairro,
      estado: estado ?? this.estado,
      pais: pais ?? this.pais,
      usuario: usuario ?? this.usuario,
      email: email ?? this.email,
      senha: senha ?? this.senha,
    );
  }

  @override
  String toString() => """LoginModel(
      nome: $nome, 
      CPF: $cpf, 
      Data de Nascimento: $dataNas, 
      Telefone: $telefone, 
      CEP: $cep, 
      Logradouro: $logradouro,
      Número: $numero,
      Cidade: $cidade,
      Bairro: $bairro,
      Estado: $estado,
      País: $pais,
      Usuario: $usuario,
      Email: $email, 
      Senha: $senha,
      )""";
}
