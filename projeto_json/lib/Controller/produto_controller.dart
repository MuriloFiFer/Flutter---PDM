import 'dart:convert';
import 'dart:io';

import 'package:projeto_json/Model/produtos_model.dart';

class ProdutoController {
  //atributo
List<Produto> _produtos = []; //privado
//método get
List<Produto> get produtos {
  return _produtos;
}

//salvar produtos no Jsoin
Future<void> salvarJson() async {
  final file = File('produtos.json');
  final jsonList = produtos.map((produto) => produto.toJson()).toList();
  await file.writeAsString(jsonEncode(jsonList));


}
}