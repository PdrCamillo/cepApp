import 'dart:ffi';

import 'package:cep_app/models/endereco_model.dart';
import 'package:cep_app/repositories/cep_repository.dart';
import 'package:cep_app/repositories/cep_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CepRepository cepRepository = CepRepositoryImpl();
  EnderecoModel? enderecoModel;

  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador CEP'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                controller: cepEC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'CEP Obrigatório';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  final valid = formKey.currentState?.validate() ?? false;
                  if (valid) {
                    try {
                      final endereco = await cepRepository.getCep(cepEC.text);
                      setState(() {
                        enderecoModel = endereco;
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Erro ao buscar endereço!')));
                    }
                  }
                },
                child: const Text('Buscar')),
            const SizedBox(
              width: 20,
              height: 150,
            ),
            Visibility(
                visible: enderecoModel != null,
                child: Center(
                  child: Text(
                    '${enderecoModel?.logradouro} ${enderecoModel?.complemento} ${enderecoModel?.cep} ${enderecoModel?.localidade}',
                    style: TextStyle(fontSize: 18),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
