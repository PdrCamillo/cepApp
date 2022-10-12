import 'dart:convert';

class EnderecoModel {
  final String cep;
  final String logradouro;
  final String complemento;
  final String localidade;

  EnderecoModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.localidade,
  });

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'localidade': localidade,
    };
  }

  factory EnderecoModel.fromMap(Map<String, dynamic> map) {
    return EnderecoModel(
      cep: map['cep'],
      logradouro: map['logradouro'],
      complemento: map['complemento'],
      localidade: map['localidade'],
    );
  }

  factory EnderecoModel.fromJson(String json) =>
      EnderecoModel.fromMap(jsonDecode(json));
}
