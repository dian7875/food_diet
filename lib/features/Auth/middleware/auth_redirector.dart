import 'package:flutter/material.dart';

class AuthRedirector extends StatefulWidget {
  final Widget child;
  final String redirectRoute;

  const AuthRedirector({
    super.key,
    required this.child,
    required this.redirectRoute,
  });

  @override
  State<AuthRedirector> createState() => _AuthRedirectorState();
}

class _AuthRedirectorState extends State<AuthRedirector> {
  // Simplificado - siempre permite el acceso
  
  @override
  Widget build(BuildContext context) {

    return widget.child;
  }
}
