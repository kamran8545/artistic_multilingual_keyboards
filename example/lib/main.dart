import 'package:artistic_multilingual_keyboards/keyboards_layouts/keyboard_layouts.dart';
import 'package:artistic_multilingual_keyboards/utils/types.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController englishTEController = TextEditingController();
  TextEditingController urduTEController = TextEditingController();
  TextEditingController sindhiTEController = TextEditingController();

  FocusNode engFocusNode = FocusNode();
  FocusNode urduFocusNode = FocusNode();
  FocusNode sindhiFocusNode = FocusNode();

  late TextEditingController currentKeyboardTEController;
  late FocusNode currentKeyboardFocusNode;
  KeyboardLanguages currentKeyboardLanguage = KeyboardLanguages.english;
  KeyboardAction currentKeyboardAction = KeyboardAction.actionNext;

  bool _isKeyboardOpen = false;

  @override
  void initState() {
    currentKeyboardTEController = englishTEController;
    currentKeyboardFocusNode = engFocusNode;

    engFocusNode.addListener(() {
      setState(() {
        if(engFocusNode.hasFocus){
          currentKeyboardFocusNode = engFocusNode;
          currentKeyboardAction = KeyboardAction.actionNext;
          currentKeyboardTEController = englishTEController;
          currentKeyboardLanguage = KeyboardLanguages.english;
          _isKeyboardOpen = true;
        }else{
          _isKeyboardOpen = false;
        }
      });
    });

    urduFocusNode.addListener(() {
      setState(() {
        if(urduFocusNode.hasFocus){
          currentKeyboardFocusNode = urduFocusNode;
          currentKeyboardAction = KeyboardAction.actionNext;
          currentKeyboardTEController = urduTEController;
          currentKeyboardLanguage = KeyboardLanguages.urdu;
          _isKeyboardOpen = true;
        }else{
          _isKeyboardOpen = false;
        }
      });
    });

    sindhiFocusNode.addListener(() {
      setState(() {
        if(sindhiFocusNode.hasFocus){
          currentKeyboardFocusNode = sindhiFocusNode;
          currentKeyboardAction = KeyboardAction.actionDone;
          currentKeyboardTEController = sindhiTEController;
          currentKeyboardLanguage = KeyboardLanguages.sindhi;
          _isKeyboardOpen = true;
        }else{
          _isKeyboardOpen = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100,),
              const Text("English"),
              TextField(
                controller: englishTEController,
                focusNode: engFocusNode,
                readOnly: true,
                showCursor: true,
                textAlign: TextAlign.start,
                // scrollController: _scrollController,
              ),
              const SizedBox(height: 100,),
              const Text("Urdu"),
              TextField(
                controller: urduTEController,
                focusNode: urduFocusNode,
                textDirection: TextDirection.ltr,
                readOnly: true,
                showCursor: true,
                textAlign: TextAlign.end,
                // scrollController: _scrollController,
              ),
              const SizedBox(height: 100,),
              const Text("Sindhi"),
              TextField(
                controller: sindhiTEController,
                focusNode: sindhiFocusNode,
                readOnly: true,
                showCursor: true,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: KeyboardLayouts(
        textEditingController: currentKeyboardTEController,
        focusNode: currentKeyboardFocusNode,
        isKeyboardOpen: _isKeyboardOpen,
        enableLanguageButton: false,
        // keyboardBackgroundColor: Colors.green,
        // keysBackgroundColor: Colors.red,
        // keyTextStyle: const TextStyle(color: Colors.white),
        // keyElevation: 10,
        keyShadowColor: Colors.black,
        keyBorderRadius: BorderRadius.circular(8),
        keyboardAction: currentKeyboardAction,
        currentKeyboardLanguage: currentKeyboardLanguage,
        keyboardActionNextEvent: (){
          if(engFocusNode.hasFocus){
            engFocusNode.unfocus();
            urduFocusNode.requestFocus();
          }else if(urduFocusNode.hasFocus){
            urduFocusNode.unfocus();
            sindhiFocusNode.requestFocus();
          }
        },
        keyboardActionDoneEvent: (){
          setState(() {
            _isKeyboardOpen = !_isKeyboardOpen;
          });
        },
      ),
    );
  }
}