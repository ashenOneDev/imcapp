import 'package:hive/hive.dart';

part 'pessoa_model.g.dart';

@HiveType(typeId: 0)
class PessoaModel extends HiveObject {
  @HiveField(0)
  String nome = "";
  @HiveField(1)
  String dataNascimento = "";
  @HiveField(2)
  double altura = 0;

  PessoaModel.criar(this.nome, this.dataNascimento, this.altura);

  PessoaModel();
}
