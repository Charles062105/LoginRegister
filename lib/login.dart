import 'package:flutter/material.dart';
import 'register.dart';
import 'landing.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool showPassword = false;
  String? registeredUsername;
  String? registeredPassword;

  void login() {
    if (username.text.trim().isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (username.text.trim() != registeredUsername ||
        password.text != registeredPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username or password is incorrect')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LandingPage(
          username: username.text.trim(),
          password: password.text,
        ),
      ),
    );
  }

  Future<void> register() async {
    final account = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (_) => const RegisterPage()),
    );

    if (account != null && mounted) {
      setState(() {
        registeredUsername = account['username'];
        registeredPassword = account['password'];
      });
    }
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FF),
      appBar: AppBar(
        title: const Text('Quimado'),
        backgroundColor: const Color(0xFFFFF8FF),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (_) => register(),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'register',
                child: Text('Register'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: username,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: password,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
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
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: login,
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: register,
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}