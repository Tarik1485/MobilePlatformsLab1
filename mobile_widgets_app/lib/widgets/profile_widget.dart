import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfileWidget extends StatelessWidget {
  final User user;
  final VoidCallback? onEditPressed;
  final bool isCompact;

  const ProfileWidget({
    super.key,
    required this.user,
    this.onEditPressed,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final avatar = CircleAvatar(
      radius: isCompact ? 28 : 42,
      backgroundColor: theme.colorScheme.primaryContainer,
      backgroundImage: user.avatarUrl.isNotEmpty
          ? NetworkImage(user.avatarUrl)
          : null,
      child: user.avatarUrl.isEmpty
          ? Text(
              user.name.isNotEmpty
                  ? user.name[0].toUpperCase()
                  : '?',
              style: theme.textTheme.headlineMedium,
            )
          : null,
    );

    final details = Column(
      crossAxisAlignment: isCompact
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          user.name,
          style: theme.textTheme.titleLarge,
          textAlign: isCompact ? TextAlign.start : TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: theme.textTheme.bodyMedium,
          textAlign: isCompact ? TextAlign.start : TextAlign.center,
        ),
        if (!isCompact && user.bio.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(user.bio, textAlign: TextAlign.center),
        ],
      ],
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: isCompact
            ? Row(
                children: [
                  avatar,
                  const SizedBox(width: 16),
                  Expanded(child: details),
                  if (onEditPressed != null)
                    IconButton(
                      onPressed: onEditPressed,
                      icon: const Icon(Icons.edit_outlined),
                      tooltip: 'Редагувати профіль',
                    ),
                ],
              )
            : Column(
                children: [
                  avatar,
                  const SizedBox(height: 16),
                  details,
                  if (onEditPressed != null) ...[
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: onEditPressed,
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Редагувати'),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}