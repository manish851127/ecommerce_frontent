import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/data/models/user/user_model.dart';
import 'package:ecommerce_frontend/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_button.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_textfield.dart';
import 'package:ecommerce_frontend/presentation/widgets/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
  static const String routeName="editProfile";
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Edit Profile'),),
      body: BlocBuilder<UserCubit,UserState>(
        builder: (context,state) {
           if(state is UserLoadingState){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(state is UserErrorState){
              return Center(child: Text(state.message),);
            }
            if(state is UserLoggedInState){
              return editProfile(state.userModel);
            }

            return const Center(child: Text('An error occured'),);
  
        }
      ),
    );
  }
  Widget editProfile(UserModel userModel){
    return ListView(
      padding:const EdgeInsets.all(8),
      children: [
        const Space(),
        Text('Personal Details',style: TextStyles.heading2,),
        const Space(size: -10,),
          PrimaryTextfield(
          labelText: 'Full Name',
          initialValue: userModel.fullName,
          onChanged: (value){
          userModel.fullName=value;
        },
          ),
        const Space(size: -8,),
         PrimaryTextfield(labelText: 'Phone Number',
        initialValue: userModel.phoneNumber,
        onChanged: (value){
          userModel.phoneNumber=value;
        },
         ),
         const Space(),
         Text('Address',style: TextStyles.heading2,),
         const Space(size: -10,),
          PrimaryTextfield(labelText: 'Address',
           initialValue: userModel.address,
            onChanged: (value){
          userModel.address=value;
        },
         ),
        const Space(size: -8,),
          PrimaryTextfield(labelText: 'City',
             initialValue: userModel.city,
             onChanged: (value){
          userModel.city=value;
        },
         ),
        const Space(size: -8,),
          PrimaryTextfield(labelText: 'State',
           initialValue: userModel.state,
           onChanged: (value){
          userModel.state=value;
        },
          ),
         const Space(),
         PrimaryButton(buttonName: 'Save',function: () async{
         bool success=await BlocProvider.of<UserCubit>(context).updateUser(userModel);
         if(success){
          Navigator.pop(context);
         }
         },),

      ],
    );
  }
}