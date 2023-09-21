import 'package:hive/hive.dart';
import 'package:imcapp/model/imc_model.dart';

class ImcRepositoy {
  static late Box _box;

  ImcRepositoy._criar();

  static Future<ImcRepositoy> carregar() async {
    if (Hive.isBoxOpen('dadosCadastrados')) {
      _box = Hive.box("dadosCadastrados");
    } else {
      _box = await Hive.openBox("dadosCadastrados");
    }
    return ImcRepositoy._criar();
  }

  salvar(ImcModel imcModel) {
    _box.add(imcModel);
  }

  alterar(ImcModel imcModel) {
    imcModel.save();
  }

  remover(ImcModel imcModel) {
    imcModel.delete();
  }

  List<ImcModel> obterDados() {
    return _box.values.cast<ImcModel>().toList();
  }
}
