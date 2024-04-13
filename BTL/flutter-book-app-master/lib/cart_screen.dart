import 'package:flutter/material.dart';
import 'package:book_app/cart.dart';
import 'package:book_app/data.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    double total = 0.0;
    for (var book in Cart.items) {
      total += double.parse(book.price.replaceAll('Rp ', ''));
    }
    setState(() {
      totalPrice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
      ),
      body: ListView.builder(
        itemCount: Cart.items.length,
        itemBuilder: (context, index) {
          final book = Cart.items[index];
          return ListTile(
            leading: Image.asset(
              book.image,
              width: 50,
              height: 50,
            ),
            title: Text(book.title),
            subtitle: Text(book.price),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeItemFromCart(book);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Tổng: Rp ${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  processPayment();
                },
                child: Text('Thanh toán'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void removeItemFromCart(Book book) {
    setState(() {
      Cart.removeItem(book);
      calculateTotalPrice();
    });
  }

  void processPayment() {
    Cart.processPayment();
    calculateTotalPrice();
    showPaymentSuccessMessage();
  }

  void showPaymentSuccessMessage() {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(content: Text('Thanh toán thành công')),
    );
  }
}