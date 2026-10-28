import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  final String username;
  final String password;

  const LandingPage({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FF),
      appBar: AppBar(
        title: const Text('Quimado'),
        backgroundColor: const Color(0xFFFFF8FF),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFE3F2FD),
                child: Icon(
                  Icons.person,
                  size: 65,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'User Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      title: const Text('Username'),
                      subtitle: Text(widget.username),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                      title: const Text('Password'),
                      subtitle: Text(
                        showPassword ? widget.password : '••••••••',
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() => showPassword = !showPassword);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.logout),
                  label: const Text('Back to Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}