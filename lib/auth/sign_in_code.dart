import 'package:coach_potato/constants/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInCode extends StatefulWidget {
  const SignInCode({super.key});

  @override
  SignInCodeState createState() => SignInCodeState();
}

class SignInCodeState extends State<SignInCode> {
  final TextEditingController _codeController = TextEditingController();

  Future<void> _pasteFromClipboard() async {
    ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null) {
      String pastedText = clipboardData.text ?? '';

      // Remove non-numeric characters and limit to 6 digits
      String filteredText = pastedText.replaceAll(RegExp(r'[^0-9]'), '').substring(0, (pastedText.length > 6 ? 6 : pastedText.length));

      setState(() {
        _codeController.text = filteredText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Code'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Enter your authentication code',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _codeController,
                autofocus: true,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 6,
                style: const TextStyle(fontSize: 24, letterSpacing: 4),
                decoration: const InputDecoration(
                  hintText: '••••••',
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
              ),


              const SizedBox(height: 2 * defPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <ElevatedButton>[
                  ElevatedButton(
                    onPressed: _pasteFromClipboard,
                    child: const Text('Paste from Clipboard'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade400,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Verify Code'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
