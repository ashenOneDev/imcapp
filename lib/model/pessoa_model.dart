import 'package:imcapp/model/imc_model.dart';

class Pessoa {
  String _nome = "";
  Imc _imc;

  Pessoa(this._nome, this._imc);

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  Imc get imc => _imc;

  set imc(Imc imc) {
    _imc = imc;
  }
}
