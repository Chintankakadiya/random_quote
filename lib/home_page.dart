import 'package:flutter/material.dart';
import 'package:random_quote/dbHelper.dart';
import 'package:timer_builder/timer_builder.dart';

class MoodQuoteScreen extends StatefulWidget {
  final QuoteDatabase quoteDatabase;
  MoodQuoteScreen({required this.quoteDatabase});

  @override
  State<MoodQuoteScreen> createState() => _MoodQuoteScreenState();
}

class _MoodQuoteScreenState extends State<MoodQuoteScreen> {
  String selectedMood = "Happy";
  String currentQuote = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRandomQuote();
  }

  Future<void> _loadRandomQuote() async {
    selectedMood;
    final randomQuote = 'This is a random quote.';
    setState(() {
      currentQuote = randomQuote;
    });
    widget.quoteDatabase.insertQuotes(randomQuote);
  }

  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'Mood:$selectedMood',
        style: TextStyle(fontSize: 20),
      ),
      TimerBuilder.periodic(Duration(seconds: 10), builder: (context) {
        _loadRandomQuote();
        return Text(
          "Quote:$currentQuote",
          style: TextStyle(fontSize: 20),
        );
      }),
      DropdownButton<String>(
        value: selectedMood,
        onChanged: (value) {
          setState(() {
            selectedMood = value!;
            _loadRandomQuote();
          });
        },
        items: ['Happy', 'Sad', 'Angry', 'Excited']
            .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ),
            )
            .toList(),
      )
    ]);
  }
}
