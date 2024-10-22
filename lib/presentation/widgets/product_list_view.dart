import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/data/models/product/product_model.dart';
import 'package:ecommerce_frontend/logic/service/formatter.dart';
import 'package:ecommerce_frontend/presentation/screens/product/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;
  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            itemCount: products.length,
            itemBuilder:(context,index){

              final product=products[index];

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
                  
                    
                    ],
                  ),
                ),
                 );
              
            }
        );
  }
}