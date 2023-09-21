import 'package:hive/hive.dart';
import 'package:imcapp/model/imc_model.dart';

class ImcRepositoy {
  static late Box _box;

  ImcRepositoy._criar();

  static Future<ImcRepositoy> carregar() async {
    if (Hive.isBoxOpen('dadosImc')) {
      _box = Hive.box("dadosImc");
    } else {
      _box = await Hive.openBox("dadosImc");
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
