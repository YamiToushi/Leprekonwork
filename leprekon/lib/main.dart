import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leprekon/pages/profile.dart';
import 'package:leprekon/provider/hive_model.dart';
import 'package:leprekon/utils/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'main_page.dart';
import 'provider/hive_provider.dart';
import 'provider/page_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transactions');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => HiveProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: MainPage(),
      routes: {
        '/profile':(context)=>const Profile(),
      },
    );
  }
}
