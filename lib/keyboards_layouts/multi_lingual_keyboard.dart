import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_lingual_keyboard/utils/keyboards_types.dart';
import 'package:multi_lingual_keyboard/utils/languages_alphabets.dart';

class MultiLingualKeyboard extends StatelessWidget {
  List<String> keys;
  final KeyboardsTypes keyboardsType;
  final Color keyTextBackgroundColor;
  final Color keysBackgroundColor;
  final Color keyboardBackgroundColor;
  final List<BoxShadow> keysShadow;
  BorderRadius? keyBorderRadius;
  final TextStyle keyTextStyle;
  MultiLingualKeyboard({
    Key? key,
    this.keys:const [],
    this.keyboardsType: KeyboardsTypes.englishLowerCase,
    this.keyTextBackgroundColor :Colors.black,
    this.keysBackgroundColor:Colors.white,
    this.keyboardBackgroundColor = Colors.white54,
    this.keysShadow: const [BoxShadow(color: Colors.grey,spreadRadius: 0.5,blurRadius: 0.5)],
    this.keyBorderRadius,
    this.keyTextStyle : const TextStyle(color: Colors.black,fontSize: 15)
  }) : super(key: key){
    if(keyboardsType == KeyboardsTypes.englishLowerCase){
      keys = englishLowerCaseAlphabetsQWERTY;
    }else if(keyboardsType == KeyboardsTypes.englishUpperCase){
      keys = englishUpperCaseAlphabetsQWERTY;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*.3,
      color: keyboardBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _getKeyboardRow(list: keys.sublist(0,10)),
          _getKeyboardRow(list: keys.sublist(10,19)),
          _getKeyboardRow(list: keys.sublist(19,keys.length)),
          _getKeyboardRow(list: ["123"," ","Enter"]),
        ],
      ),
    );
  }

  Widget _getKeyboardRow({required List<String> list}){
    return Expanded(
      child: Row(
        children: [
          for(String keyT in list)
            _getKey(keyText: keyT),
        ],
      ),
    );
  }
  
  
  Widget _getKey({required String keyText,KeyTypes keyType = KeyTypes.textKey}){
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: keyBorderRadius ?? BorderRadius.circular(5),
          color: keysBackgroundColor,
          boxShadow: keysShadow
        ),
        child: Text(
          keyText,
          textAlign: TextAlign.center,
          style: keyTextStyle,
        )
      ),
    );
  }
}
