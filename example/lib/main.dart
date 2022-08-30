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
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  FocusNode focusNode = FocusNode();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  late TextEditingController currentKeyboardTEController;
  late FocusNode currentKeyboardFocusNode;
  KeyboardLanguages currentKeyboardLanguage = KeyboardLanguages.english;
  KeyboardAction currentKeyboardAction = KeyboardAction.actionNext;

  bool _isKeyboardOpen = false;

  @override
  void initState() {
    currentKeyboardTEController = textEditingController;
    currentKeyboardFocusNode = focusNode;

    focusNode.addListener(() {
      setState(() {
        if(focusNode.hasFocus){
          currentKeyboardFocusNode = focusNode;
          currentKeyboardAction = KeyboardAction.actionNext;
          currentKeyboardTEController = textEditingController;
          currentKeyboardLanguage = KeyboardLanguages.english;
          _isKeyboardOpen = true;
        }else{
          _isKeyboardOpen = false;
        }
      });
    });

    focusNode1.addListener(() {
      setState(() {
        if(focusNode1.hasFocus){
          currentKeyboardFocusNode = focusNode1;
          currentKeyboardAction = KeyboardAction.actionNext;
          currentKeyboardTEController = textEditingController1;
          currentKeyboardLanguage = KeyboardLanguages.urdu;
          _isKeyboardOpen = true;
        }else{
          _isKeyboardOpen = false;
        }
      });
    });

    focusNode2.addListener(() {
      setState(() {
        if(focusNode2.hasFocus){
          currentKeyboardFocusNode = focusNode2;
          currentKeyboardAction = KeyboardAction.actionDone;
          currentKeyboardTEController = textEditingController2;
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
                controller: textEditingController,
                focusNode: focusNode,
                readOnly: true,
                showCursor: true,
                textAlign: TextAlign.start,
                // scrollController: _scrollController,
              ),
              const SizedBox(height: 100,),
              const Text("Urdu"),
              TextField(
                controller: textEditingController1,
                focusNode: focusNode1,
                textDirection: TextDirection.ltr,
                readOnly: true,
                showCursor: true,
                textAlign: TextAlign.end,
                // scrollController: _scrollController,
              ),
              const SizedBox(height: 100,),
              const Text("Sindhi"),
              TextField(
                controller: textEditingController2,
                focusNode: focusNode2,
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
        keyElevation: 12,
        keyShadowColor: Colors.black,
        keyBorderRadius: BorderRadius.circular(10),
        keyboardAction: currentKeyboardAction,
        currentKeyboardLanguage: currentKeyboardLanguage,
        keyboardActionNextEvent: (){
          if(focusNode.hasFocus){
            focusNode.unfocus();
            focusNode1.requestFocus();
          }else if(focusNode1.hasFocus){
            focusNode1.unfocus();
            focusNode2.requestFocus();
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