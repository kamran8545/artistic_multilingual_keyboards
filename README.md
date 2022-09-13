# Artistic Multilingual Keyboards

A fully customizable Flutter package which allows you to add multi lingual keyboard in your apps. 
For now you can use English, Urdu and Sindhi, numeric and some special characters keyboards.
You can customize keyboards as you want them. 


## Features

### Example
<img src="https://user-images.githubusercontent.com/28790321/189832513-7a6d2a14-f12b-4152-8bf1-6a3acf6b61f1.png" width="280" height="500">

[comment]: <> (![Alt text]&#40;./screen_recording/screen_recording.gif =200x300&#41;)

### English Keyboards 

<span>
<img src="https://user-images.githubusercontent.com/28790321/189832672-97c38cb9-0fb4-438f-a8bb-edb3b05f0360.jpeg" width="280" height="500"> 
<img src="https://user-images.githubusercontent.com/28790321/189832752-a7adbae5-dac0-4f1e-8bf3-7a2a5ca4459d.jpeg" width="280" height="500">
</span>



### Urdu Keyboards

<span>
<img src="https://user-images.githubusercontent.com/28790321/189832843-2a11d11d-c2ca-4210-a34e-27a07ee07ab2.jpeg" width="280" height="500"> 
<img src="https://user-images.githubusercontent.com/28790321/189832899-10ae156a-df07-45a7-8035-fca807d1a2c2.jpeg" width="280" height="500"></span>


### Sindhi Keyboards

<span><img src="https://user-images.githubusercontent.com/28790321/189833029-1caa144a-918c-4970-a7e7-431dfc595bec.jpeg" width="280" height="500">
<img src="https://user-images.githubusercontent.com/28790321/189833107-9957c04b-749e-40f0-8aea-8fe8e0c0e3d8.jpeg" width="280" height="500"></span>


### Numeric & Symbolic Keyboards

<span>
<img src="https://user-images.githubusercontent.com/28790321/189833668-8d70b1d5-27b3-4287-8197-350346dcee07.jpeg" width="280" height="500"> 
<img src="https://user-images.githubusercontent.com/28790321/189833742-bb09c1d8-d612-41ff-8fb4-807bb267f111.jpeg" width="280" height="500"></span>


### Keyboard Customized Designs

<span>
<img src="https://user-images.githubusercontent.com/28790321/189833822-1d5b121f-623b-4283-ae85-e81d27e803ee.jpeg" width="280" height="500"> 
<img src="https://user-images.githubusercontent.com/28790321/189833832-35fc8ff4-779a-47e0-a6c1-2cc6265afac4.jpeg" width="280" height="500"> 
<img src="https://user-images.githubusercontent.com/28790321/189833856-fecfee99-4e19-4689-bf4e-725653bbbf55.jpeg" width="280" height="500"> 
<img src="https://user-images.githubusercontent.com/28790321/189833858-e5dc5810-543c-49c2-bfcc-4b06c007e1e3.jpeg" width="280" height="500"> 
<img src="https://user-images.githubusercontent.com/28790321/189833849-2b442097-1cca-4b15-9cf0-05e9166467e3.jpeg" width="280" height="500"> 
<img src="https://user-images.githubusercontent.com/28790321/189833871-35aa9c6a-f976-4b25-9229-e73ece3441c4.jpeg" width="280" height="500"> 
<img src="https://user-images.githubusercontent.com/28790321/189833865-403fd7a3-8700-4c6b-8e95-9109956dea3a.jpeg" width="280" height="500"></span> 



## Installation

### Dependency

Add the package as a dependency in your pubspec.yaml file.

```yaml
dependencies:
  artistic_multilingual_keyboards: "^1.0.0"
```

Or Run the following command.

```shell
$ flutter pub add artistic_multilingual_keyboards
```

### Import
Import following package in your code file.
```dart
import 'package:artistic_multilingual_keyboards/keyboards_layouts/keyboard_layouts.dart';
```

## Usage

Check complete example code from the "Example" Folder. 

```dart
  KeyboardLayouts(
    textEditingController: TextEditingController(),
    textEditingController: TextEditingController(),
    focusNode: FocusNode(),
    isKeyboardOpen: true,
    enableLanguageButton: false,
    keyElevation: 12,
    keyShadowColor: Colors.black,
    keyBorderRadius: BorderRadius.circular(10),
    keyboardAction: KeyboardAction.actionNext,
    currentKeyboardLanguage: KeyboardLanguages.english,  
  );
```






## Contribution

You can contribute by:
1. Use this package test and report any issues/bug found.
2. Contribute to package by adding more features.
3. Fill the form and give us your [suggestion or Feedback](https://docs.google.com/forms/d/e/1FAIpQLSdRY0yvBApd4QlUxTwEL4nycc8o-aNP70w9hPFrTgXzaeSH2w/viewform).


## Developer

[Kamran Khan](https://github.com/kamran8545)

