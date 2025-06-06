import 'package:flutter/material.dart';
import '../controller/filmes_controller.dart';
import '../model/filmes.dart';
import 'cadastro_filmes.dart';
import 'detalhamento_filmes.dart';
import 'alteracao_filmes.dart';

class ListaFilmes extends StatefulWidget {
  const ListaFilmes({super.key});

  @override
  State<ListaFilmes> createState() => _ListaFilmesState();
}

class _ListaFilmesState extends State<ListaFilmes> {
  final FilmesController _filmesController = FilmesController();
  late Future<List<Filmes>> _futureFilmes;

  @override
  void initState() {
    super.initState();
    _carregarFilmes();
  }

  void _carregarFilmes() {
    setState(() {
      _futureFilmes = _filmesController.findAll();
    });
  }
  void _mostrarOpcoesFilme(BuildContext context, Filmes filme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 160,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DetalhesFilme(filme: filme)),
                                );
                              },
                              label: const Text("Ver Detalhes"),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton.icon(
                              onPressed: () async {
                                Navigator.pop(context);
                                final bool? resultado = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AlteracaoFilmes(filme: filme)),
                                );
                                if (resultado == true) {
                                  _carregarFilmes();
                                }
                              },
                              label: const Text("Alterar Filme"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _processarRemocaoFilme(Filmes filme) async {
    if (filme.id == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro: Filme sem ID não pode ser removido.")),
        );
      }
      _carregarFilmes();
      return;
    }

    try {
      await _filmesController.removerFilmes(filme.id!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${filme.titulo} removido com sucesso!")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao remover ${filme.titulo}: $e")),
        );
      }
      _carregarFilmes();
    }
  }
  void _mostrarAlerta(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Grupo'),
          content: Text('Grupo Juan, Giovanna, Felipe'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Listar Filmes"),
          actions: [
            IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _mostrarAlerta(context);
            },),],
    ),
      body: FutureBuilder<List<Filmes>>(
        future: _futureFilmes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar filmes: ${snapshot.error.toString()}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum filme cadastrado."));
          }

          final List<Filmes> filmesDaLista = snapshot.data!;

          return ListView.builder(
            itemCount: filmesDaLista.length,
            itemBuilder: (context, index) {
              final filme = filmesDaLista[index];
              return buildItemList(filme);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const CadastrarFilmes();
            }),
          );
          _carregarFilmes();
        },
        child: const Icon(Icons.add),
        tooltip: "Adicionar Filme",
      ),
    );
  }

  Widget buildItemList(Filmes filme) {
    return Dismissible(
      key: Key(filme.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        final bool? confirmado = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirmação de Remoção"),
              content: Text("Deseja realmente remover ${filme.titulo}?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCELAR"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("REMOVER"),
                ),
              ],
            );
          },
        );
        if (confirmado == true) {
          await _processarRemocaoFilme(filme);
        }
        return confirmado ?? false;
      },
      child: GestureDetector(
        onTap: () => _mostrarOpcoesFilme(context, filme),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    filme.url,
                    width: 120,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filme.titulo,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        filme.genero,
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        filme.duracao,
                        style: const TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(
                          filme.pontuacao,
                              (index) => const Icon(Icons.star, color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  }
