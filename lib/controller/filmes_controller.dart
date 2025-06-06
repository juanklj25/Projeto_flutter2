import 'dart:async';
import 'package:flutter1/service/filmes_services.dart';
import 'package:flutter1/model/filmes.dart';

class FilmesController {
  final _service = FilmesService();

  Future<List<Filmes>> findAll() async {
    final listaNaoNulo = await _service.findAll();
    return listaNaoNulo ?? [];
  }

  Future<void> save(String url, String titulo, String genero, int faixaEtaria, String duracao, int pontuacao, String descricao, int ano) async {
    await _service.save(Filmes(
      url: url,
      titulo: titulo,
      genero: genero,
      faixa_etaria: faixaEtaria,
      duracao: duracao,
      pontuacao: pontuacao,
      descricao: descricao,
      ano: ano,
    ));
  }

  Future<void> alterarFilme(int id, String url, String titulo, String genero, int faixaEtaria, String duracao, int pontuacao, String descricao, int ano) async {
    final filmeExistente = await _service.findById(id);

    if (filmeExistente != null) {
      await _service.update(Filmes(
        id: id,
        url: url,
        titulo: titulo,
        genero: genero,
        faixa_etaria: faixaEtaria,
        duracao: duracao,
        pontuacao: pontuacao,
        descricao: descricao,
        ano: ano,
      ));
    } else {
      throw Exception("Filme com ID $id não encontrado!");
    }
  }

  Future<void> removerFilmes(int? id) async {
    await _service.removerDaListaOriginalPeloId(id);
  }
}