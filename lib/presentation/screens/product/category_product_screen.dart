import 'package:ecommerce_frontend/logic/cubit/category_product_cubit/category_product_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/category_product_cubit/category_product_state.dart';
import 'package:ecommerce_frontend/presentation/widgets/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key});
  static const String routeName="categoryProduct";

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
   final cubit= BlocProvider.of<CategoryProductCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title:Text("${cubit.category.title}"),
      ),
      body: SafeArea(
        child: BlocBuilder<CategoryProductCubit,CategoryProductState>(
          builder: (context,state){
            if(state is CategoryProductLoadingState){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(state is CategoryProductErrorState){
              return Center(child: Text(state.message),);
            }
            if(state is CategoryProductLoaddedState && state.products.isEmpty){
              return const Center(child: Text('No product found'),);
            }
            return ProductListView(products: state.products);
          }
          )),
    );
  }
}