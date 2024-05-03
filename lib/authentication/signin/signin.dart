import 'package:flutter/material.dart';
import 'package:healthy/authentication/authfunctions/authfunctions.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String fullname = '';
  bool login = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 10,
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.black54,
            Colors.orange.shade100,
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ======== Full Name ========
              login
                  ? Container()
                  : TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      key: const ValueKey('fullname'),
                      decoration: const InputDecoration(
                        hintText: 'Enter Full Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Full Name';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          fullname = value!;
                        });
                      },
                    ),

              // ======== Email ========
              TextFormField(
                key: const ValueKey('email'),
                autovalidateMode: AutovalidateMode.always,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.orange,
                  )),
                  hintText: 'Enter Email',
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please Enter valid Email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),
              // ======== Password ========
              TextFormField(
                key: const ValueKey('password'),
                autovalidateMode: AutovalidateMode.always,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter Password',
                ),
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Please Enter Password of min length 6';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.yellow,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        login
                            ? AuthServices.signinUser(email, password, context)
                            : AuthServices.signupUser(
                                email, password, fullname, context);
                      }
                    },
                    child: Text(login ? 'Login' : 'Signup')),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      login = !login;
                    });
                  },
                  child: Text(
                    login
                        ? "Don't have an account? Signup"
                        : "Already have an account? Login",
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
