import 'package:flutter1/model/filmes.dart';

class FilmesService {
   static final List<Filmes?> _filmes = [
      Filmes(
         id: 1,
         url: 'https://media.istockphoto.com/id/1322104312/pt/foto/freedom-chains-that-transform-into-birds-charge-concept.jpg?s=612x612&w=0&k=20&c=e5oxSsSFlsD8bdgXTCKNW4X0POTo1hs7nqAaNOeLgoo=',
         titulo: 'Wellington',
         genero: 'Terror',
         faixa_etaria: 12,
         duracao: '1h 30min',
         pontuacao: 1,
         descricao: 'Filme de suspense e terror',
         ano: 2024,
      ),
   ];

   Future<List<Filmes>> findAll() async {
      return List.unmodifiable(_filmes);
   }

   Future<Filmes?> findById(int id) async {
      return _filmes.firstWhere((filme) => filme?.id == id, orElse: () => null);
   }

   Future<void> save(Filmes filme) async {
      int novoId = (_filmes.isNotEmpty ? _filmes.map((f) => f?.id ?? 0).reduce((a, b) => a > b ? a : b) : 0) + 1;
      final novoFilme = Filmes(
         id: novoId,
         url: filme.url,
         titulo: filme.titulo,
         genero: filme.genero,
         faixa_etaria: filme.faixa_etaria,
         duracao: filme.duracao,
         pontuacao: filme.pontuacao,
         descricao: filme.descricao,
         ano: filme.ano,
      );
      _filmes.add(novoFilme);
   }

   Future<void> update(Filmes filme) async {
      int index = _filmes.indexWhere((f) => f?.id == filme.id);
      if (index != -1) {
         _filmes[index] = filme; // Atualiza os dados do filme
      }
   }

   Future<void> removerDaListaOriginalPeloId(int? id) async {
      if (id == null) return;
      _filmes.removeWhere((filme) => filme?.id == id);
   }
}