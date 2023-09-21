import 'package:flutter/material.dart';
import 'package:imcapp/model/imc_model.dart';
import 'package:imcapp/model/pessoa_model.dart';
import 'package:imcapp/repositories/imc_repository.dart';
import 'package:imcapp/repositories/pessoa_repository.dart';

import '../shared/widgets/text_label.dart';
import '../shared/widgets/text_label_table.dart';

class AcompanhamentoImcPage extends StatefulWidget {
  const AcompanhamentoImcPage({super.key});

  @override
  State<AcompanhamentoImcPage> createState() => _AcompanhamentoImcPageState();
}

class _AcompanhamentoImcPageState extends State<AcompanhamentoImcPage> {
  TextEditingController pesoController = TextEditingController();
  late ImcRepositoy imcRepositoy;
  List<ImcModel> _imcs = const <ImcModel>[];

  late PessoaRepositoy pessoaRepositoy;
  PessoaModel pessoaModel = PessoaModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterDadosImc();
  }

  void obterDadosImc() async {
    imcRepositoy = await ImcRepositoy.carregar();
    _imcs = await imcRepositoy.obterDados();
    pessoaRepositoy = await PessoaRepositoy.carregar();
    pessoaModel = pessoaRepositoy.obterDados();
    setState(() {});
  }

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
                            imcRepositoy.salvar(ImcModel.criar(
                                DateTime.now().toString(),
                                pessoaModel.altura == 0
                                    ? 1
                                    : pessoaModel.altura,
                                double.parse(pesoController.text)));

                            Navigator.pop(context);
                            obterDadosImc();
                            setState(() {});
                          },
                          child: const Text("Salvar"))
                    ],
                  );
                });
          }),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextLabel(texto: "Data"),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 2,
                  child: TextLabel(texto: "IMC"),
                ),
                Expanded(
                  flex: 5,
                  child: TextLabel(texto: "Classificação"),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                itemCount: _imcs.length,
                itemBuilder: (BuildContext bc, int index) {
                  var imc = _imcs[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {
                      await imcRepositoy.remover(imc);
                      obterDadosImc();
                    },
                    key: Key(imc.data),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child:
                              TextLabelTable(texto: imc.data.substring(0, 10)),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 2,
                          child:
                              TextLabelTable(texto: imc.imc.toStringAsFixed(2)),
                        ),
                        Expanded(
                          flex: 5,
                          child: TextLabelTable(texto: imc.classificacao),
                        ),
                      ],
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
