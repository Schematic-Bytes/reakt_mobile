import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reakt/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ReaktApp());
}

class ReaktApp extends StatelessWidget {
  const ReaktApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<dynamic>(
          create: (_) => null,
        ),
      ],
      child: MaterialApp.router(
        title: 'Reakt',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
