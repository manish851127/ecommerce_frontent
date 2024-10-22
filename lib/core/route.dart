import 'package:ecommerce_frontend/data/models/Category/category_model.dart';
import 'package:ecommerce_frontend/data/models/product/product_model.dart';
import 'package:ecommerce_frontend/logic/cubit/category_product_cubit/category_product_cubit.dart';
import 'package:ecommerce_frontend/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecommerce_frontend/presentation/screens/auth/providers/signup_provider.dart';
import 'package:ecommerce_frontend/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/cart/cart_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/home/home_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/product/category_product_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/product/product_details_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/splash/splash_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/user/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
class Routes{
 
  static Route? onGenerateRoute(RouteSettings setting){
    switch(setting.name){
      case LogInScreen.routeName:return CupertinoPageRoute(
        builder: (context) =>ChangeNotifierProvider(
          create: (context) => LoginProvider(context),
          child: const LogInScreen()),
        );
        case SignupScreen.routeName:return CupertinoPageRoute(
        builder: (context) =>ChangeNotifierProvider(
          create: (context) => SignupProvider(context),
          child: const SignupScreen()),
        );
        case HomeScreen.nameRoute: return CupertinoPageRoute(
          builder: (context)=>const HomeScreen());

        case SplashScreen.nameRoute: return CupertinoPageRoute(
          builder: (context)=>const SplashScreen());

           case ProductDetailsScreen.routeName: return CupertinoPageRoute(
          builder: (context)=> ProductDetailsScreen(
            productModel: setting.arguments as ProductModel,
          ));

           case CartScreen.routeName: return CupertinoPageRoute(
          builder: (context)=>const CartScreen());

          case CategoryProductScreen.routeName: return CupertinoPageRoute(
          builder: (context)=> BlocProvider(
            create: (context)=> CategoryProductCubit(setting.arguments as CategoryModel),
            child:const CategoryProductScreen()));

          case EditProfileScreen.routeName: return CupertinoPageRoute(
          builder: (context)=>const EditProfileScreen());

        default: return null;

    }
  }

}