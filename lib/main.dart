import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const BasicPhrasesApp());
}

class BasicPhrasesApp extends StatelessWidget {
  const BasicPhrasesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> texts = const [
    'Bună',
    'Bună (franceză)',
    'Ce faci?',
    'Ce faci? (franceză)',
    'Omletă cu brânză',
    'Omletă cu brânză (franceză)',
    'Sunt fericit',
    'Sunt fericit (franceză)'
  ];

  List<String> texts_for_audio = const [
    'Bună',
    'Bonjour',
    'Ce faci?',
    'Que fais-tu?',
    'Omletă cu brânză',
    'Omelette au fromage',
    'Sunt fericit',
    'Je suis heureux'
  ];

  List<String> set_language = const [
    'ro',
    'fr'
  ];

  final FlutterTts tts = FlutterTts();
  bool playing = false;

  Future _speak(String text) async{
    var result = await tts.speak(text);
    if (result == 1) setState(() => playing = true);
  }

  Future _stop() async{
    var result = await tts.stop();
    if (result == 1) setState(() => playing = false);
  }

  Home() {
    tts.setSpeechRate(0.4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Basic Phrases'),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  if(playing){
                    _stop();
                  }
                  else {
                    TextEditingController controller = TextEditingController(text: texts_for_audio[index]);
                    tts.setLanguage(set_language[index%2]);
                    _speak(controller.text);
                  }
                },
                child: Text(
                  texts[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  elevation: 80,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
            );
          },
        ));
  }
}
