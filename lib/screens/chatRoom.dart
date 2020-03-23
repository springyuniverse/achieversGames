import 'package:flutter/material.dart';
import '../services/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final _store = Firestore.instance;
ScrollController _scrollController = new ScrollController();


class ChatRoom extends StatelessWidget {
  ChatRoom({this.chatRoom});
  final String chatRoom;

  @override
  Widget build(BuildContext context) {

    var user = Provider.of<FirebaseUser>(context);
    String sentMessage;
    final textController = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            MymessagesStream(chatRoom: chatRoom,),
            Container(
              decoration: Global.kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {

                        sentMessage = value;
                      },
                      decoration: Global.kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async  {
                      textController.clear();
                      _scrollController.animateTo(
                        0.0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );

                       await _store.collection('chats').document(chatRoom).collection('messages').add({

                        'text': sentMessage,
                        'sender': user.displayName,
                        'createdAt': FieldValue.serverTimestamp()




                       });


                    },
                    child: Text(
                      'Send',
                      style: Global.kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MymessagesStream extends StatelessWidget {

  MymessagesStream({this.chatRoom});
  final String chatRoom;
@override
Widget build(BuildContext context) {
  var user = Provider.of<FirebaseUser>(context);

  return StreamBuilder<QuerySnapshot>(
//    stream: _store.collection('messages').orderBy('createdAt',descending: true).snapshots(),
    stream: _store.collection('chats').document(chatRoom).collection('messages').orderBy('createdAt',descending: true).snapshots(),
    // ignore: missing_return
    builder:(context,snapshot){
      // ignore: missing_return
      if(!snapshot.hasData) {

        return Center(

          child: CircularProgressIndicator(


            backgroundColor: Colors.lightBlueAccent,
          ),


        );

      }
      final messages = snapshot.data.documents;
      List<MessageBubble> messageBubbles = [];
      for (var message in messages) {
        final messageText = message.data['text'];
        final messageSender = message.data['sender'];
        final currentUser = user.displayName;

        final messageBubble = MessageBubble(messageSender: messageSender, messageText: messageText,

          isMe: currentUser == messageSender
          ,);

        messageBubbles.add(messageBubble);
      }

      return Expanded(
        child: ListView(
          controller:  _scrollController,
          reverse: true,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          children: messageBubbles,
        ),
      );


    },
  );
}
}


class MessageBubble extends StatelessWidget {

  MessageBubble({this.messageSender,this.messageText,this.isMe});
  final String messageText;
  final String messageSender;
  final bool isMe;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(

        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.only(bottom:8.0),
            child: Text('$messageSender',style: TextStyle(fontSize: 10),),
          ),
          Material(
            color: isMe ? Colors.red : Colors.blue,
            elevation: 8,
            borderRadius: BorderRadius.only(

              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              topLeft: Radius.circular(30),


            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                  '$messageText'),
            ),
          ),
        ],
      ),
    );
  }
}
