import 'package:coach_potato/provider/auth_provider.dart';
import 'package:flutter/material.dart';

class AddTraineeDialog extends StatelessWidget {
  const AddTraineeDialog({required this.emailController, super.key});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Trainee'),
      content: TextField(
        controller: emailController,
        decoration: const InputDecoration(
          labelText: 'Trainee Email',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final String email = emailController.text.trim();
            if (email.isNotEmpty) {
              await AuthService.sendSignInLink(email);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sign-in link sent to $email')),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
