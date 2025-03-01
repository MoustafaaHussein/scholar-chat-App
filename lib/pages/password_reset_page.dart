import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/helper/snackBar.dart';
import 'package:chatapp/pages/LoginPage.dart';
import 'package:chatapp/pages/RegisterationPage.dart';
import 'package:chatapp/pages/bloc/auth_bloc/auth_bloc.dart';
import 'package:chatapp/widgets/CustomButtomWidget.dart';
import 'package:chatapp/widgets/TextFieldWidget.dart';
import 'package:chatapp/widgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

GlobalKey<FormState> formKey = GlobalKey();

class PassowrdReset extends StatelessWidget {
  PassowrdReset({super.key});
  static String id = 'PasswordReset';
  String? email;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ResetLoading) {
          isLoading = false;
        } else if (state is ResetSuccess) {
          Navigator.popAndPushNamed(context, LoginView.id);
          isLoading = false;
        } else if (state is ResetFailure) {
          showStatusMessage(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: KBackgroundcolor,
            body: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Image.asset('assets/images/6195699.png', height: 150),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: TextWidget(
                      data: 'Password Reset',
                      textColor: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWidget(
                        data:
                            'Enter Your Email Address associated with your account to reset Password',
                        textColor: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  TextFieldWidget(
                    onChanged: (data) {
                      email = data;
                    },
                    obsecureText: false,
                    labelText: 'Enter Your Email address..',
                    color: Colors.white,
                    iconColor: Colors.white,
                    suffixIcon: Icons.email,
                  ),
                  CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context)
                              .add(ResetEvent(email: email!));
                          Navigator.pushNamed(context, RegisterPage.id);
                        }
                      },
                      displayText: 'Send Instructions',
                      backgroundColor: const Color(0xffCFF168),
                      textColor: Colors.black,
                      fontSize: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          'Don\'t have Account ',
                          style: TextStyle(
                            color: Color(0xff83AC49),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xff83AC49),
                            decorationThickness: 1.5,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
