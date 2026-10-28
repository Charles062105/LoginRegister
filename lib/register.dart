import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final name = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  final birthdate = TextEditingController();

  String? gender, status;
  bool showPassword = false, showConfirm = false;

  InputDecoration decoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
    );
  }

  Widget field(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool hidden = false,
    VoidCallback? toggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: hidden,
      decoration: decoration(hint, icon).copyWith(
        suffixIcon: toggle == null
            ? null
            : IconButton(
                icon: Icon(
                  hidden ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: toggle,
              ),
      ),
    );
  }

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date != null && mounted) {
      birthdate.text = '${date.month}/${date.day}/${date.year}';
    }
  }

  void register() {
    if ([name, username, password, confirm, birthdate]
            .any((c) => c.text.trim().isEmpty) ||
        gender == null ||
        status == null) {
      message('Please complete all fields');
      return;
    }

    if (password.text != confirm.text) {
      message('Passwords do not match');
      return;
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    for (final c in [name, username, password, confirm, birthdate]) {
      c.dispose();
    }
    super.dispose();
  }

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
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              field(name, 'FullName', Icons.person),
              const SizedBox(height: 10),
              field(username, 'Username', Icons.account_circle),
              const SizedBox(height: 10),
              field(
                password,
                'Password',
                Icons.lock,
                hidden: !showPassword,
                toggle: () =>
                    setState(() => showPassword = !showPassword),
              ),
              const SizedBox(height: 10),
              field(
                confirm,
                'Confirm Password',
                Icons.lock_outline,
                hidden: !showConfirm,
                toggle: () =>
                    setState(() => showConfirm = !showConfirm),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: decoration('Gender', Icons.people),
                hint: const Text('Gender'),
                items: ['Male', 'Female', 'Other']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => gender = value),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: decoration('Civil Status', Icons.favorite),
                hint: const Text('Civil Status'),
                items: ['Single', 'Married', 'Widowed', 'Separated']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => status = value),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: birthdate,
                readOnly: true,
                onTap: selectDate,
                decoration: decoration(
                  'Birthdate',
                  Icons.calendar_today,
                ),
              ),
              const SizedBox(height: 15),
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