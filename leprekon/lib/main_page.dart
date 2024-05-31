import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:leprekon/provider/hive_provider.dart';
import 'package:leprekon/provider/page_provider.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final TextEditingController incomeController = TextEditingController();
  final TextEditingController outcomeController = TextEditingController();

  Future<Map<String, dynamic>> _fetchUserData() async {
    final response =
        await http.get(Uri.parse('http://192.168.199.225:3000/user'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final userData = snapshot.data;
          final userName = userData?['name'];
          final userXP = userData?['xp'];

          return ChangeNotifierProvider(
            create: (context) => PageProvider(),
            child: Consumer<PageProvider>(
              builder: (context, pageProvider, child) => Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/leading.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Welcome, ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$userName',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Your xp: $userXP',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      icon: Image.asset(
                        'assets/profile.png',
                        width: 50,
                        height: 50,
                      ),
                    )
                  ],
                ),
                body: Center(
                  child: pageProvider.selectedWidget,
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Add Income'),
                                    content: TextField(
                                      controller: incomeController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter income amount',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          double amount = double.tryParse(
                                                  incomeController.text) ??
                                              0.0;
                                          Provider.of<HiveProvider>(context,
                                                  listen: false)
                                              .addTransaction(amount, true);
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          incomeController.clear();
                                        },
                                        child: const Text('Save'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text(
                                'Add Income',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Add Outcome'),
                                    content: TextField(
                                      controller: outcomeController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter outcome amount',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          double amount = double.tryParse(
                                                  outcomeController.text) ??
                                              0.0;
                                          Provider.of<HiveProvider>(context,
                                                  listen: false)
                                              .addTransaction(amount, false);
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          outcomeController.clear();
                                        },
                                        child: const Text('Save'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text(
                                'Add Outcome',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                      ),
                    );
                  },
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add,
                    size: 40,
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: BottomAppBar(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          color: pageProvider.selectedIndex == 0
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                        ),
                        onPressed: () => pageProvider.onItemTapped(0),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.bar_chart,
                          color: pageProvider.selectedIndex == 1
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                        ),
                        onPressed: () => pageProvider.onItemTapped(1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
