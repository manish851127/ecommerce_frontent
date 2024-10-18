import 'package:ecommerce_frontend/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_frontend/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecommerce_frontend/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/splash/splash_screen.dart';
import 'package:ecommerce_frontend/presentation/widgets/link_button.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_button.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_textfield.dart';
import 'package:ecommerce_frontend/presentation/widgets/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  static const String routeName="signin";

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
 

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<LoginProvider>(context);

    return BlocListener<UserCubit,UserState>(
      listener: (context, state) {
        if(state is UserLoggedInState){
          Navigator.popUntil(context, (route)=> route.isFirst);
          Navigator.pushReplacementNamed(context, SplashScreen.nameRoute);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: provider.formKey,
              child: ListView(
              children: [
              
              const  Text('Log In',textAlign:TextAlign.center, style: TextStyle(
                  fontSize: 38,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold
                ),),
              
               const Space(),
               (provider.error !="")? 
               Text(provider.error,style:const TextStyle(color: Colors.red),): const SizedBox(),
               SizedBox(height: 5,),
              
               PrimaryTextfield(
                labelText: "Email Address", 
                textEditingController: provider.emailController,
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return "Email address is required";
                  }
                  if(!EmailValidator.validate(value)){
                    return "Invalid Email";
                  }
                  return null;
                },
                ),
              
               const Space(),
              
               PrimaryTextfield(
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return "Password is required";
                  }
                  return null;
                },
                obscureText: true,
                labelText: "Password", 
                textEditingController: provider.passwordController,
                ),
              
               const Space(size: -5.0,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LinkButton(buttonName: "Forget Password", function: (){},)
                ],
              ),
              
               const Space(size: -5.0,),
              
              
              PrimaryButton(
                buttonName:(provider.isLoading)? "..." : "Log in",
                function: provider.logIn),
              
               const Space(),
               
              
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const  Text("Dont't have a account? ", style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold
                ),),
                LinkButton(buttonName: "Sign Up",function: (){
                  Navigator.pushNamed(context, SignupScreen.routeName);
                },)
               ],
               ),
              
              ],
                    ),
            ),
          )),
      ),
    );
  }
}