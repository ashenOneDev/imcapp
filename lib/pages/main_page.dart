import 'package:flutter/material.dart';
import 'package:imcapp/model/pessoa_model.dart';
import 'package:imcapp/pages/imc_caluladora_page.dart';
import 'package:imcapp/shared/widgets/custom_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PessoaModel pessoa = PessoaModel();
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
            drawer: const CustomDrawer(),
            body: const ImcCalculadoraPage()));
  }
}
