import 'package:ecommerce_frontend/core/route.dart';
import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/category_cubit/category_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/product_cubit/product_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_frontend/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> UserCubit()),
        BlocProvider(create: (context)=> CategoryCubit()),
        BlocProvider(create: (context)=> ProductCubit()),
        BlocProvider(create: (context)=> CartCubit(
        BlocProvider.of<UserCubit>(context)
       ))



      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: SplashScreen.nameRoute,
        title: 'Flutter Demo',
        theme: Themes.defaultTheme,
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}


class MyBlocObserver extends BlocObserver{
  @override
  void onCreate(BlocBase bloc) {
    debugPrint('Created: $bloc');
    super.onCreate(bloc);
  }
  @override
  void onChange(BlocBase bloc, Change change) {
        debugPrint('Changed in $bloc : $change');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('Changed in $bloc : $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('Closed: $bloc');
    super.onClose(bloc);
  }
}
