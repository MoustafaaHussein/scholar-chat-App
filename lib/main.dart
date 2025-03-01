// ignore_for_file: prefer_const_constructors

import 'package:chatapp/blocObserever.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/pages/LoginPage.dart';
import 'package:chatapp/pages/RegisterationPage.dart';
import 'package:chatapp/pages/bloc/auth_bloc/auth_bloc.dart';
import 'package:chatapp/pages/cubits/chat_cubit/chat_cubit_cubit.dart';
import 'package:chatapp/pages/password_reset_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/pages/ChatPage.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'chat-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ChatCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginView.id: (context) => LoginView(),
          RegisterPage.id: (context) => RegisterPage(),
          chatPage.id: (context) => chatPage(),
          PassowrdReset.id: (context) => PassowrdReset(),
        },
        initialRoute: LoginView.id,
      ),
    );
  }
}
