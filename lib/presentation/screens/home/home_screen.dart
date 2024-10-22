import 'package:ecommerce_frontend/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_frontend/presentation/screens/home/profile_scereen.dart';
import 'package:ecommerce_frontend/presentation/screens/home/category_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/home/user_feed_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  static const String nameRoute="home";
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex=0;
  List<Widget> widgetList= const[
     UserFeedScreen(),
     CatergoryScreen(),
     ProfileScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit,UserState>(
      listener: (context,state){
        if(state is UserLoggedOutState){
          Navigator.pushNamed(context, SplashScreen.nameRoute);
        }
      },
      child: Scaffold(
          body: widgetList[currentIndex],
      
          bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            setState(() {
              currentIndex=index;
            });
          },
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Category'),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Person'),
      
          ]
          ),
      ),
    );
  }
}