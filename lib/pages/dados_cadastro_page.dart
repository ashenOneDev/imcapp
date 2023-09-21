import 'package:flutter/material.dart';
import 'package:imcapp/repositories/pessoa_repository.dart';
import 'package:imcapp/shared/widgets/text_label.dart';

import '../model/pessoa_model.dart';

class DadosCadastroPage extends StatefulWidget {
  const DadosCadastroPage({super.key});

  @override
  State<DadosCadastroPage> createState() => _DadosCadastroPageState();
}

class _DadosCadastroPageState extends State<DadosCadastroPage> {
  late PessoaRepositoy pessoaRepositoy;
  PessoaModel pessoa = PessoaModel();
  TextEditingController nomeController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  TextEditingController dataNascimentoController = TextEditingController();
  DateTime? dataNascimento;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    pessoaRepositoy = await PessoaRepositoy.carregar();
    pessoa = pessoaRepositoy.obterDados();

    nomeController.text = pessoa.nome;
    alturaController.text =
        (pessoa.altura == 0 ? "" : pessoa.altura).toString();
    dataNascimentoController.text = pessoa.dataNascimento.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Meus dados"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: ListView(
          children: [
            const TextLabel(texto: "Nome"),
            TextField(
              keyboardType: TextInputType.name,
              controller: nomeController,
            ),
            const TextLabel(texto: "Data de nascimento"),
            TextField(
              controller: dataNascimentoController,
              readOnly: true,
              onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000, 1, 1),
                    firstDate: DateTime(1900, 1, 1),
                    lastDate: DateTime.now());
                if (date != null) {
                  dataNascimentoController.text =
                      date.toString().substring(0, 10);
                  dataNascimento = date;
                }
              },
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

                if (dataNascimento == null &&
                    dataNascimentoController.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Data de nascimento inválida!")));
                  return;
                } else {
                  pessoa.dataNascimento = dataNascimentoController.text;
                }

                try {
                  pessoa.altura = double.parse(alturaController.text);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Favor informar uma altura válida!")));
                  return;
                }

                if (pessoa.altura <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Favor informar uma altura válida!")));
                  return;
                }

                pessoaRepositoy.salvar(pessoa);

                Navigator.pop(context);
              },
              child: const Text("Salvar"),
            )
          ],
        ),
      ),
    ));
  }
}
