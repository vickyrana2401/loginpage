import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Future<Map<String, dynamic>> getUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseDatabase.instance
        .ref("users/$uid")
        .get();

    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    }

    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data!;
          final username = userData["username"] ?? "No Name";
          final email = userData["email"] ?? "";

          return Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
                  ),
                ),
                currentAccountPicture: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/profile.png"),
                ),
                accountName: Text(
                  username,
                  style: const TextStyle(fontSize: 18),
                ),
                accountEmail: Text(email),
              ),

              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),

              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  final uid =
                      FirebaseAuth.instance.currentUser!.uid;

                  await FirebaseDatabase.instance
                      .ref("users/$uid/online")
                      .set(false);

                  await FirebaseAuth.instance.signOut();
                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/",
                        (route) => false,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
