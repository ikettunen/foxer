import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder for profile details and course actions
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('User Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('user@email.com', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Enrolled Courses', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            // TODO: List enrolled courses here
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement course selection/enroll
              },
              child: const Text('Select/Enroll in Courses'),
            ),
          ],
        ),
      ),
    );
  }
}
