import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState{}

class Authenticated extends AuthState{

  User ?user;
  Authenticated(this.user);
}


class UnAuthenticated extends AuthState{}


class AuthenticatedError extends AuthState{


  final String message;

  AuthenticatedError({required this.message});

}
class EmailVerificationSent extends AuthState {}