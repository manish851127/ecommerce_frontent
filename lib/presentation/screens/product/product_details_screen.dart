import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/data/models/product/product_model.dart';
import 'package:ecommerce_frontend/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecommerce_frontend/logic/service/formatter.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({super.key, required this.productModel});
  static const String routeName="productDetails";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productModel.title}"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: CarouselSlider.builder(
                itemCount: widget.productModel.images?.length ?? 0,
                slideBuilder: (index){
                  String imageUrl= widget.productModel.images![index];
                  return CachedNetworkImage(
                    imageUrl: imageUrl,

                    );
                },
                 
                 ),
            ),
           const Spacer(),

           Padding(
             padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
             child: Text("${widget.productModel.title}",style: TextStyles.heading1,),
           ),
           Padding(
             padding: const EdgeInsets.only(top: 8,left: 8,right: 8 ),
             child: Row(
               children: [
                 Text('Deal Price', style: TextStyle(color: Colors.redAccent,fontSize: 18,fontWeight: FontWeight.bold),),
                 Text("  ₹ ${Formatter.formatPrice(widget.productModel.price!)}",style: TextStyles.heading2,),
               ],
             ),
           ),
           Padding(
            padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
            child: BlocBuilder<CartCubit,CartState>(
              builder: (context,state) {
                return PrimaryButton(
                  color: (BlocProvider.of<CartCubit>(context).cartContains(widget.productModel))? AppColors.textLight: AppColors.acccent,
                  buttonName:(BlocProvider.of<CartCubit>(context).cartContains(widget.productModel)) ?"Product added to cart": "Add to cart",
                  function: (){
                    if(BlocProvider.of<CartCubit>(context).cartContains(widget.productModel)){
                      return;
                    }
                  BlocProvider.of<CartCubit>(context).addToCart(widget.productModel, 1);
                },);
              }
            ),
           ),
          Padding(
            padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
            child: Text("this is iphone 15 pro max with 256 gb varient with 8gb ltddr ram with tiple camera with main camera 48 mp and front 12 mp",style: TextStyles.body1,),
          ),

           

          ],
        ),),
    );
  }
}