import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const user = User(
      id: '1',
      name: 'Тарас Кабанець',
      email: 'taras@example.com',
      avatarUrl: '',
      bio: 'Студент. Вивчаю Flutter та розробку мобільних застосунків.',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мій профіль'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: ProfileWidget(
              user: user,
              onEditPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Редагування профілю'),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}