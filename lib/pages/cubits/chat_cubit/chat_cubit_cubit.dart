import 'package:bloc/bloc.dart';
import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/pages/models/messagesModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_cubit_state.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  void addMessage(String data, var loginEmail) {
    try {
      messages.add({
        'message': data,
        kCreatedAt: DateTime.now(),
        'id': loginEmail,
      });
    } on Exception catch (e) {
      emit(ChatFailure());
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((events) {
      List<Messagesmodel> messagesList = [];
      for (var doc in events.docs) {
        messagesList.add(Messagesmodel.fromjson(doc));
      }
      emit(ChatSuccess(messagesList: messagesList));
    });
  }
}
