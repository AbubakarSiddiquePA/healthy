import 'package:flutter/material.dart';
import 'package:healthy/providers/loginprovider/loginform_provider.dart';
import 'package:provider/provider.dart';
import 'package:healthy/authentication/authfunctions/authfunctions.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginFormState>(
      builder: (context, formFieldState, _) {
        return Scaffold(
          body: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!formFieldState.login)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) => formFieldState.setFullname(value),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Full Name',
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) => formFieldState.setEmail(value),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) => formFieldState.setPassword(value),
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    formFieldState.login
                        ? AuthServices.signinUser(formFieldState.email,
                            formFieldState.password, context)
                        : AuthServices.signupUser(
                            formFieldState.email,
                            formFieldState.password,
                            formFieldState.fullname,
                            context);
                  },
                  child: Text(formFieldState.login ? 'Login' : 'Signup'),
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
