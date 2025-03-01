// ignore_for_file: file_names
import 'package:chatapp/pages/cubits/chat_cubit/chat_cubit_cubit.dart';
import 'package:chatapp/pages/models/messagesModel.dart';
import 'package:chatapp/widgets/chatBubbleWidget.dart';
import 'package:chatapp/widgets/textWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Color kprimaryColor = const Color(0xff2B475E);
ScrollController _controller = ScrollController();

class chatPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  String? submittedText;
  // reading data from database using the next line as the messages will access the collection called ' messages' or creating a new collection with new refrence
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  static String id = 'ChatPage';

  List<Messagesmodel> messagesList = [];
  chatPage({super.key});
  @override
  Widget build(BuildContext context) {
    var loginEmail = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: kprimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              height: 80,
              'assets/images/scholar.png',
            ),
            const SizedBox(
              width: 20,
            ),
            TextWidget(
              data: 'Chat',
              textColor: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'Pacifico',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatStates>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList = state.messagesList;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == loginEmail
                        ? chatBubbleWidget(message: messagesList[index])
                        : chatBubbleSecondUser(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 210, 209, 209),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: controller,
                onSubmitted: (data) {
                  BlocProvider.of<ChatCubit>(context)
                      .addMessage(data, loginEmail);
                  controller.clear();
                  _scrollDown();
                },
                showCursor: true,
                decoration: InputDecoration(
                    suffixIconColor: Colors.black,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.send,
                          )),
                    ),
                    hintText: 'Enter your Message here...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black))),
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _scrollDown() {
  _controller.animateTo(
    0,
    duration: const Duration(seconds: 2),
    curve: Curves.fastOutSlowIn,
  );
}
