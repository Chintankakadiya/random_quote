import 'package:sqflite/sqflite.dart';

class QuoteDatabase {
  late Database _database;

  QuoteDatabase() {
    open();
  }

  Future<void> open() async {
    _database =
        await openDatabase((await getDatabasesPath() + "qutoe_database.db"),
            onCreate: (db, version) {
      return db
          .execute("CREATE TABLE quotes(id INTEGER PRIMARY KEY,text TEXT)");
    }, version: 1);
  }

  Future<void> insertQuotes(String quote) async {
    await _database.insert('quotes', {'text': quote});
  }

  Future<List<String>> getQuoteHistory() async {
    final List<Map<String, dynamic>> maps = await _database.query('quotes');
    return List.generate(maps.length, (i) {
      return maps[i]['text'] as String;
    });
  }
}
