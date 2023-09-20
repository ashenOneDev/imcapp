import 'package:flutter/material.dart';

import '../shared/widgets/text_label.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  double calcularIMC(double altura, double peso) {
    return peso / (altura * altura);
  }

  String classificacaoIMC(double imc) {
    String classificacao = "";
    if (imc < 16) {
      classificacao = "Magreza grave";
    } else if (imc < 17) {
      classificacao = "Magreza moderada";
    } else if (imc < 18.5) {
      classificacao = "Magreza leve";
    } else if (imc < 25) {
      classificacao = "Saudável";
    } else if (imc < 30) {
      classificacao = "Sobrepeso";
    } else if (imc < 35) {
      classificacao = "Obesidade Grau I";
    } else if (imc < 40) {
      classificacao = "Obesidade Grau II (severa)";
    } else {
      classificacao = "Obesidade Grau III (mórbida)";
    }
    return classificacao;
  }

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
                  double altura = 0;
                  double peso = 0;
                  if (nomeController.text.trim().length < 3) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("O nome deve ser preenchido!")));
                    return;
                  }

                  try {
                    peso = double.parse(pesoController.text);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Favor informar um peso válido!")));
                    return;
                  }

                  try {
                    altura = double.parse(alturaController.text);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Favor informar uma altura válida!")));
                    return;
                  }

                  var imc = calcularIMC(altura, peso);
                  var classificacao = classificacaoIMC(imc);

                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("Resultado:"),
                          content: Wrap(
                            children: [
                              TextLabel(
                                  texto: "IMC: ${imc.toStringAsFixed(2)}"),
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
