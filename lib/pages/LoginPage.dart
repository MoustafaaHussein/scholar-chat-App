// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/helper/snackBar.dart';
import 'package:chatapp/pages/ChatPage.dart';
import 'package:chatapp/pages/RegisterationPage.dart';
import 'package:chatapp/pages/bloc/auth_bloc/auth_bloc.dart';
import 'package:chatapp/pages/cubits/chat_cubit/chat_cubit_cubit.dart';
import 'package:chatapp/pages/password_reset_page.dart';
import 'package:chatapp/widgets/CustomButtomWidget.dart';
import 'package:chatapp/widgets/TextFieldWidget.dart';
import 'package:chatapp/widgets/textWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

FirebaseAuth auth = FirebaseAuth.instance;

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  String? email;
  static String id = 'LoginPage';
  String? passowrd;

  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginFailure) {
          showStatusMessage(context, state.errorMessage);
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(
            context,
            chatPage.id,
            arguments: email,
          );
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
            body: Form(
          key: formKey,
          child: Container(
            width: double.infinity,
            color: KBackgroundcolor,
            child: ListView(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Image.asset('assets/images/scholar.png', height: 100),
                Center(
                  child: TextWidget(
                    data: 'Scholar chat',
                    textColor: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: TextWidget(
                      data: 'Sign in',
                      textColor: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFieldWidget(
                  onChanged: (data) {
                    email = data;
                  },
                  obsecureText: false,
                  labelText: 'Email or Username',
                  hintText: 'Email',
                  color: Colors.white,
                  iconColor: Colors.white,
                  suffixIcon: Icons.email,
                ),
                TextFieldWidget(
                  onChanged: (data) {
                    passowrd = data;
                  },
                  obsecureText: true,
                  labelText: ' Password',
                  color: Colors.white,
                  iconColor: Colors.white70,
                  suffixIcon: Icons.lock,
                ),
                CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate() &&
                          email != null &&
                          passowrd != null) {
                        BlocProvider.of<AuthBloc>(context).add(
                            LoginEvent(email: email!, password: passowrd!));
                      } else {
                        showStatusMessage(
                            context, "Please enter both email and password.");
                      }
                    },
                    backgroundColor: const Color(0xffCFF168),
                    displayText: 'Login',
                    textColor: Colors.black,
                    fontSize: 25),
                CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    backgroundColor: Colors.white,
                    borderColor: const Color.fromARGB(255, 70, 146, 71),
                    displayText: 'Create An Account',
                    textColor: const Color.fromARGB(255, 70, 146, 71),
                    fontSize: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, PassowrdReset.id);
                      },
                      child: const Text(
                        'Can\'t remember password ?',
                        style: TextStyle(
                          color: Color(0xff83AC49),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff83AC49),
                          decorationThickness: 1.5,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
