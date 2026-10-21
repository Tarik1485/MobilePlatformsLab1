import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/auth_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final ticketController = TextEditingController();
  bool initialized = false;

  @override
  void dispose() {
    nameController.dispose();
    ticketController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthModel>();

    if (!auth.isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('Профіль')),
        body: Center(
          child: FilledButton(
            onPressed: () => context.go('/login'),
            child: const Text('Увійти до бібліотеки'),
          ),
        ),
      );
    }

    if (!initialized) {
      nameController.text = auth.readerName;
      ticketController.text = auth.ticketNumber;
      initialized = true;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Профіль читача')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const CircleAvatar(
            radius: 45,
            child: Icon(Icons.person, size: 48),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Ім’я читача',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: ticketController,
            decoration: const InputDecoration(
              labelText: 'Номер читацького квитка',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              if (nameController.text.trim().isEmpty ||
                  ticketController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Заповніть обидва поля'),
                  ),
                );
                return;
              }

              context.read<AuthModel>().updateProfile(
                    nameController.text.trim(),
                    ticketController.text.trim(),
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Профіль збережено')),
              );
            },
            child: const Text('Зберегти профіль'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              context.read<AuthModel>().logout();
              context.go('/catalog');
            },
            icon: const Icon(Icons.logout),
            label: const Text('Вийти'),
          ),
        ],
      ),
    );
  }
}