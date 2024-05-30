import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/data/form/fetch_student.dart';
import 'package:teacher/data/form/student_form.dart';

import '../bloc/bloc/auth_bloc.dart';
import '../bloc/bloc/auth_event.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff263147),
        actions: [
          IconButton(
            onPressed: () {
              final authBoc = BlocProvider.of<AuthBloc>(context);

              authBoc.add(LogoutEvent());

              Navigator.pushNamedAndRemoveUntil(
                  context, '/splash', (route) => false);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                children: [
                  WidgetSpan(
                    child: Icon(Icons.edit, color: Colors.white, size: 24),
                  ),
                  TextSpan(text: " Tap on edit icon to fill student details"),
                ],
              ),
            ),
            SizedBox(height: 10), // Added SizedBox
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                children: [
                  WidgetSpan(
                    child: Icon(Icons.data_usage_outlined, color: Colors.white, size: 24),
                  ),
                  TextSpan(text: " Tap on data usage icon to show student details"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xfff263147), // Orange color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                // Navigate to FormPage directly
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsertData()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.data_usage_outlined, color: Colors.white),
              onPressed: () {
                // Navigate to FormPage directly
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FetchData()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
