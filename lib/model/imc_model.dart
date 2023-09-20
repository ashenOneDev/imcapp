class Imc {
  double _altura = 0;
  double _peso = 0;
  double _imc = 0;

  Imc.criar(this._altura, this._peso) {
    _imc = calcularIMC(_altura, _peso);
  }

  Imc();

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  double get value => _imc;

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
