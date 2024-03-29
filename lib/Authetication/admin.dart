import 'package:cwrdm/database/auth.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

bool _obscuretext = true;

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Admin',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: userController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscuretext,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscuretext
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscuretext = !_obscuretext;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(250, 50)),
                    ),
                    onPressed: () {
                      _formKey.currentState!.validate();
                      adminSignIn(userController.text, passwordController.text,
                          context);
                    },
                    child: const Text('Login In'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/signIn');
                    },
                    child: const Text('Go Back to SignIn'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
