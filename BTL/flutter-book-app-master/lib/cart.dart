import 'dart:js';

import 'package:flutter/material.dart';

import 'data.dart';
class Cart {
  static List<Book> items = [];

  static void addItem(Book book) {
    items.add(book);
  }

  static void removeItem(Book book) {
    items.remove(book);
  }

  static void clearCart() {
    items.clear();
  }
  static void processPayment() {
    clearCart();
    showPaymentSuccessMessage();
  }
  static void showPaymentSuccessMessage() {

  }
}
