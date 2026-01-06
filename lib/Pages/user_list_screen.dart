import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final DatabaseReference usersRef =
  FirebaseDatabase.instance.ref("users");

  final String myUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // set offline on logout
              await FirebaseDatabase.instance
                  .ref("users/$myUid/online")
                  .set(false);

              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: usersRef.onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.data!.snapshot.value == null) {
            return const Center(
              child: Text("No users found"),
            );
          }

          // Convert JSON to Map
          final data = Map<String, dynamic>.from(
            snapshot.data!.snapshot.value as Map,
          );

          // Convert Map to List
          final users = data.entries.toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userUid = users[index].key; // ✅ receiverId
              final userData =
              Map<String, dynamic>.from(users[index].value);

              // ❌ Hide logged-in user
              if (userUid == myUid) {
                return const SizedBox.shrink();
              }

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: userData["online"] == true
                      ? Colors.blue
                      : Colors.grey,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  userData["username"] ?? "No Name",
                ),
                subtitle: Text(
                  userData["email"] ?? "",
                ),
                trailing: Text(
                  userData["online"] == true ? "Online" : "Offline",
                  style: TextStyle(
                    color: userData["online"] == true
                        ? Colors.green
                        : Colors.grey,
                    fontSize: 12,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        receiverId: userUid,
                        receiverName: userData["username"],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
