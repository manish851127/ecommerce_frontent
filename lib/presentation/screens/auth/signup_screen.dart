import 'package:ecommerce_frontend/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/auth/providers/signup_provider.dart';
import 'package:ecommerce_frontend/presentation/widgets/link_button.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_button.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_textfield.dart';
import 'package:ecommerce_frontend/presentation/widgets/space_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

    static const String routeName="signup";


  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

   @override
  Widget build(BuildContext context) {
    final provider=Provider.of<SignupProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: provider.formKey,
            child: ListView(
            children: [
            
            const  Text('Create Account',textAlign:TextAlign.center, style: TextStyle(
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

              const Space(),
            
             PrimaryTextfield(
              validator: (value) {
                if(value == null || value.trim().isEmpty){
                  return "Confirm your password";
                }
                if(value.trim() != provider.passwordController.text.trim()){
                  return "Passwords do not match";
                }
                return null;
              },
              
              obscureText: true,
              labelText: "Confirm Password", 
              textEditingController: provider.cPasswordController,
              ),
            
             const Space(size: -5.0,),

            PrimaryButton(
              buttonName:(provider.isLoading)? "..." : "Create Account",
              function: provider.createAccount),
            
             const Space(),
             
            
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const  Text("Already have a account? ", style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold
              ),),
              LinkButton(buttonName: "Log In",function: (){
                Navigator.pushNamed(context, LogInScreen.routeName);
              },)
             ],
             ),
            
            ],
           ),
          ),
        )),
    );
  }
}