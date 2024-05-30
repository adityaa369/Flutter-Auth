import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teacher/user.dart';

import 'auth_state.dart';

@immutable
abstract class AuthEvent {}


class CheckLoginStatusEvent extends AuthEvent{}



//login event
class LoginEvent extends AuthEvent{

  final String email;
  final String password;

  LoginEvent({required this.password,required this.email});

}

//signup event

class SignupEvent extends AuthEvent{


  final UserModel user;

  SignupEvent({required this.user});
}

class LogoutEvent extends AuthEvent{}
