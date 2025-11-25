import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Profile"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Foto profil
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/banner1.jpg"), // gunakan gambar yg sama
                ),
                const SizedBox(height: 12),
                const Text(
                  "Nekokop",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Edit Profile"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Menu list Netflix
          buildMenuItem(Icons.list, "My List"),
          buildMenuItem(Icons.settings, "App Settings"),
          buildMenuItem(Icons.help_outline, "Help Center"),
          buildMenuItem(Icons.logout, "Log Out", isDanger: true),

        ],
      ),
    );
  }

  // Widget item menu
  Widget buildMenuItem(IconData icon, String text, {bool isDanger = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: isDanger ? Colors.red : Colors.white),
          const SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              color: isDanger ? Colors.red : Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}