import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/bloc/bloc/auth_bloc.dart';
import 'package:teacher/bloc/bloc/auth_state.dart';
import 'package:teacher/pages/homw_view.dart';
import 'package:teacher/pages/login_view.dart';
import 'package:teacher/pages/user_register.dart';
import 'package:teacher/pages/verification_email.dart';
import 'package:teacher/splash/splash_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
          bodySmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        scaffoldBackgroundColor: Color(0xfff263147),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashPageWrapper(),
        '/login': (context) => LoginViewWrapper(),
        '/home': (context) => HomePageWrapper(),
        '/register': (context) => RegisterPageWrapper(),
        '/email-verification': (context) => EmailVerificationScreen(), // Add route for email verification
      },
    );
  }
}

class MainAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is EmailVerificationSent) {
            Navigator.pushReplacementNamed(context, '/email-verification');
          } else if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthenticatedError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthInitial) {
            return Center(child: Text('Welcome'));
          } else if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UnAuthenticated) {
            return Center(child: Text('Please log in or sign up'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
