import 'package:flutter/material.dart';

class Cards extends StatefulWidget {
  final String cardTitle;
  final List result;
  final String question;

  Cards({
    Key? key,
    required this.cardTitle,
    required this.result,
    required this.question,
  }) : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  final List<Color> cardColors = [
    Color(0xFFD6A4A4), // Pastel Pink
    Color(0xFFA4D6C3), // Pastel Green
    Color(0xFFF3E5AB), // Pastel Yellow
    Color(0xFFA4C0D6), // Pastel Blue
    Color(0xFFD6A4CD), // Pastel Purple
  ];

  bool isFlipped = false;
  int selectedCardIndex = -1;

  void handleCardClick(BuildContext context, int index) {
    setState(() {
      isFlipped = !isFlipped;
      selectedCardIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cardTitle),
      ),
      body: GridView.count(
        crossAxisCount: 3, // Number of cards in each row
        childAspectRatio: 2 / 3, // Set the desired aspect ratio here
        children: List.generate(widget.result.length, (index) {
          return Padding(
            padding: EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () => handleCardClick(context, index),
              // child: AnimatedSwitcher(
              //   duration: Duration(milliseconds: 500),
              //   transitionBuilder: (child, animation) {
              //     return RotationTransition(
              //       turns: animation,
              //       child: child,
              //     );
              //   },
                child: isFlipped && selectedCardIndex == index
                    ? Container(
                  key: ValueKey<int>(index),
                  child: Card(
                    color: cardColors[index % cardColors.length],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        widget.result[index],
                        textAlign: TextAlign.center, // Center-align the text
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
                    : Container(
                  key: ValueKey<int>(-index),
                  child: Card(
                    color: Colors.grey, // Back of the card color
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.flip,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                  ),
                ),
              ),
            // ),
          );
        }),
      ),
    );
  }
}
