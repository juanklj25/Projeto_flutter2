import 'package:flutter/material.dart';
import '../model/filmes.dart';

class DetalhesFilme extends StatelessWidget {
  final Filmes filme;

  const DetalhesFilme({super.key, required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(filme.titulo)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(filme.url, width: double.infinity, height: 250, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Text(
                    filme.titulo,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text("Ano: ${filme.ano}", style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(filme.genero, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                      Text("Classificação: ${filme.faixa_etaria} anos", style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${filme.duracao}", style: const TextStyle(fontSize: 16, color: Colors.grey)),
                      const SizedBox(width: 16),
                      Row(children: List.generate(filme.pontuacao, (index) => const Icon(Icons.star, color: Colors.amber))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  const SizedBox(height: 16),
                  Text(filme.descricao, style: const TextStyle(fontSize: 16, color: Colors.grey,fontFamily: 'Roboto')),

                    ],
                  ),
                ]),
            ),
          ],
        ),
      ),
    );
  }
}