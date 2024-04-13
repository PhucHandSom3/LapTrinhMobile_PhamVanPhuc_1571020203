import 'dart:js';
import 'package:flutter/material.dart';
import 'cart.dart';
import 'cart_screen.dart';
import 'data.dart';
import 'rating_bar.dart';

class Detail extends StatelessWidget {
  final Book book;

  Detail(this.book);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: .5,
      title: Text('Design Books'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            openCartScreen(context);
          },
        ),

      ],
    );

    final topLeft = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: book.title,
            child: Material(
              elevation: 15.0,
              shadowColor: Colors.yellow.shade900,
              child: Image(
                image: AssetImage(book.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text('${book.pages} pages', style: TextStyle(color: Colors.black38, fontSize: 12)),
      ],
    );

    final topRight = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(book.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        Text('by ${book.writer}', style: TextStyle(color: Colors.black54, fontSize: 12)),
        Row(
          children: <Widget>[
            Text(book.price, style: TextStyle(fontWeight: FontWeight.bold),),
            RatingBar(rating: book.rating),
          ],
        ),
        SizedBox(height: 32.0),
        Material(
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Colors.blue.shade200,
          elevation: 5.0,
          child: MaterialButton(
            onPressed: () {
              addToCart(book);
            },
            minWidth: 160.0,
            color: Colors.blue,
            child: Text('MUA NGAY', style: TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ),
      ],
    );

    final topContent = Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 2, child: topLeft),
          Flexible(flex: 3, child: topRight),
        ],
      ),
    );

    final bottomContent = Container(
      height: 220.0,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          book.description,
          style: TextStyle(fontSize: 13.0, height: 1.5),
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  Text text(
      String data, {
        Color color = Colors.black87,
        num size = 14,
        EdgeInsetsGeometry padding = EdgeInsets.zero,
        bool isBold = false,
      }) =>
      Text(
        data,
        style: TextStyle(
          color: color,
          fontSize: size.toDouble(),
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      );

  void addToCart(Book book) {
    Cart.addItem(book);
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(content: Text('Đã thêm vào giỏ hàng')),
    );
  }

  void openCartScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartScreen()),
    );
  }
}

