import 'package:flutter/material.dart';
import 'package:gui/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.root,
        onGenerateRoute: AppRouter.onGenerateRoute,
      );
}
