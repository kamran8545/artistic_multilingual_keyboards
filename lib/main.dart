import 'package:flutter/material.dart';
import 'package:multi_lingual_keyboard/keyboards_layouts/multi_lingual_keyboard.dart';
import 'package:multi_lingual_keyboard/utils/keyboards_types.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  MyWidget({Key? key}) : super(key: key);
  TextEditingController textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 200,),
          TextField(
            controller: textEditingController,
            readOnly: true,
            showCursor: true,
            textAlign: TextAlign.start,
            // scrollController: _scrollController,
          ),
          MultiLingualKeyboard(
            textEditingController: textEditingController,
            keyboardBackgroundColor: Colors.green,
            keysBackgroundColor: Colors.red,
            keyTextStyle: const TextStyle(color: Colors.white),
            keyElevation: 15,
            keyShadowColor: Colors.black,
            keyBorderRadius: BorderRadius.circular(10),
            keyboardAction: KeyboardAction.actionNewLine,
            currentKeyboardLanguage: KeyboardLanguages.english,
          )
          // TextField(),
        ],
      ),
    );
  }
}




