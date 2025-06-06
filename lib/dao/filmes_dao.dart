import 'package:flutter1/database_helper/database_helper.dart';
import 'package:flutter1/model/filmes.dart';
class FilmesDao{
  late DatabaseHelper dbHelper;

  FilmesDao(){
    dbHelper = DatabaseHelper();
  }


  Future<int?> save(Filmes filme) async {
    final db = await dbHelper.initDB();
    try{
      return await db.insert('filmes', filme.toMap());
    }catch(e){
      print(e);
      return null;
    }finally{
      db.close();
    }
  }

  Future<int?> delete(int id) async {
    final db = await dbHelper.initDB();
    try {
      return await db.delete(
        'filmes',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Erro ao deletar filme com id $id: $e');
      return null;
    } finally {
      db.close();
    }

  }
  Future<int?> update(Filmes filme) async {
    final db = await dbHelper.initDB();
    try {
      return await db.update(
        'filmes',
        filme.toMap(),
        where: 'id = ?',
        whereArgs: [filme.id],
      );
    } catch (e) {
      print('Erro ao atualizar filme com id ${filme.id}: $e');
      return null;
    } finally {
      db.close();
    }
  }

}