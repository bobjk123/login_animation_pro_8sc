import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Cerebro de la lógica de animaciones
  StateMachineController? controller;

  // StateMachineInput
  SMIBool? isChecking;
  SMIBool? isHandsUp;
  // ...existing code...
  SMITrigger? trigSuccess; // ← trigger de éxito
  SMITrigger? trigFail; // ← trigger de fallo
  SMINumber? numLook;

  bool _obscureText = true;

  // FocusNodes
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // Controladores de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupFocusListeners();
  }

  void _setupFocusListeners() {
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        isHandsUp?.change(false);
        isChecking?.change(true);
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (!_emailFocusNode.hasFocus) {
            isChecking?.change(false);
          }
        });
      }
    });

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        isChecking?.change(false);
        isHandsUp?.change(true);
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (!_passwordFocusNode.hasFocus) {
            isHandsUp?.change(false);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    // Quitar foco y mostrar "pensando"
    FocusScope.of(context).unfocus();
    isHandsUp?.change(false);
    isChecking?.change(true);

    // Simular validación remota
    await Future.delayed(const Duration(milliseconds: 1000));
    isChecking?.change(false);

    final email = _emailController.text.trim();
    final pass = _passwordController.text;

    final isValid = email == 'demo@demo.com' && pass == '123456';
    if (isValid) {
      trigSuccess?.fire();
    } else {
      trigFail?.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'animated_login_character.riv',
                  stateMachines: const ["Login Machine"],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      "Login Machine",
                    );
                    if (controller == null) return;

                    artboard.addController(controller!);

                    isChecking = controller!.findSMI('isChecking') as SMIBool?;
                    isHandsUp = controller!.findSMI('isHandsUp') as SMIBool?;
                    // ...existing code...
                    trigSuccess =
                        controller!.findSMI('trigSuccess') as SMITrigger?;
                    trigFail = controller!.findSMI('trigFail') as SMITrigger?;
                    numLook = controller!.findSMI('numLook') as SMINumber?;
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                onChanged: (value) {
                  if (numLook != null) {
                    numLook!.value = (value.length * 3).toDouble().clamp(0, 60);
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                onChanged: (value) {},
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: const Text(
                  "Forgot your password?",
                  textAlign: TextAlign.right,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                minWidth: size.width,
                height: 50,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: _submitLogin, // ← dispara animaciones
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
