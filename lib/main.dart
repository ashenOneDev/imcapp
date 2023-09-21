import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imcapp/model/imc_model.dart';
import 'package:imcapp/model/pessoa_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documnetsDirectory = await path_provider.getApplicationCacheDirectory();
  Hive.init(documnetsDirectory.path);
  Hive.registerAdapter(PessoaModelAdapter());
  Hive.registerAdapter(ImcModelAdapter());
  runApp(const MyApp());
}
