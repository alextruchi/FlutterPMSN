import 'package:flutter/material.dart';
import 'package:psmn2/model/sesionUsu.dart';

class Session extends StatelessWidget {
  const Session({super.key});

  @override
  Widget build(BuildContext context) {
    String? sessionId = SessionUsu().getSessionId();
    return Container(
      child: Text("El sesionID es: $sessionId"),
    );
  }
}