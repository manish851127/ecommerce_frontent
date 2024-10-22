import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecommerce_frontend/logic/cubit/product_cubit/product_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/product_cubit/product_state.dart';
import 'package:ecommerce_frontend/logic/service/formatter.dart';
import 'package:ecommerce_frontend/presentation/screens/cart/cart_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/product/product_details_screen.dart';
import 'package:ecommerce_frontend/presentation/widgets/product_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Flipkart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 28),),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      actions: [
        IconButton(
           onPressed: (){
             Navigator.pushNamed(context, CartScreen.routeName);
           },
            icon: BlocBuilder<CartCubit,CartState>(
              builder: (context,state) {
                return Badge(
                  label: Text('${state.items.length}'),
                  isLabelVisible: (state is CartLoadingState) ? false : true,
                  child:const Icon(
                     CupertinoIcons.cart_fill)
                     );
              }
            ),

           )
        ],
      ),
      body: BlocBuilder<ProductCubit,ProductState>(
        builder: (context,state) {

          if(state is ProductLoadingState && state.products.isEmpty){
            return const Center(child: CircularProgressIndicator(),);
          }
           if(state is ProductErrorState && state.products.isEmpty){
            return  Center(child: Text(state.message.toString()));
          }
          return ProductListView(products: state.products);
        }
      )
    );
  }
}