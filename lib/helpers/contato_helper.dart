// ignore_for_file: prefer_const_declarations
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String idColuna = "idColuna";
final String nomeColuna = "nomeColuna";
final String telefoneColuna = "telefoneColuna";
final String emailColuna = "emailColuna";
final String imagemColuna = "imagemColuna";

//1.1 Essa classe vai conter apenas um objeto em todo nosso código. Ela não vai
//poder ter várias instâncias ao longo do código. Por isso então vamos utilizar
//um padrão chamado Singleton. É um padrão interessante quando queremos ter
//apenas um objeto de nossa classe
class ContatoHelper {
  //1.2 primeiro declaramos "static". Ele indica que essa será uma variável que
  //terá apenas uma em toda a minha classe (é uma variável da minha classe, e
  //não do meu objeto)
  //
  //static final "Obejeto_da_classe_dentro_da_própria_classe" _instance<<muito
  //utilizando esse nome = ContatoHelper.chamar_construtor_interno
  //
  //Resumindo: abaixo estou criando um objeto da minha própria classe chamado
  //_instancia. Só terei essa única instancia do ContatoHelper. cm é um construtor
  //interno ele só poderá ser chamado de dentro da própria classe
  static final ContatoHelper _instancia = ContatoHelper.interno();

  //1.4 será explicado melhor depois
  factory ContatoHelper() => _instancia;

  //1.3 Chamo ele aqui, e instancio ele no passo acima
  ContatoHelper.interno();

  //1.5 abaixo de claro o meu banco de dados..
  //coloco underlineBanco porque eu não quero ser capaz de chamar ele de fora da
  //minha classe
  Database? _banco;

  //1.6 agora vamos inicializar o banco de dados
  get banco {
    //verificamos se o banco já não estar inicializado
    if (_banco != null) {
      return _banco;
      //se não estiver, iniciamos ele
    } else {
      _banco = iniciarBanco();
    }

    //1.7 função para inicializar o banco
    iniciarBanco() async {
      //1.8 primeiro, vamos pegar o local onde o banco é armazenado
      //await pq o caminho não retornará de imediato. e async acima pq aq tem um
      //await. o getDatabasesPath() é uma função do sqflite
      final bancoPath = await getDatabasesPath();
      //1.9 peguei o caminho acima, e agr irei pegar o arquivo de banco de fato
      //o join é do pacote "path" que foi importato
      //então o caminho do meu banco dados + o nome do arquivo retorna então
      //o arquivo/banco em si
      final path = join(bancoPath, "contatos.db");
    }
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
