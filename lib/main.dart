import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Align(alignment: Alignment.centerLeft, child: Text("Bridle")),
        ),
        body: Center(child: GamePage()),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title(this.letter, this.hitType, {super.key});
  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: switch (hitType) {
          HitType.hit => Colors.green,
          HitType.miss => Colors.grey,
          HitType.partial => Colors.yellow,
          _ => Colors.white,
        },
      ),
      child: Center(child: Text(letter)),
    );
  }
}

class GamePage extends StatefulWidget {
  GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (final guess in _game.guesses)
            Row(children: [for (final x in guess) Title(x.char, x.type)]),
          GuessInput(
            onSubmitGuess: (text) {
              setState(() {
                _game.guess(text);
              });
            },
          ),
        ],
      ),
    );
  }
}

class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
  final Function(String) onSubmitGuess;
  final FocusNode _focus = FocusNode();
  final TextEditingController _controller = TextEditingController();
  void Func() {
    onSubmitGuess(_controller.text.trim());
    _focus.requestFocus();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (text) {
                Func();
              },
              maxLength: 5,
              focusNode: _focus,
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_circle_up),
          onPressed: () {
            Func();
          },
        ),
      ],
    );
  }
}
