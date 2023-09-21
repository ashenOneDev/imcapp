import 'package:hive/hive.dart';
import 'package:imcapp/model/pessoa_model.dart';

class PessoaRepositoy {
  static late Box _box;

  PessoaRepositoy._criar();

  static Future<PessoaRepositoy> carregar() async {
    if (Hive.isBoxOpen('dadosCadastrados')) {
      _box = Hive.box("dadosCadastrados");
    } else {
      _box = await Hive.openBox("dadosCadastrados");
    }
    return PessoaRepositoy._criar();
  }

  salvar(PessoaModel pessoaModel) {
    _box.put("pessoaModel", pessoaModel);
  }

  PessoaModel obterDados() {
    var pessoaModel = _box.get("pessoaModel");
    if (pessoaModel == null) {
      return PessoaModel();
    }
    return pessoaModel;
  }
}
