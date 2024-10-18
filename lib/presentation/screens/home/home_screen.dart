import 'package:ecommerce_frontend/presentation/screens/home/account_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/home/category_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/home/user_feed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
     AccountScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}