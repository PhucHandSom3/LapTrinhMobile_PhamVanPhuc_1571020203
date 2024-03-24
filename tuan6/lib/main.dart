import 'package:flutter/material.dart';

class MyInheritWidget extends InheritedWidget{
  final int data;
  const MyInheritWidget({required this.data, required Widget child}): super(child: child);
  //Ham update - kiem tra xem co can update khong
  @override
  bool updateShouldNotify(MyInheritWidget oldWidget) {
    return oldWidget.data != data;
  }
  //Phuong thuc lay du lieu tu context
  static MyInheritWidget? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<MyInheritWidget>();
  }
}

//dinh nghia widget can su dung MyInheritWidget
class MyWidget extends StatelessWidget{
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context){
    //Su dung inherit widget
    final data = MyInheritWidget.of(context)!.data;
    return Text('Du lieu tu Char: $data');
  }
}

//Dinh nghia widget chua MyInheritWidget
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: MyInheritWidget(
            data: 40,
            child: MyWidget()
        )
    );
  }
}

void main(){
  runApp(MyApp());
}