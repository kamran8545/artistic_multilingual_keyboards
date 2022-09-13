import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/types.dart';
import '../utils/languages_alphabets.dart';

/// keyboard Widget
class KeyboardLayouts extends StatefulWidget {
  /// Current keyboard type
  late KeyboardsTypes currentKeyboardsType;
  /// Current keyboard Language
  KeyboardLanguages currentKeyboardLanguage;
  /// Enable and Disable Language Button
  final bool enableLanguageButton;
  /// Text Editing Controller of TextField
  final TextEditingController textEditingController;
  /// Focus Node for TextField
  final FocusNode focusNode;
  /// Indicator to show Keyboard Status
  bool isKeyboardOpen;
  /// Keys background color
  final Color keysBackgroundColor;
  /// Keyboard background color
  final Color keyboardBackgroundColor;
  /// Key elevation
  final double keyElevation;
  /// Key shadow color
  final Color keyShadowColor;
  /// Key border radius
  BorderRadius? keyBorderRadius;
  /// Key Text Style
  final TextStyle keyTextStyle;
  /// Keyboard Action
  final KeyboardAction keyboardAction;
  /// Keyboard Action Done Event
  Function? keyboardActionDoneEvent;
  /// Keyboard Action Next Event
  Function? keyboardActionNextEvent;
  KeyboardLayouts({
    Key? key,
    required this.textEditingController,
    required this.focusNode,
    required this.isKeyboardOpen,
    this.currentKeyboardLanguage = KeyboardLanguages.english,
    this.enableLanguageButton =false,
    this.keysBackgroundColor =Colors.white,
    this.keyboardBackgroundColor = Colors.white70,
    this.keyElevation =0,
    this.keyShadowColor =Colors.black,
    this.keyBorderRadius,
    this.keyTextStyle  = const TextStyle(color: Colors.black,fontSize: 15),
    this.keyboardAction =KeyboardAction.actionDone,
    this.keyboardActionDoneEvent,
    this.keyboardActionNextEvent,
  }) : super(key: key){
    /// Setting Keyboard type according to current language
    if(currentKeyboardLanguage == KeyboardLanguages.english){
      currentKeyboardsType = KeyboardsTypes.englishLowerCase;
    }else if(currentKeyboardLanguage == KeyboardLanguages.urdu){
      currentKeyboardsType = KeyboardsTypes.urduKeyboard2;
    }else if(currentKeyboardLanguage == KeyboardLanguages.sindhi){
      currentKeyboardsType = KeyboardsTypes.sindhiKeyboard2;
    }else if(currentKeyboardLanguage == KeyboardLanguages.symbolic){
      currentKeyboardsType = KeyboardsTypes.symbolic2;
    }
  }

  @override
  State<KeyboardLayouts> createState() => _KeyboardLayoutsState();
}

class _KeyboardLayoutsState extends State<KeyboardLayouts> {
  List<String> keys = [];
  KeyboardsTypes? previousKeyboardType;
  KeyboardLanguages? previousKeyboardLanguages ;

  @override
  void didUpdateWidget(KeyboardLayouts oldWidget) {
    super.didUpdateWidget(oldWidget);
    previousKeyboardType = null;
    previousKeyboardLanguages = null;
    setKeyboardKeys();
  }

  @override
  void initState() {
    super.initState();
    setKeyboardKeys(inverseKeys: false);
  }

  @override
  Widget build(BuildContext context) {
    /// Keyboard Design
    return widget.isKeyboardOpen?WillPopScope(
      onWillPop: ()async{
        if(widget.isKeyboardOpen){
          setState(() {
            widget.isKeyboardOpen = false;
            if(widget.focusNode.hasFocus){
              widget.focusNode.unfocus();
            }
          });
          return false;
        }
        return true;
      },
      child: Container(
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
      ),
    ):const SizedBox(height: 0,width: 0,);
  }

