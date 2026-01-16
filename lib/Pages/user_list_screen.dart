import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:loginproduction/function/drawer.dart';

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
    return PopScope(
        canPop: false, // We handle the pop action ourselves
        onPopInvokedWithResult: (didPop,result) async {
          // Show a logout confirmation dialog
          final shouldLogout = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Logout Confirmation'),
              content: const Text('Do you really want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // User canceled logout
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true), // User confirmed logout
                  child: const Text('Logout'),
                ),
              ],
            ),
          ) ?? false; // Default to false if dialog is dismissed

          if (shouldLogout) {
            // If the user confirmed, navigate back to the login screen
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          }
        },
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        backgroundColor: Color(0xFF203A42),
      ),
        drawer:SafeArea(child:AppDrawer()),
       body: SafeArea(child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0F2027),
                Color(0xFF203A42),
                Color(0xFF2C5364),
              ],
            ),
          ),
          child:SafeArea(
            child: StreamBuilder<DatabaseEvent>(
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
                  style: TextStyle(
                    color:Colors.white
                  ),
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
      )
      )
      )
        )
    );
  }
}
