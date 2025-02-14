import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Features/Auth/Data/Repository/repository.dart';
import 'package:weatherapp/Features/Auth/Presentation/Controller/LoginCubit/login_cubit.dart';
import 'package:weatherapp/Features/Auth/Presentation/Screen/LoginScreen.dart';
import 'package:weatherapp/Features/Auth/Presentation/Screen/SignUpScreen.dart';
import 'package:weatherapp/Features/HomePage/Presentation/Screen/HomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized
  await Firebase.initializeApp();
  runApp(const MyApp());
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
      home: BlocProvider(
        create: (context)=>LoginCubit(AuthRepository()),
          child: const SignUpScreen()) ,
    );
  }
}

