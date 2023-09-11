import 'package:flutter/material.dart';
import 'package:random_quote/dbHelper.dart';

import 'home_page.dart';

void main() {
  final QuoteDatabase quoteDatabase = QuoteDatabase();
  runApp(MyApp(
    quoteDatabase: quoteDatabase,
  ));
}

class MyApp extends StatelessWidget {
  final QuoteDatabase quoteDatabase;
  MyApp({required this.quoteDatabase});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Mood Quotes"),
        ),
        drawer: Drawer(
          child: FutureBuilder<List<String>>(
            future: quoteDatabase.getQuoteHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final history = snapshot.data;
                return ListView.builder(
                  itemCount: history?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(history![index]),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        body: MoodQuoteScreen(quoteDatabase: quoteDatabase),
      ),
    );
  }
}
