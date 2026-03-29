// lib/features/auth/presentation/widgets/role_selector.dart

import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

class RoleSelector extends StatelessWidget {
  final UserRole selectedRole;
  final void Function(UserRole) onRoleSelected;

  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
  });

  Widget _buildRoleCard({
    required IconData icon,
    required String title,
    required UserRole role,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onRoleSelected(role),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6366F1) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF6366F1)
                  : Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black87,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildRoleCard(
          icon: Icons.person,
          title: 'Job Seeker',
          role: UserRole.jobSeeker,
          isSelected: selectedRole == UserRole.jobSeeker,
        ),
        const SizedBox(width: 12),
        _buildRoleCard(
          icon: Icons.work,
          title: 'Employer',
          role: UserRole.employer,
          isSelected: selectedRole == UserRole.employer,
        ),
      ],
    );
  }
}
