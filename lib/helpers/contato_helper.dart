// ignore_for_file: prefer_const_declarations
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//2.3 vou atribuir uma variável aqui o nome da minha tabela para então facilitar
//pois irei utilizar em vários locais ou várias vezes esse nome
final String contatoTabelaNome = "contatoTabela";
final String idColuna = "idColuna";
final String nomeColuna = "nomeColuna";
final String telefoneColuna = "telefoneColuna";
final String emailColuna = "emailColuna";
final String imagemColuna = "imagemColuna";

class ContatoHelper {
  static final ContatoHelper _instancia = ContatoHelper.interno();

  factory ContatoHelper() => _instancia;

  ContatoHelper.interno();

  Database? _banco;

  //2.9 e especifico aqui esse retorno futuro
  Future<Database?> get banco async {
    if (_banco != null) {
      return _banco;
    } else {
      //2.7 como vamos ter que esperar, deve ser utilizado aqui um await
      _banco = await iniciarBanco();
      //2.8 coloco então que essa função retorna o meu banco de dados
      return _banco;
    }
  }

  //2.6 como os valores abaixo são retornardos instantaneamente, colocarei
  //que essa minha função abaixo irá retornar um valor futuro
  Future<Database> iniciarBanco() async {
    final bancoPath = await getDatabasesPath();
    final caminho = join(bancoPath, "contatos.db");

    //2.1 agora vamos abrir o banco de dados
    return await openDatabase(caminho, version: 1,
        onCreate: (Database banco, int versaoMaisNova) async {
      //2.2 agora vamos executar o banco de dados. O código que estar dentro
      //do execute abaixo é um código de SQL
      //O que vamos fazer é pedir para o BD criar uma tabela que contenha as
      //colunas com os stributos do meu contato

      //2.4 os comandos vamos colocar em letras maísculas, comando em letras
      //mínúsculas
      await banco.execute(
          'CREATE TABLE $contatoTabelaNome($idColuna INTEGER PRIMARY KEY, $nomeColuna TEXT, $telefoneColuna TEXT, $emailColuna TEXT, $imagemColuna TEXT)');
      //2.5 com isso então já vamos ter aberto o banco de dados. No caso qnd
      //formos abrir pela primeira fez, ele já vai rodar o onCreate e criar
      //a nossa tabela
    });
  }
}

class Contato {
  int? id;
  String? nome;
  String? telefone;
  String? email;
  String? imagem;

  Contato.deUmMapa(Map mapa) {
    id = mapa[idColuna];
    nome = mapa[nomeColuna];
    telefone = mapa[telefoneColuna];
    email = mapa[emailColuna];
    imagem = mapa[imagemColuna];
  }

  Map paraMapa() {
    Map<String, dynamic> map = {
      nomeColuna: nome,
      telefoneColuna: telefone,
      emailColuna: email,
      imagemColuna: imagem,
    };
    if (id != null) {
      map[idColuna] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contato(id: $id, nome: $nome, telefone: $telefone, email: $email, imagem: $imagem)";
  }
}
