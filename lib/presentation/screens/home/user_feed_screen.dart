import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/logic/cubit/product_cubit/product_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/product_cubit/product_state.dart';
import 'package:ecommerce_frontend/logic/service/formatter.dart';
import 'package:ecommerce_frontend/presentation/screens/cart/cart_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/product/product_details_screen.dart';
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
           icon: Icon( CupertinoIcons.cart_fill),
           onPressed: (){
             Navigator.pushNamed(context, CartScreen.routeName);
           },
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

          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder:(context,index){

              final product=state.products[index];

                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    Navigator.pushNamed(
                      context, ProductDetailsScreen.routeName,arguments: product
                      );
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      
                      CachedNetworkImage(
                      imageUrl: "${product.images?[0]}",
                      width: MediaQuery.of(context).size.width / 3,
                      height: 100,
                      fit: BoxFit.cover, // Optional: To ensure the image fits the container.
                      placeholder: (context, url) =>const Center(child: CircularProgressIndicator()), // Shows a loading indicator.
                      errorWidget: (context, url, error) => Icon(Icons.error), // Shows an error icon if loading fails.
                    ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title.toString(),style: TextStyles.heading2,maxLines: 1,),
                            Text('Product Description is very and it can take whole space though and we can not do any thing',overflow: TextOverflow.ellipsis,style: TextStyles.body1,maxLines: 2,),
                            SizedBox(height: 5,),
                            Text("₹ ${Formatter.formatPrice(product.price!)}" ,style: TextStyles.heading3,maxLines: 1,)
                          ],
                                         ),
                        ),
                      ),
                  
                      IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.cart))
                                     
                                     ],
                                   ),
                ),
                 );
              
            }
             );
        }
      )
    );
  }
}