import 'package:flutter/material.dart';

import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
          child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 370),
        child: Form(
            child: Column(
          children: [
            // Name
            TextFormField(
              // Validator: (),
              style: TextStyle(color: Colors.white),
              decoration: CustomInputs.loginInputDecoration(
                label: 'Name',
                hint: 'Enter your name',
                icon: Icons.person_outline,
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Email
            TextFormField(
              // Validator: (),
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
              // Validator: (),
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
              onPressed: () {},
              text: 'Register',
            ),
            SizedBox(
              height: 10,
            ),
            LinkText(
                text: 'Go to Login',
                onPressed: () {
                  Navigator.pushNamed(context, Flurorouter.loginRoute);
                }),
          ],
        )),
      )),
    );
  }
}
