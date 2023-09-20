import 'package:flutter/material.dart';
import 'package:imcapp/model/pessoa_model.dart';

import '../model/imc_model.dart';
import '../shared/widgets/text_label.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Pessoa pessoa = Pessoa("", Imc());
  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            const TextLabel(texto: "Nome"),
            TextField(
              keyboardType: TextInputType.name,
              controller: nomeController,
            ),
            const TextLabel(texto: "Peso"),
            TextField(
              keyboardType: TextInputType.number,
              controller: pesoController,
            ),
            const TextLabel(texto: "Altura"),
            TextField(
              keyboardType: TextInputType.number,
              controller: alturaController,
            ),
            TextButton(
                onPressed: () {
                  if (nomeController.text.trim().length < 3) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("O nome deve ser preenchido!")));
                    return;
                  } else {
                    pessoa.nome = nomeController.text.trim();
                  }

                  try {
                    pessoa.imc.peso = double.parse(pesoController.text);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Favor informar um peso válido!")));
                    return;
                  }

                  try {
                    pessoa.imc.altura = double.parse(alturaController.text);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Favor informar uma altura válida!")));
                    return;
                  }

                  var imc = Imc.criar(pessoa.imc.altura, pessoa.imc.peso);
                  var classificacao = Imc().classificacaoIMC(imc.value);

                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("Resultado:"),
                          content: Wrap(
                            children: [
                              TextLabel(
                                  texto:
                                      "IMC: ${imc.value.toStringAsFixed(2)}"),
                              TextLabel(texto: "Classificação: $classificacao"),
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"))
                          ],
                        );
                      });
                },
                child: const Text("Calcular"))
          ],
        ),
      ),
    ));
  }
}
