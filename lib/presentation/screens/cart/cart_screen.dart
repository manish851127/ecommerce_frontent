import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecommerce_frontend/logic/service/calculation.dart';
import 'package:ecommerce_frontend/logic/service/formatter.dart';
import 'package:ecommerce_frontend/presentation/widgets/link_button.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
  static const String routeName="cart";
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit,CartState>(
          builder: (context,state) {

            if(state is CartLoadingState && state.items.isEmpty){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(state is CartErrorState && state.items.isEmpty){
              return  Center(child: Text(state.message),);
            }
            return Column(
              children: [
            
                Expanded(
                  child: ListView.builder(
                     itemCount: state.items.length,
                    itemBuilder: (context, index){
                      final item= state.items[index];

                      return ListTile(
                        leading: CachedNetworkImage(width: 60,imageUrl: item.product!.images![0]),
                        title: Text('${item.product!.title}',style: TextStyles.body1,),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                              '₹ ${Formatter.formatPrice(item.product!.price!)} × ${item.quantity!.toInt()} = ₹ ${Formatter.formatPrice(item.product!.price! * item.quantity!.toInt())}'),
                              LinkButton(
                                buttonName: 'Delete',
                                color: Colors.red,
                                function: (){
                                  BlocProvider.of<CartCubit>(context).removeFromCart(item.product!);
                                },
                                )
                          ],
                        ),
                        trailing: InputQty.int(
                          onQtyChanged: (value){
                            BlocProvider.of<CartCubit>(context).addToCart(item.product!, value as int);
                          },
                          maxVal: 10,
                          minVal: 1,
                          initVal: item.quantity!,
                        ),
                      );
                    }),
                ),
            
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Column(
                        children: [
                          Text('${state.items.length} items',style: TextStyles.body1,),
                          Text('Total: ₹ ${Formatter.formatPrice(Calculation.cartTotal(state.items))}',style: TextStyles.heading2,)
                        ],
                      )),
                      PrimaryButton(
                        buttonName: 'Order Now',function: (){},)
                    ],
                  ),
                )
              ],
            );
          }
        ),
      ),
      
    );
  }
}