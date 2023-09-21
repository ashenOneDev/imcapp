import 'package:hive/hive.dart';

part 'imc_model.g.dart';

@HiveType(typeId: 1)
class ImcModel extends HiveObject {
  @HiveField(0)
  double altura = 0;
  @HiveField(1)
  double peso = 0;
  @HiveField(2)
  double imc = 0;
  @HiveField(3)
  String data = "";
  @HiveField(4)
  String classificacao = "";

  ImcModel.criar(this.data, this.altura, this.peso) {
    imc = calcularIMC(altura, peso);
    classificacao = classificacaoIMC(imc);
  }

  ImcModel();

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
}
