import 'dart:async';

import 'package:ecommerce_frontend/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_frontend/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  static const String nameRoute="splash";
}

class _SplashScreenState extends State<SplashScreen> {


void goToNextScreen(){
  UserState userState=BlocProvider.of<UserCubit>(context).state;
  if(userState is UserLoggedInState){
    Navigator.pushReplacementNamed(context, HomeScreen.nameRoute);
  }
  else if(userState is UserLoggedOutState){
  Navigator.pushReplacementNamed(context, LogInScreen.routeName);

  }
  else if(userState is UserErrorState){
  Navigator.popUntil(context, (value)=> value.isFirst);
  Navigator.pushReplacementNamed(context, LogInScreen.routeName);

  }

}

@override
  void initState() {
    Timer(Duration(milliseconds: 100), (){
    goToNextScreen();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocListener<UserCubit,UserState>(
      listener: (context, state) {
        goToNextScreen();
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}