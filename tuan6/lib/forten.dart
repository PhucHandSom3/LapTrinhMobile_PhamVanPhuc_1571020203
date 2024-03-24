import 'package:flutter/material.dart';

class MyInherWidget extends InheritedWidget {
  final int data;

  MyInherWidget({required this.data, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return (oldWidget as MyInherWidget).data != data;
  }

  static MyInherWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInherWidget>()!;
  }
}

void main() => runApp(MyInherWidget(data: 50, child: MyApp()));

class MyWidet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MyInherWidget.of(context)!.data;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Dữ liệu được truyền từ char: $data'),
        SizedBox(height: 30),
        MyChildWidget(),
      ],
    );
  }
}

class MyChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MyInherWidget.of(context)!.data;
    return Text('Dữ liệu từ lớp cao nhất: $data');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tuần 6'),
        ),
        body: MyWidet(),
      ),
    );
  }
}