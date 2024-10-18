import 'package:ecommerce_frontend/data/models/user/user_model.dart';
import 'package:ecommerce_frontend/data/respository/user_repository.dart';
import 'package:ecommerce_frontend/logic/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_frontend/logic/service/preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState>{
  UserCubit() : super(UserInitialState()){
    _initialize();
  }

   final UserRepository _userRepository=UserRepository();

   void _initialize() async{
       final userDetails= await Preferences.getUserDetails();
         String? email= userDetails["email"];
         String? password = userDetails["password"];

         if(email==null || password==null){
          emit(UserLoggedOutState());
         }else{
          signIn(email: email, password: password);
         }
   }

   void _emitLoggedInState({
    required UserModel userModel,
    required String email,
    required String password,
   }) async{
      await Preferences.saveUserDetails(email,password);
      emit(UserLoggedInState(userModel));
   }

   void signIn({required String email, required String password}) async{
    emit(UserLoadingState());
    try{
      UserModel userModel= await _userRepository.signIn(email: email, password: password);
      _emitLoggedInState(userModel: userModel, email: email, password: password);
    }
    catch(e){
      emit(UserErrorState(e.toString()));
    }
   }


    void createAccount({required String email, required String password}) async{
      emit(UserLoadingState());
    try{
      UserModel userModel= await _userRepository.createUser(email: email, password: password);
      _emitLoggedInState(userModel: userModel, email: email, password: password);

    }
    catch(e){
      emit(UserErrorState(e.toString()));
    }
   }

   void signOut() async{
    await Preferences.clear();
    emit(UserLoggedOutState());
   }
  
}

   