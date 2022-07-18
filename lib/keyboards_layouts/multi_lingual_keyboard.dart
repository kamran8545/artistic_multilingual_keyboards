import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_lingual_keyboard/utils/languages_alphabets.dart';

import '../utils/keyboards_types.dart';

class MultiLingualKeyboard extends StatefulWidget {
  KeyboardsTypes currentKeyboardsType;
  KeyboardLanguages currentKeyboardLanguage;
  final TextEditingController textEditingController;
  final Color keyTextBackgroundColor;
  final Color keysBackgroundColor;
  final Color keyboardBackgroundColor;
  final List<BoxShadow> keysShadow;
  BorderRadius? keyBorderRadius;
  final TextStyle keyTextStyle;
  final KeyboardAction keyboardAction;
  MultiLingualKeyboard({
    Key? key,
    // this.keys:const [],
    required this.textEditingController,
    this.currentKeyboardsType: KeyboardsTypes.englishUpperCase,
    this.currentKeyboardLanguage = KeyboardLanguages.english,
    this.keyTextBackgroundColor :Colors.black,
    this.keysBackgroundColor:Colors.white,
    this.keyboardBackgroundColor = Colors.white70,
    this.keysShadow: const [/*BoxShadow(color: Colors.grey,spreadRadius: 0.5,blurRadius: 0.5)*/],
    this.keyBorderRadius,
    this.keyTextStyle : const TextStyle(color: Colors.black,fontSize: 15),
    this.keyboardAction:KeyboardAction.actionDone,
  }) : super(key: key);

  @override
  State<MultiLingualKeyboard> createState() => _MultiLingualKeyboardState();
}

class _MultiLingualKeyboardState extends State<MultiLingualKeyboard> {
  List<String> keys = [];

