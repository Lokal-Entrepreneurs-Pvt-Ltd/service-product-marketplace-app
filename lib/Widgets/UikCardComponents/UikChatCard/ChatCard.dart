import 'package:flutter/material.dart';
import 'package:lokal/Widgets/UikCardComponents/UikChatCard/ChatBubble.dart';

class ChatCard extends StatelessWidget {
  final avtar;

  const ChatCard({Key? key, this.avtar}) : super(key: key);

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
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Center(
                    child: ListTile(
                      leading: avtar,
                      trailing: const Icon(Icons.more_horiz),
                      title: const Text("Tom Cruise"),
                      subtitle: const Text("Last Seen"),
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                Center(
                  child: Container(
                    width: 69,
                    height: 16,
                    margin: const EdgeInsets.fromLTRB(0, 22, 0, 31),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFEEEEEE),
                    ),
                    child: const Center(
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
                SizedBox(
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
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Icon(Icons.link),
                      const SizedBox(
                        width: 10,
                      ),
                      const Flexible(
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            hintText: "Write a message",
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const Icon(Icons.emoji_emotions),
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(Icons.mic),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 1,
                        height: 31,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 37,
                        height: 37,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.yellow,
                        ),
                        child: const Icon(Icons.send),
                      ),
                      const SizedBox(
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