  /// Setting Keyboard Keys according to selected language
  void setKeyboardKeys({bool inverseKeys = true}){
    if(widget.currentKeyboardLanguage == KeyboardLanguages.english){
      if(widget.currentKeyboardsType == KeyboardsTypes.englishLowerCase){
        widget.currentKeyboardsType = inverseKeys?KeyboardsTypes.englishUpperCase:KeyboardsTypes.englishLowerCase;
        keys = inverseKeys?englishLowerCaseAlphabetsQWERTY:englishUpperCaseAlphabetsQWERTY;
      }else {
        widget.currentKeyboardsType = inverseKeys?KeyboardsTypes.englishLowerCase:KeyboardsTypes.englishUpperCase;
        keys = inverseKeys?englishUpperCaseAlphabetsQWERTY:englishLowerCaseAlphabetsQWERTY;
      }
    }else if(widget.currentKeyboardLanguage == KeyboardLanguages.urdu){
      if(widget.currentKeyboardsType == KeyboardsTypes.urduKeyboard1){
        keys = inverseKeys?urduAlphabets2:urduAlphabets1;
        widget.currentKeyboardsType = inverseKeys?KeyboardsTypes.urduKeyboard2:KeyboardsTypes.urduKeyboard1;
      }else{
        keys = inverseKeys?urduAlphabets1:urduAlphabets2;
        widget.currentKeyboardsType = inverseKeys?KeyboardsTypes.urduKeyboard1:KeyboardsTypes.urduKeyboard2;
      }
    }else if(widget.currentKeyboardLanguage == KeyboardLanguages.sindhi){
      if(widget.currentKeyboardsType == KeyboardsTypes.sindhiKeyboard1){
        keys = inverseKeys?sindhiAlphabets2:sindhiAlphabets1;
        widget.currentKeyboardsType = inverseKeys?KeyboardsTypes.sindhiKeyboard2:KeyboardsTypes.sindhiKeyboard1;
      }else{
        keys = inverseKeys?sindhiAlphabets1:sindhiAlphabets2;
        widget.currentKeyboardsType = inverseKeys?KeyboardsTypes.sindhiKeyboard1:KeyboardsTypes.sindhiKeyboard2;
      }
    }else if(widget.currentKeyboardLanguage == KeyboardLanguages.symbolic){
      if(widget.currentKeyboardsType == KeyboardsTypes.symbolic1){
        keys = symbolickeyboard2;
        widget.currentKeyboardsType = KeyboardsTypes.symbolic2;
      }else{
        keys = symbolickeyboard1;
        widget.currentKeyboardsType = KeyboardsTypes.symbolic1;
      }
    }
  }

  /// Returns Keyboards Row
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

