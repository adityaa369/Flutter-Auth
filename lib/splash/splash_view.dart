import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/auth_bloc.dart';
import '../bloc/bloc/auth_event.dart';
import '../bloc/bloc/auth_state.dart';

class SplashPageWrapper extends StatelessWidget {
  const SplashPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>AuthBloc()..add(CheckLoginStatusEvent()),
      child: SplashPage(),);
  }
}



class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(listener: (context,state){


      if(state is Authenticated){


        Navigator.pushReplacementNamed(context, '/home');
      }else if(state is UnAuthenticated){

        Navigator.pushReplacementNamed(context, '/login');

      }


    },


      child:  Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/splash.png',
                  height: 350,
                  width: 350,
                ),
              ),
              Text(
                "Firebase Bloc App",
                style: Theme.of(context).textTheme.displayLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}