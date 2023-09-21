import 'package:flutter/material.dart';
import 'package:imcapp/shared/widgets/custom_drawer.dart';

import '../model/imc_model.dart';
import '../shared/widgets/text_label.dart';

class ImcCalculadoraPage extends StatefulWidget {
  const ImcCalculadoraPage({super.key});

  @override
  State<ImcCalculadoraPage> createState() => _ImcCalculadoraPageState();
}

class _ImcCalculadoraPageState extends State<ImcCalculadoraPage> {
  ImcModel imcModel = ImcModel();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
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
                  double peso;
                  double altura;

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

                  double imc = imcModel.calcularIMC(altura, peso);
                  String classificacao = imcModel.classificacaoIMC(imc);

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
