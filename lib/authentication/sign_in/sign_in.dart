import 'package:flutter/material.dart';
import 'package:healthy/authentication/auth_functions/auth_functions.dart';
import 'package:healthy/authentication/auth_provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginFormState>(
      builder: (context, formFieldState, _) {
        return Scaffold(
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!formFieldState.login)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      onChanged: (value) => formFieldState.setFullname(value),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Full Name',
                      ),
                      validator: (value) {
                        if (formFieldState.login || value!.isNotEmpty) {
                          return null;
                        }
                        return "Please enter full name";
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    onChanged: (value) => formFieldState.setEmail(value),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    onChanged: (value) => formFieldState.setPassword(value),
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Password',
                    ),
                    validator: (value) {
                      if (value!.length < 6) {
                        return "Password must contain at least 6 characters";
                      }
                      return null;
                    },
                  ),
                ),
                Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      if (formFieldState.login ||
                          formFieldState.fullname.isNotEmpty) {
                        final FormState? form = Form.of(context);
                        if (form != null && form.validate()) {
                          formFieldState.login
                              ? AuthServices.signinUser(formFieldState.email,
                                  formFieldState.password, context)
                              : AuthServices.signupUser(
                                  formFieldState.email,
                                  formFieldState.password,
                                  formFieldState.fullname,
                                  context);
                        }
                      }
                    },
                    child: Text(formFieldState.login ? 'Login' : 'Signup'),
                  ),
                ),
                TextButton(
                  onPressed: () => formFieldState.toggleLogin(),
                  child: Text(
                    formFieldState.login
                        ? "Don't have an account? Signup"
                        : "Already have an account? Login",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
