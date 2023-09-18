import 'package:flutter/material.dart';
import 'cards.dart';
import 'providers/DB.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Wooree Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  final List result = [];
  final String question = '';

  final List<String> cardTitles = [
    'Card 1',
    'Card 2',
    'Card 3',
    'Card 4',
    'Card 5',
  ];

  final List<Color> cardColors = [
    Color(0xFFD6A4A4), // Pastel Pink
    Color(0xFFA4D6C3), // Pastel Green
    Color(0xFFF3E5AB), // Pastel Yellow
    Color(0xFFA4C0D6), // Pastel Blue
    Color(0xFFD6A4CD), // Pastel Purple
  ];

  void handleCardClick(BuildContext context, int index) async {
    // print('Clicked card: ${cardTitles[index]}');
    await getDatabase(cardTitles[index], result, question).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Cards(cardTitle: cardTitles[index], result: result, question: question),
        ),
      );
    });


    // Add your custom logic for the card click event
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wooree Project'),
      ),
      body: ListView.builder(
        itemCount: cardTitles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => handleCardClick(context, index),
              child: Card(
                color: cardColors[index % cardColors.length],
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      cardTitles[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}