  @override
  void initState() {
    super.initState();
    setKeyboardKeys();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*.3,
      color: widget.keyboardBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      /// Checking if keys list is empty then don't show keyboard
      child: keys.isNotEmpty?
      /// Checking keyboard types whether its numeric or alphabetic
        widget.currentKeyboardsType == KeyboardsTypes.numericKeyboard?
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getKeyboardRow(list: keys.sublist(0,4),horizontalPadding: 10),
              _getKeyboardRow(list: keys.sublist(4,8),horizontalPadding: 10),
              _getNumericKeyboardThirdRow(),
              _getNumericKeyboardLastRow(),
            ],
          )
          :Column(
            children: [
              _getKeyboardRow(list: keys.sublist(0,10),horizontalPadding: 10),
              _getKeyboardRow(list: keys.sublist(10,19),horizontalPadding: 20),
              _getKeyboardThirdRow(),
              _getKeyboardLastRow(),
            ],
          ):

      const Center(child: Text("No alphabet found for keyboard")),
    );
  }

  void setKeyboardKeys(){
    print("000000000000000000000000000000 >>>>>>>>>>>>><<<<<<<<<<< setKeyboardsKeys");
    if(widget.currentKeyboardLanguage == KeyboardLanguages.english){
      if(widget.currentKeyboardsType == KeyboardsTypes.englishLowerCase){
        widget.currentKeyboardsType = KeyboardsTypes.englishUpperCase;
        keys = englishLowerCaseAlphabetsQWERTY;
      }else /*if(widget.currentKeyboardsType == KeyboardsTypes.englishUpperCase)*/{
        widget.currentKeyboardsType = KeyboardsTypes.englishLowerCase;
        keys = englishUpperCaseAlphabetsQWERTY;
      }
    }else if(widget.currentKeyboardLanguage == KeyboardLanguages.urdu){
      if(widget.currentKeyboardsType == KeyboardsTypes.urduKeyboard1){
        keys = urduAlphabets2;
        widget.currentKeyboardsType = KeyboardsTypes.urduKeyboard2;
      }else/* if(widget.currentKeyboardsType == KeyboardsTypes.urduKeyboard2)*/{
        keys = urduAlphabets1;
        widget.currentKeyboardsType = KeyboardsTypes.urduKeyboard1;
      }
    }/*else if(widget.currentKeyboardLanguage == KeyboardLanguages.numeric){
      keys = numericKeyboardAlphabet;
      widget.currentKeyboardsType = KeyboardsTypes.numericKeyboard;
      print("000000000000000000000000000000 >>>>>>>>>>>>><<<<<<<<<<< setKeyboardsKeys else1");
    }*/
  }

  Widget _getKeyboardRow({required List<String> list,required double horizontalPadding}){
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Row(
          children: [
            for(String keyT in list)
              _getKey(keyText: keyT),
          ],
        ),
      ),
    );
  }

  Widget _getKeyboardThirdRow(){
    List list = keys.sublist(19,keys.length);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            _getKey(keyText: "",keyType: KeyTypes.changeKeyboardKey,buttonFlex: 3),
            for(String keyT in list)
              _getKey(keyText: keyT,buttonFlex: 2),
            _getKey(keyText: "",keyType: KeyTypes.backSpace,buttonFlex: 3),
          ],
        ),
      ),
    );
  }

  Widget _getKeyboardLastRow(){
    List<String> keyboardLastRow = ["123","Languages","Space"];
    if(widget.keyboardAction == KeyboardAction.actionDone){
      keyboardLastRow.add("Done");
    }else if(widget.keyboardAction == KeyboardAction.actionNewLine){
      keyboardLastRow.add("New Line");
    }else if(widget.keyboardAction == KeyboardAction.actionNext){
      keyboardLastRow.add("Next");
    }
    return Expanded(
      child: Row(
        children: [
          _getKey(keyText: keyboardLastRow[0],buttonFlex: 2,keyType: KeyTypes.numericKeyboard),
          _getKey(keyText: keyboardLastRow[1],buttonFlex: 2,keyType: KeyTypes.changeLanguageKey),
          _getKey(keyText: keyboardLastRow[2],buttonFlex: 7,keyType: KeyTypes.spaceKey),
          _getKey(keyText: keyboardLastRow[3],buttonFlex: 2,
            keyType: widget.keyboardAction == KeyboardAction.actionNext?KeyTypes.nextKey:
            widget.keyboardAction == KeyboardAction.actionNewLine?KeyTypes.newLineKey:
            KeyTypes.doneKey,
          ),
        ],
      ),
    );
  }

  Widget _getNumericKeyboardThirdRow(){
    List<String> keyboardLastRow = keys.sublist(8,11);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            for(var x in keyboardLastRow)
              _getKey(keyText: x,buttonFlex: 2,),
            _getKey(keyText: "",keyType: KeyTypes.backSpace,buttonFlex: 2,),
          ],
        ),
      ),
    );
  }

  Widget _getNumericKeyboardLastRow(){
    List<String> keyboardLastRow = keys.sublist(11);
    if(widget.keyboardAction == KeyboardAction.actionDone){
      keyboardLastRow.add("Done");
    }else if(widget.keyboardAction == KeyboardAction.actionNext){
      keyboardLastRow.add("Next");
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            _getKey(keyText: "123",keyType: KeyTypes.numericKeyboard,buttonFlex: 2,),
            for(var x in keyboardLastRow)
              _getKey(keyText: x,buttonFlex: 2,),
          ],
        ),
      ),
    );
  }

  Widget _getKey({required String keyText,KeyTypes keyType = KeyTypes.textKey, int buttonFlex = 1}){
    return Expanded(
      flex: buttonFlex,
      child: Container(
        width: double.maxFinite,
        // padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5,),
        // decoration: BoxDecoration(
        //   borderRadius: keyBorderRadius ?? BorderRadius.circular(5),
        //   color: keysBackgroundColor,
        //   boxShadow: keysShadow
        // ),
        child: ElevatedButton(
          child:(keyType == KeyTypes.textKey || keyType == KeyTypes.spaceKey || keyType == KeyTypes.numericKeyboard)?Text(
            keyText,
            textAlign: TextAlign.center,
            style: widget.keyTextStyle,
          ):Icon(
              keyType == KeyTypes.nextKey?Icons.arrow_forward:
              keyType == KeyTypes.newLineKey?Icons.subdirectory_arrow_left_rounded:
              keyType == KeyTypes.changeKeyboardKey?CupertinoIcons.arrow_up_circle:
              keyType == KeyTypes.changeLanguageKey?CupertinoIcons.globe:
              keyType == KeyTypes.backSpace?CupertinoIcons.delete_left:
              Icons.done,
            size: 23,
            color: Colors.black,
          ),
          onPressed: (keyType == KeyTypes.textKey && keyText.isEmpty)?null:(){
            _onKeyPressed(keyText: keyText, keyType: keyType);
          },
          style: ElevatedButton.styleFrom(
              elevation: 0,
              // shadowColor: Colors.white,
              primary: Colors.green,//widget.keysBackgroundColor,
              maximumSize: Size.infinite,
              // minimumSize: Size.zero, // Set this
              padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 12),
              // tapTargetSize: MaterialTapTargetSize.padded// and this
          ),
        ),
      ),
    );
  }

  void _onKeyPressed({required String keyText,required KeyTypes keyType,}){

    if(keyType == KeyTypes.textKey || keyType == KeyTypes.spaceKey){
      if(KeyTypes.spaceKey == keyType){
        keyText = " ";
      }
      _onTextChanged(changedText: keyText);
    }else{
      _onIconKeyPressed(keyType: keyType);
    }
  }

  void _onTextChanged({required String changedText}){
    String currentText = widget.textEditingController.text;
    int cursorPosition = widget.textEditingController.selection.extentOffset;
    int cursorStartPosition = widget.textEditingController.selection.baseOffset;
    if (cursorStartPosition >= 0 && cursorStartPosition != cursorPosition) {
      currentText = currentText.replaceRange(cursorStartPosition, cursorPosition, "");
      cursorPosition = cursorStartPosition;
      if (cursorPosition < 0) {
        cursorPosition = 0;
      }
    }
    String prefix = "";
    if (cursorPosition > 0) {
      prefix = currentText.substring(0, cursorPosition);
    }
    if (cursorPosition < 0) {
      cursorPosition = 0;
    }
    String suffix = currentText.substring(cursorPosition);
    String completeText = prefix + changedText + suffix;
    widget.textEditingController.text = completeText;

    if(currentText.length != widget.textEditingController.text.length){
      cursorPosition++;
    }
    if(cursorPosition > completeText.length){
      cursorPosition = completeText.length;
    }
    widget.textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: cursorPosition));
  }

  void _onIconKeyPressed({required KeyTypes keyType}){
    print("0000000000000000>>>>>>>>>>>>>>>><<<<<<<<<<<<< 11 ${keyType}");
    if(keyType == KeyTypes.backSpace){
      _onBackSpacePressed();
    }else if(keyType == KeyTypes.changeKeyboardKey){
      /// Switch between keyboards of same language
      setState(() {
        setKeyboardKeys();
      });
      // _changeKeyboardOfSameLanguage();
    }else if(keyType == KeyTypes.changeLanguageKey){
      /// Switch Keyboard Language
      _onKeyboardLanguageChange();
    }else if(keyType == KeyTypes.numericKeyboard){
      /// Change Keyboard to numeric here
      setState(() {
        if(widget.currentKeyboardsType == KeyboardsTypes.numericKeyboard){
          keys = englishUpperCaseAlphabetsQWERTY;
          widget.currentKeyboardsType = KeyboardsTypes.englishUpperCase;
        }else{
          keys = numericKeyboardAlphabet;
          widget.currentKeyboardsType = KeyboardsTypes.numericKeyboard;
        }
      });
    }else if(keyType == KeyTypes.newLineKey){
      _onNewLineKeyPressed();
    }
  }

  void _onBackSpacePressed(){
    String currentString = widget.textEditingController.text;
    int cursorPosition = widget.textEditingController.selection.extentOffset;
    if(currentString.length > 0){
      int cursorStartPosition = widget.textEditingController.selection.baseOffset;
      if(cursorStartPosition >= 0 && cursorStartPosition != cursorPosition){
        currentString = currentString.replaceRange(cursorStartPosition, cursorPosition,"");
        cursorPosition = cursorStartPosition;
        if(cursorPosition < 0){
          cursorPosition = 0;
        }
        widget.textEditingController.text = currentString;
        TextSelection textSelection = TextSelection.fromPosition(TextPosition(offset: cursorPosition));
        widget.textEditingController.selection = textSelection;
      }else {
        String prefix  = "";
        if(cursorPosition > 1){
          prefix  = currentString.substring(0,cursorPosition-1);
        }
        if(cursorPosition < 0){
          cursorPosition = 0;
        }
        String suffix = currentString.substring(cursorPosition);
        widget.textEditingController.text = prefix+suffix;
        TextSelection textSelection = TextSelection.fromPosition(TextPosition(offset: cursorPosition-1));
        widget.textEditingController.selection = textSelection;
      }
    }
  }

  void _onNewLineKeyPressed(){
    String currentString = widget.textEditingController.text;
    int cursorPosition = widget.textEditingController.selection.extentOffset;
    String prefix  = "";
    if(cursorPosition > 0){
      prefix  = currentString.substring(0,cursorPosition);
    }
    if(cursorPosition < 0){
      cursorPosition = 0;
    }
    String suffix = currentString.substring(cursorPosition);
    widget.textEditingController.text = prefix+"\n"+suffix;
    TextSelection textSelection = TextSelection.fromPosition(TextPosition(offset: cursorPosition+1));
    widget.textEditingController.selection = textSelection;
  }

  /*void _changeKeyboardOfSameLanguage(){
    setState(() {
      if(widget.currentKeyboardsType == KeyboardsTypes.englishUpperCase){
        widget.currentKeyboardsType = KeyboardsTypes.englishLowerCase;
      }else if(widget.currentKeyboardsType == KeyboardsTypes.englishLowerCase){
        widget.currentKeyboardsType = KeyboardsTypes.englishUpperCase;
      }else if(widget.currentKeyboardsType == KeyboardsTypes.englishLowerCase){
        widget.currentKeyboardsType = KeyboardsTypes.englishUpperCase;
      }else if(widget.currentKeyboardsType == KeyboardsTypes.englishLowerCase){
        widget.currentKeyboardsType = KeyboardsTypes.englishUpperCase;
      }
    });
  }*/

  void _onKeyboardLanguageChange(){
    List languagesList = KeyboardLanguages.values;
    int updatedLanguageIndex = languagesList.indexOf(widget.currentKeyboardLanguage)+1;
    setState(() {
      if(updatedLanguageIndex >= languagesList.length){
        widget.currentKeyboardLanguage = languagesList[0];
      }else{
        widget.currentKeyboardLanguage = languagesList[updatedLanguageIndex];
      }
      setKeyboardKeys();
    });
  }
}