  /// Returns 3rd Row of Keyboards
  Widget _getKeyboardThirdRow(){
    List list = keys.sublist(19,keys.length);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            _getKey(keyText: _getSecondaryKeyboardKeyText(),
                keyType: /*(previousKeyboardType != null)?KeyTypes.symbolic1:*/KeyTypes.changeKeyboardKey,buttonFlex: 3),
            for(String keyT in list)
              _getKey(keyText: keyT,buttonFlex: 2),
            _getKey(keyText: "",keyType: KeyTypes.backSpace,buttonFlex: 3),
          ],
        ),
      ),
    );
  }

  /// Returns Last Row of All Keyboards
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
          (widget.enableLanguageButton)?_getKey(keyText: keyboardLastRow[1],buttonFlex: 2,keyType: KeyTypes.changeLanguageKey)
              :const SizedBox(height: 0,),
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

  /// Returns 3rd Row of Numeric Keyboards
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

  /// Returns Last Row of Numeric Keyboards
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

  /// Returns Single key of all alphabets
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
          child:(keyType == KeyTypes.textKey || keyType == KeyTypes.spaceKey || keyType == KeyTypes.numericKeyboard ||
              (keyText.isNotEmpty && keyType == KeyTypes.changeKeyboardKey && widget.currentKeyboardLanguage != KeyboardLanguages.english))?
          Text(
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
            size: 22,
            color: widget.keyTextStyle.color,
          ),
          onPressed: (keyType == KeyTypes.textKey && keyText.isEmpty)?null:(){
            _onKeyPressed(keyText: keyText, keyType: keyType);
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed) && widget.keyTextStyle.color != null) {
                    return widget.keyTextStyle.color!.withAlpha(30);
                  }
                  return null;
                }),
            backgroundColor:MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return widget.keysBackgroundColor;
                }),
            shape:  MaterialStateProperty.resolveWith<OutlinedBorder>(
                    (Set<MaterialState> states) {
                  return RoundedRectangleBorder(borderRadius: widget.keyBorderRadius??BorderRadius.circular(0));
                }),
              elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                    return widget.keyElevation;
                  }),
              shadowColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return widget.keyShadowColor;
                    }),
              // primary: widget.keysBackgroundColor,
              maximumSize: MaterialStateProperty.resolveWith<Size>(
                      (Set<MaterialState> states) {
                    return Size.infinite;
                  }),
              // minimumSize: Size.zero, // Set this
              padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                      (Set<MaterialState> states) {
                    return const EdgeInsets.symmetric(horizontal: 0,vertical: 12);
                  }),
              // tapTargetSize: MaterialTapTargetSize.padded// and this
          ),
        ),
      ),
    );
  }

  /// Returns Key Text for secondary keyboard
  String _getSecondaryKeyboardKeyText(){
    if(widget.currentKeyboardLanguage == KeyboardLanguages.urdu && widget.currentKeyboardsType == KeyboardsTypes.urduKeyboard1){
      return "ژ ڑ ذ";
    }else if(widget.currentKeyboardLanguage == KeyboardLanguages.urdu && widget.currentKeyboardsType == KeyboardsTypes.urduKeyboard2){
      return "ا ب پ";
    }else if(widget.currentKeyboardLanguage == KeyboardLanguages.sindhi && widget.currentKeyboardsType == KeyboardsTypes.sindhiKeyboard1){
      return "ڙ ڏ ڊ";
    }else if(widget.currentKeyboardLanguage == KeyboardLanguages.sindhi && widget.currentKeyboardsType == KeyboardsTypes.sindhiKeyboard2){
      return "ا ب پ";
    }else if(widget.currentKeyboardLanguage == KeyboardLanguages.symbolic && widget.currentKeyboardsType == KeyboardsTypes.symbolic1){
      return "+/-";
    }else if(widget.currentKeyboardLanguage == KeyboardLanguages.symbolic && widget.currentKeyboardsType == KeyboardsTypes.symbolic2){
      return "!@#";
    }
    return "";
  }

  /// Listener handles key pressed event
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

  /// Listener handles text change event
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
        TextPosition(offset: cursorPosition,));
  }

  /// Listener handles all key events
  void _onIconKeyPressed({required KeyTypes keyType}){
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
        if(previousKeyboardType == null /*|| previousKeyboardType != KeyboardsTypes.symbolic1*/){
          previousKeyboardType = widget.currentKeyboardsType;
          // keys = symbolickeyboard1;
          previousKeyboardLanguages = widget.currentKeyboardLanguage;
          widget.currentKeyboardsType = KeyboardsTypes.symbolic2;
          widget.currentKeyboardLanguage = KeyboardLanguages.symbolic;
        }else{
          widget.currentKeyboardsType = previousKeyboardType!;
          previousKeyboardType = null;
          // keys = englishUpperCaseAlphabetsQWERTY;
          widget.currentKeyboardLanguage = previousKeyboardLanguages!;
          previousKeyboardLanguages = null;
        }
        setKeyboardKeys(inverseKeys: false);
      });
    }else if(keyType == KeyTypes.newLineKey){
      _onNewLineKeyPressed();
    }else if(keyType == KeyTypes.doneKey){
      if(widget.keyboardActionDoneEvent != null){
        widget.keyboardActionDoneEvent!();
      }
      if(widget.focusNode.hasFocus){
        widget.focusNode.unfocus();
      }
    }else if(keyType == KeyTypes.nextKey){
      if(widget.keyboardActionNextEvent != null){
        widget.keyboardActionNextEvent!();
      }
    }
  }

  /// Handles back pressed from keyboard
  void _onBackSpacePressed(){
    String currentString = widget.textEditingController.text;
    int cursorPosition = widget.textEditingController.selection.extentOffset;
    if(currentString.isNotEmpty){
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

  /// Handles new line event
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

  /// Handles Keyboard language change.
  void _onKeyboardLanguageChange(){
    if(widget.currentKeyboardLanguage == KeyboardLanguages.symbolic
        && previousKeyboardLanguages != null && previousKeyboardType != null){
      widget.currentKeyboardsType = previousKeyboardType!;
      widget.currentKeyboardLanguage = previousKeyboardLanguages!;
      previousKeyboardLanguages = null;
      previousKeyboardType = null;
    }

    List languagesList = List.from(KeyboardLanguages.values);
    languagesList.remove(KeyboardLanguages.symbolic);
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
