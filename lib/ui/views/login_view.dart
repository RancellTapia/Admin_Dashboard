import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/login_form_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => LoginFormProvider(),
        child: Builder(builder: (context) {
          final loginFormProvider =
              Provider.of<LoginFormProvider>(context, listen: false);

          return Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
                child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 370),
              child: Form(
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  key: loginFormProvider.formKey,
                  child: Column(
                    children: [
                      // Email
                      TextFormField(
                        onChanged: (value) => loginFormProvider.email = value,
                        validator: (value) {
                          if (!EmailValidator.validate(value ?? '')) {
                            return 'Invalid email';
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          label: 'Email',
                          hint: 'Enter your email',
                          icon: Icons.email_outlined,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // Password
                      TextFormField(
                        onChanged: (value) =>
                            loginFormProvider.password = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          label: 'Password',
                          hint: 'Enter your password',
                          icon: Icons.lock_outline_rounded,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomOutlinedButton(
                        onPressed: () {
                          loginFormProvider.validateForm();
                        },
                        text: 'Login',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LinkText(
                          text: 'New account',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Flurorouter.registerRoute);
                          }),
                    ],
                  )),
            )),
          );
        }));
  }
}
