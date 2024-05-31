import 'package:flutter/material.dart';
import 'package:leprekon/pages/home_page.dart';
import 'package:leprekon/pages/statistics.dart';

class PageProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Statistics(),
  ];

  int get selectedIndex => _selectedIndex;

  Widget get selectedWidget => _widgetOptions[_selectedIndex];

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
