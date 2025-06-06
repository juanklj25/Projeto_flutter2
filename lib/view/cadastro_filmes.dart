import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:flutter1/controller/filmes_controller.dart';

class CadastrarFilmes extends StatefulWidget {
  const CadastrarFilmes({super.key});

  @override
  State<CadastrarFilmes> createState() => _CadastrarFilmesState();
}

class _CadastrarFilmesState extends State<CadastrarFilmes> {
  final _key = GlobalKey<FormState>();
  final _edtUrl = TextEditingController();
  final _edtTitulo = TextEditingController();
  final _edtGenero = TextEditingController();
  final _edtDuracao = TextEditingController();
  final _edtDescricao = TextEditingController();
  final _edtAno = TextEditingController();
  final _filmesController = FilmesController();

  double _pontuacao = 0;
  String _faixaEtariaSelecionada = "Livre";
  final List<String> _faixasEtarias = ["Livre", "10", "12", "14", "16", "18"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Filme"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              _buildTextField(_edtUrl, "URL da Imagem", TextInputType.text),
              _buildTextField(_edtTitulo, "Título", TextInputType.text),
              _buildTextField(_edtGenero, "Gênero", TextInputType.text),
              _buildDropdownField(),
              _buildTextField(_edtDuracao, "Duração", TextInputType.text),
              _buildTextField(_edtDescricao, "Descrição", TextInputType.text, maxLines: 5),
              _buildStarRating(),
              _buildTextField(_edtAno, "Ano", TextInputType.number),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final valid = _key.currentState!.validate() ?? false;
          if (!valid) {
            return;
          }
            _filmesController.save(
              _edtUrl.text,
              _edtTitulo.text,
              _edtGenero.text,
              int.tryParse(_faixaEtariaSelecionada) ?? 0,
              _edtDuracao.text,
              _pontuacao.toInt(),
              _edtDescricao.text,
              int.tryParse(_edtAno.text) ?? 0,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Filme cadastrado com sucesso!")),
            );
            Navigator.pop(context);
          },
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, TextInputType keyboardType, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) return "Campo Obrigatório";
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: _faixaEtariaSelecionada,
        items: _faixasEtarias.map((faixa) => DropdownMenuItem(value: faixa, child: Text(faixa))).toList(),
        onChanged: (value) {
          setState(() {
            _faixaEtariaSelecionada = value!;
          });
        },
        decoration: const InputDecoration(labelText: "Faixa Etária"),
      ),
    );
  }

  Widget _buildStarRating() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Pontuação"),
          SmoothStarRating(
            rating: _pontuacao,
            size: 30,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
            allowHalfRating: true,
            onRatingChanged: (value) {
              setState(() {
                _pontuacao = value;
              });
            },
          )
        ],
      ),
    );
  }
}