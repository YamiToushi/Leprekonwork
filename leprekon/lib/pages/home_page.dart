import 'package:flutter/material.dart';
import 'package:leprekon/components/cards.dart';
import 'package:leprekon/components/stats.dart';
import 'package:leprekon/components/tasks.dart';
import 'package:provider/provider.dart';
import 'package:leprekon/provider/hive_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveProvider>(
      builder: (context, hiveProvider, child) {
        return const Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Cards(),
                  SizedBox(height: 20),
                  Text(
                    'Statistics',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DoughnutChart(),
                  SizedBox(height: 20),
                  Text(
                    'Tasks',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Tasks(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
