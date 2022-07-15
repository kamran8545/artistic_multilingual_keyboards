import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_lingual_keyboard/utils/languages_alphabets.dart';

import '../utils/keyboards_types.dart';

class MultiLingualKeyboard extends StatefulWidget {
  List<String> keys = [];
  final TextEditingController textEditingController;
  KeyboardsTypes keyboardsType;
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
    this.keyboardsType: KeyboardsTypes.englishLowerCase,
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
  @override
  Widget build(BuildContext context) {
    setKeyboardKeys();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*.3,
      color: widget.keyboardBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _getKeyboardRow(list: widget.keys.sublist(0,10),horizontalPadding: 10),
          _getKeyboardRow(list: widget.keys.sublist(10,19),horizontalPadding: 20),
          _getKeyboardThirdRow(),
          _getKeyboardLastRow(),
        ],
      ),
    );
  }

  void setKeyboardKeys(){
    if(widget.keyboardsType == KeyboardsTypes.englishLowerCase){
      widget.keys = englishLowerCaseAlphabetsQWERTY;
    }else if(widget.keyboardsType == KeyboardsTypes.englishUpperCase){
      widget.keys = englishUpperCaseAlphabetsQWERTY;
    }
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
    List list = widget.keys.sublist(19,widget.keys.length);
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
    List<String> keyboardLastRow = ["123","Space"];
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
          _getKey(keyText: keyboardLastRow[1],buttonFlex: 6,keyType: KeyTypes.spaceKey),
          _getKey(keyText: keyboardLastRow[2],buttonFlex: 2,
            keyType: widget.keyboardAction == KeyboardAction.actionNext?KeyTypes.nextKey:
            widget.keyboardAction == KeyboardAction.actionNewLine?KeyTypes.newLineKey:
            KeyTypes.doneKey,
          ),
        ],
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
              keyType == KeyTypes.backSpace?CupertinoIcons.delete_left:
              Icons.done,
            size: 23,
            color: Colors.black,
          ),
          onPressed: (){
            _onKeyPressed(keyText: keyText, keyType: keyType);
          },
          style: ElevatedButton.styleFrom(
              elevation: 0,
              // shadowColor: Colors.white,
              primary: widget.keysBackgroundColor,
              maximumSize: Size.infinite,
              // minimumSize: Size.zero, // Set this
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 12),
              // tapTargetSize: MaterialTapTargetSize.padded// and this
          ),
        ),
      ),
    );
  }

  void _onKeyPressed({required String keyText,required KeyTypes keyType,}){
    if(KeyTypes.spaceKey == keyType){
      keyText = " ";
    }


    if(keyType == KeyTypes.textKey || keyType == KeyTypes.spaceKey){
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
      _changeKeyboardOfSameLanguage();
    }else if(keyType == KeyTypes.numericKeyboard){
      /// Change Keyboard to numeric here
    }else if(keyType == KeyTypes.newLineKey){
      _onNewLineKeyPressed();
    }/*else if(event == ICON_KEY_EVENTS.FIRST_SYMBOLIC_KEYBOARD){

    }else if(event == ICON_KEY_EVENTS.SECOND_SYMBOLIC_KEYBOARD){
      setState(() {
        widget.keyboardType = KEYBOARD_TYPES.SecondSymbolic;
      });
    }*/
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

  void _changeKeyboardOfSameLanguage(){
    setState(() {
      if(widget.keyboardsType == KeyboardsTypes.englishUpperCase){
        widget.keyboardsType = KeyboardsTypes.englishLowerCase;
      }else if(widget.keyboardsType == KeyboardsTypes.englishLowerCase){
        widget.keyboardsType = KeyboardsTypes.englishUpperCase;
      }
    });
  }
}
