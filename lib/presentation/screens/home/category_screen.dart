import 'package:ecommerce_frontend/logic/cubit/category_cubit/category_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/category_cubit/category_state.dart';
import 'package:ecommerce_frontend/presentation/screens/product/category_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatergoryScreen extends StatefulWidget {
  const CatergoryScreen({super.key});

  @override
  State<CatergoryScreen> createState() => _CatergoryScreenState();
}

class _CatergoryScreenState extends State<CatergoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Category Page'),),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        
        builder: (context, state) {
          if(state is CategoryLoadingState && state.categories.isEmpty){
            return const Center(child: CircularProgressIndicator(),);
          }
           if(state is CategoryErrorState && state.categories.isEmpty){
            return  Center(child: Text(state.message.toString()));
          }

          return ListView.builder(
            itemCount: state.categories.length,
           itemBuilder: (context,index){
            final category=state.categories[index];
            return ListTile(
              onTap: (){
                Navigator.pushNamed(
                  context, CategoryProductScreen.routeName, arguments: category
                  );
              },
              title: Text(category.title.toString()),
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: Icon(Icons.category),
            );
           },
          
            );
        }
      ),
    );
  }
}