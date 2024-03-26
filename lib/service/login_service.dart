import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginService extends Cubit<LoginState>{
  LoginService() : super(LoginInitial());
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;

  void login({required String email, required String password}) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    }catch(e){
      emit(Failure(error: e.toString()));
    }
  }

  getUser() {
    user = firebaseAuth.currentUser;
  }
  
  registerUser({
    required String userName,
    required String userEmail,
    required String userPassword,
  }) async {
    try{
      UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
            email: userEmail, password: userPassword);

    await userCredential.user!.updateDisplayName(userName);
    emit(RegisterSuccess());
    }catch(e){
      emit(Failure(error: e.toString()));
    }
  }
}

abstract class LoginState{}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class GetUserSuccess extends LoginState{}

class RegisterSuccess extends LoginState {}

class Failure extends LoginState {
  final String error;

  Failure({required this.error});
}