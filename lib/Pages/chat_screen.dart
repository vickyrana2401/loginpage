import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  late String myUid;
  late String chatId;

  @override
  void initState() {
    super.initState();
    myUid = _auth.currentUser!.uid;
    chatId = getChatId(myUid, widget.receiverId);
  }

  String getChatId(String uid1, String uid2) {
    return uid1.hashCode <= uid2.hashCode
        ? "${uid1}_$uid2"
        : "${uid2}_$uid1";
  }

  /// SEND MESSAGE
  void sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final messageRef = _dbRef
        .child("chats")
        .child(chatId)
        .child("messages")
        .push();

    messageRef.set({
      "senderId": myUid,
      "receiverId": widget.receiverId,
      "text": _messageController.text.trim(),
      "seen": false,
      "timestamp": ServerValue.timestamp,
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverName),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          /// 🔥 MESSAGES LIST
          Expanded(
            child: StreamBuilder<DatabaseEvent>(
              stream: _dbRef
                  .child("chats")
                  .child(chatId)
                  .child("messages")
                  .onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.data!.snapshot.value == null) {
                  return const Center(
                    child: Text("No messages yet"),
                  );
                }

                final data = Map<String, dynamic>.from(
                  snapshot.data!.snapshot.value as Map,
                );

                final messages = data.entries.toList()
                  ..sort((a, b) {
                    final aTime = a.value["timestamp"] ?? 0;
                    final bTime = b.value["timestamp"] ?? 0;
                    return aTime.compareTo(bTime);
                  });


                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg =
                    Map<String, dynamic>.from(messages[index].value);

                    final isMe = msg["senderId"] == myUid;

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(12),
                        constraints: BoxConstraints(
                          maxWidth:
                          MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Colors.blue.shade400
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          msg["text"] ?? "",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          /// ✍ MESSAGE INPUT
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.grey.shade200,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
