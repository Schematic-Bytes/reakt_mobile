import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthRoute extends StatelessWidget {
  const AuthRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static String redirect(BuildContext context, GoRouterState state) {
    final authService = context.read<FirebaseAuth>();

    if (authService.currentUser == null) {
      return "/intro";
    }

    return "/dashboard";
  }
}
