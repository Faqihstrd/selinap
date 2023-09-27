import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_selinap/tema_app/fitness_app_home_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController ctrlUsername = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();

  AnimationController? _controller;
  Animation<double>? _animacaoBlur;
  Animation<double>? _animacaoFade;
  Animation<double>? _animacaoSize;

  late bool _passwordVisible;
  String username = 'guru';
  String password = 'smk';

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animacaoBlur = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.ease,
      ),
    );

    _animacaoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOutQuint,
      ),
    );

    _animacaoSize = Tween<double>(
      begin: 0,
      end: 500,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.decelerate,
      ),
    );

    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                AnimatedBuilder(
                  animation: _animacaoBlur!,
                  builder: (context, widget) {
                    return Container(
                      height: 400,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/fundo.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: _animacaoBlur!.value,
                          sigmaY: _animacaoBlur!.value,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 10,
                              child: FadeTransition(
                                opacity: _animacaoFade!,
                                child:
                                    Image.asset("assets/images/detalhe1.png"),
                              ),
                            ),
                            Positioned(
                              left: 50,
                              child: FadeTransition(
                                opacity: _animacaoFade!,
                                child:
                                    Image.asset("assets/images/detalhe2.png"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                //TextFormField untuk Username
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: ctrlUsername,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //TextFormField untuk Password
                      TextFormField(
                        controller: ctrlPassword,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              !_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Button Login
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Kode ketika form sudah terisi
                                if (ctrlUsername.text == username &&
                                    ctrlPassword.text == password) {
                                  // Navigator.pushNamed(context, '/mainmenu');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FitnessAppHomeScreen(),
                                    ),
                                  );
                                } else {
                                  const snackBar = SnackBar(
                                    content:
                                        Text('Username/Password Salah'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color.fromRGBO(20, 118, 186, 1)),
                            ),
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Animation<double>?>(
        '_animacaoSize', _animacaoSize));
  }
}
