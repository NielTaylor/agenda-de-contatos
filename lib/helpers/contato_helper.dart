//Criando um molde para os contatos (backend)

// ignore_for_file: prefer_const_declarations

//1.2 instalei e importe o sqflite
import 'package:sqflite/sqflite.dart';

//1.6 abaixo vamos declarar o nome das colunas de minha tabela. Esses nomes têm
//ques ser iguais aos nome que estar na minha classe Contato e no meu construtor
//Contato
//1.7 colocaremos também esses valores como "final", pois esses valores não
//irão mudar em nenhum momento
final String idColuna = "idColuna";
final String nomeColuna = "nomeColuna";
final String telefoneColuna = "telefoneColuna";
final String emailColuna = "emailColuna";
final String imagemColuna = "imagemColuna";

class ContatoHelper {}

//1.3 agora preciso definir um molde para esse contato.. como esse contato vai
//ser criado
class Contato {
  //1.4 o id é o atributo que irá identificar o meu contato (pois pode ter
  //contatos com nomes iguais etc.)
  int? id;
  String? nome;
  String? telefone;
  String? email;
  String? imagem;

  //1.5 Vamos criar o construtor abaixo em formato de Map pois quando formos
  //armazenar os nossos dados no banco de dados vamos armazenar em formato de
  //mapa. E quando formos recuperar os nossos dados vamos transformar esse mapa
  //no formato da nossa classe Contato de fato (onde cada dado é um atributo).
  //Abaixo então já vamos fazer essa transformação
  Contato.deUmMapa(Map mapa) {
    //1.8 agora então vou pegar os valores que chegaram aqui como mapa, e passar
    //eles para os atributos da minha classe Contato
    id = mapa[idColuna];
    nome = mapa[nomeColuna];
    telefone = mapa[telefoneColuna];
    email = mapa[emailColuna];
    imagem = mapa[imagemColuna];
  }

  //1.9 vamos ter que também transformar os dados de nosso contato (classe
  //Contato) em um mapa. Acima pegamos o mapa e passamos para a classe Contato,
  //agora teremos que pegar a classe contato e passar para um mapa (para poder
  //enviar para o banco de dados/armazenar)

  //função que retorna um mapa
  Map paraMapa() {
    //2.1 string irá armazenar o campo, dynamic irá armazenar o dado em si
    //o que fiz basicamente foi o reverso mesmo, peguei o atributo e passei
    //para o mapa
    Map<String, dynamic> map = {
      nomeColuna: nome,
      telefoneColuna: telefone,
      emailColuna: email,
      imagemColuna: imagem,
    };
    //2.2 Acima não iremos colocar o id, porque quem dará o id será o BD em si
    //então quando formos enviar o dado para o BD, ele ainda não terá um id
    //Mas vai acontecer de irmos editar ou trabalhar com os dados de um contato
    //já salvo. Para esses momentos, vamos fazer uma checagem do id, se ele
    //existe ou não
    if (id != null) {
      //2.3 então se ele existir, passarei colocarei no meu mapa, que já criei
      //acima, o valor de idColuna
      map[idColuna] = id;
    }
    //a função então retornará esse nosso mapa
    return map;
  }

  //para deixar tudo melhor então, vou dar um override no toSring, que vai fazer
  //com que sempre que eu der um print no contato, ele me retorne essa string
  @override
  String toString() {
    return "Contato(id: $id, nome: $nome, telefone: $telefone, email: $email, imagem: $imagem)";
  }
}
