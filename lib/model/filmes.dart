class Filmes{
  int? id;
  String url;
  String titulo;
  String genero;
  int faixa_etaria;
  String duracao;
  int pontuacao;
  String descricao;
  int ano;

  Filmes({ this.id, required this.url,required this.titulo,required this.genero,required this.faixa_etaria,required this.duracao,required this.pontuacao,required this.descricao,required this.ano});

  Map<String, dynamic> toMap(){
    return {
      '_id': id,
      'url': url,
      'titulo': titulo,
      'genero': genero,
      'faixa_etaria': faixa_etaria,
      'duracao': duracao,
      'pontuacao': pontuacao,
      'descricao': descricao,
      'ano': ano
    };
  }

  factory Filmes.fromMap(Map<String, dynamic> map){
    return Filmes(
        id: map['_id'],
        url: map['url'],
        titulo: map['titulo'],
        genero: map['genero'],
        faixa_etaria: map['faixa_etaria'],
        duracao: map['duracao'],
        pontuacao: map['pontuacao'],
        descricao: map['descricao'],
        ano: map['ano'],
    );
  }

  factory Filmes.fromJson(Map<String, dynamic> map){
    return Filmes(
      id: int.parse(map['id']),
      url: map['url'],
      titulo: map['titulo'],
      genero: map['genero'],
      faixa_etaria: int.parse(map['faixa_etaria']),
      duracao: map['duracao'],
      pontuacao: int.parse(map['pontuacao']),
      descricao: map['descricao'],
      ano: int.parse(map['ano']),
    );
  }

  @override
  String toString(){
    return "[Nome: $id, Email: $url,Nome: $titulo,Nome: $genero,Nome: $faixa_etaria,Nome: $duracao,Nome: $pontuacao,Nome: $descricao,Nome: $ano]";
  }
}