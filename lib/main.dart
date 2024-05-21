import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthy/authentication/signin/signin.dart';
import 'package:healthy/homescreen/home.dart';
import 'package:healthy/providers/authprovider/authprovider.dart';
import 'package:healthy/providers/authprovider/habitprovider/addhabitprovider.dart';
import 'package:healthy/providers/reminderprovider/reminder_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDXEECVLLV6BBbpeAtXJ4OblJ3k_uBak3Y",
    appId: "1:764846460901:web:77c9486580baa2db65a90c",
    messagingSenderId: "764846460901",
    projectId: "healthy-a9610",
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginFormState>(create: (_) => LoginFormState()),
        ChangeNotifierProvider<AddHabitProvider>(
            create: (_) => AddHabitProvider()),
        ChangeNotifierProvider(create: (_) => ReminderProvider()),
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('An error occurred'));
            } else if (snapshot.hasData) {
              return const Home();
            } else {
              return const LoginForm();
            }
          }),
    );
  }
}
