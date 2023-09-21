import 'package:flutter/material.dart';

class AcompanhamentoImcPage extends StatefulWidget {
  const AcompanhamentoImcPage({super.key});

  @override
  State<AcompanhamentoImcPage> createState() => _AcompanhamentoImcPageState();
}

class _AcompanhamentoImcPageState extends State<AcompanhamentoImcPage> {
  TextEditingController pesoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterDados();
  }

  void obterDados() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Acompanhamento IMC"),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text("Adicionar peso"),
                    content: TextField(
                      keyboardType: TextInputType.number,
                      controller: pesoController,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            obterDados();
                            setState(() {});
                          },
                          child: const Text("Salvar"))
                    ],
                  );
                });
          }),
    ));
  }
}
