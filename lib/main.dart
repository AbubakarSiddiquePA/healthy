import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthy/authentication/auth_provider/auth_provider.dart';
import 'package:healthy/authentication/sign_in/sign_in.dart';
import 'package:healthy/home_screen/home.dart';
import 'package:healthy/habits/habit_provider/add_habit_provider.dart';
import 'package:healthy/privacypolicy/privacy_policy.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDXEECVLLV6BBbpeAtXJ4OblJ3k_uBak3Y",
    appId: "1:764846460901:web:77c9486580baa2db65a90c",
    messagingSenderId: "764846460901",
    projectId: "healthy-a9610",
  ));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool acceptedPrivacyPolicy = prefs.getBool("acceptedPrivacyPolicy") ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginFormState>(create: (_) => LoginFormState()),
        ChangeNotifierProvider<AddHabitProvider>(
            create: (_) => AddHabitProvider()),
      ],
      child: MyApp(
        acceptedPrivacyPolicy: acceptedPrivacyPolicy,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool acceptedPrivacyPolicy;

  const MyApp({super.key, required this.acceptedPrivacyPolicy});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: acceptedPrivacyPolicy
            ? StreamBuilder(
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
                })
            : const PrivacyPolicyScreen());
  }
}
