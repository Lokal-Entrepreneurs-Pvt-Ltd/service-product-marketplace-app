import 'package:flutter/material.dart';
import 'package:login/Widgets/UikCardComponents/UikChatCard/ChatBubble.dart';

class ChatCard extends StatelessWidget {
  final avtar;

  ChatCard({Key? key, this.avtar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 552,
          height: 600,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // color: Colors.black,
          ),
          child: Card(
            child: Column(
              children: [
                Container(
                  height: 95,
                  margin: EdgeInsets.only(bottom: 5),
                  child: Center(
                    child: ListTile(
                      leading: avtar,
                      trailing: Icon(Icons.more_horiz),
                      title: Text("Tom Cruise"),
                      subtitle: Text("Last Seen"),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Center(
                  child: Container(
                    width: 69,
                    height: 16,
                    margin: EdgeInsets.fromLTRB(0, 22, 0, 31),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFEEEEEE),
                    ),
                    child: Center(
                      child: Text(
                        "Augest 21",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 340,
                  child: ListView(
                    children: const [
                      ChatBubble(
                        text: 'How was the concert?',
                        isCurrentUser: false,
                      ),
                      ChatBubble(
                        text: 'Awesome! Next time you gotta come as well!',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'Ok, when is the next date?',
                        isCurrentUser: false,
                      ),
                      ChatBubble(
                        text: 'They\'re playing on the 20th of November',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'Let\'s do it!',
                        isCurrentUser: false,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Icon(Icons.link),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextField(
                          decoration: new InputDecoration.collapsed(
                            hintText: "Write a message",
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Icon(Icons.emoji_emotions),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.mic),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 1,
                        height: 31,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 37,
                        height: 37,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.yellow,
                        ),
                        child: Icon(Icons.send),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
