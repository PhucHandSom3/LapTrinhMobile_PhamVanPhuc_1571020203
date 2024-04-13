import 'package:flutter/material.dart';
//1571020177
class CartModel extends ChangeNotifier {
  // list of items on sale
  final List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Bơ", "7.00", "lib/images/avocado.png", Colors.green],
    ["Chuối", "4.00", "lib/images/banana.png", Colors.yellow],
    ["Gà", "15.90", "lib/images/chicken.png", Colors.brown],
    ["Lựu", "2.70", "lib/images/water.png", Colors.blue],


  ];

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
