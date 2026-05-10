import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:frontend/core/session/app_session.dart';
import 'package:frontend/shared/widgets/appbar.dart';
import 'package:frontend/utils/router/route_paths.dart';
import 'package:frontend/utils/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmSignOut(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black54,
      builder: (ctx) => const _SignOutConfirmDialog(),
    );
    if (ok == true && context.mounted) {
      AppSession.signOut();
      context.go(RoutePaths.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = AppSession.isAdmin;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: CustomAppBar(
        title: 'Profile',
        back: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const SizedBox(height: 8),
          _AvatarBlock(
            initials: _initials(AppSession.displayName),
          ),
          const SizedBox(height: 16),
          Text(
            AppSession.displayName.isEmpty
                ? 'Guest'
                : AppSession.displayName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            AppSession.email.isEmpty ? '—' : AppSession.email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.grayText,
            ),
          ),
          const SizedBox(height: 16),
          if (isAdmin) ...[
            _RoleBadge(label: 'INSTITUTION ADMIN'),
            const SizedBox(height: 20),
            _InstitutionCard(
              name: AppSession.institutionName,
              subtitle: AppSession.institutionDepartment,
            ),
            const SizedBox(height: 28),
            _sectionLabel('ADMINISTRATION & SECURITY'),
            const SizedBox(height: 10),
            _AdminSignOutTile(
              emailHint: AppSession.email,
              onTap: () => _confirmSignOut(context),
            ),
          ] else ...[
            const SizedBox(height: 8),
            Row(
              children: const [
                Expanded(child: _StatCard(value: '12', label: 'POSTS')),
                SizedBox(width: 12),
                Expanded(child: _StatCard(value: '08', label: 'REPORTS')),
              ],
            ),
            const SizedBox(height: 28),
            _sectionLabel('ACCOUNT OVERVIEW'),
            const SizedBox(height: 10),
            _AccountCard(
              children: [
                _AccountTile(
                  icon: Icons.inventory_2_outlined,
                  title: 'My Posts',
                  onTap: () => context.go(RoutePaths.items),
                ),
                const Divider(height: 1),
                _AccountTile(
                  icon: Icons.flag_outlined,
                  title: 'My Reports',
                  onTap: () => context.push(RoutePaths.reports),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _UserLogoutButton(
              onPressed: () => _confirmSignOut(context),
            ),
          ],
        ],
      ),
    );
  }

  static String _initials(String name) {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.length >= 2
          ? parts.first.substring(0, 2).toUpperCase()
          : parts.first.toUpperCase();
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

class _SignOutConfirmDialog extends StatelessWidget {
  const _SignOutConfirmDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: AppTheme.adminDashboardSurface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppTheme.primaryGreen,
              child: const Icon(Icons.logout, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 20),
            const Text(
              'Confirm Sign Out',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryGreen,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppSession.isAdmin
                  ? 'Are you sure you wish to end your current session? You will need to re-authenticate to access the management portal.'
                  : 'Are you sure you wish to end your current session? You will need to sign in again to continue.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Sign Out Now',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancel & Return',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarBlock extends StatelessWidget {
  final String initials;

  const _AvatarBlock({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.primaryGreen,
        ),
        child: CircleAvatar(
          radius: 52,
          backgroundColor: AppTheme.white,
          child: CircleAvatar(
            radius: 48,
            backgroundColor: const Color(0xFFE8E8E8),
            child: Text(
              initials,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryGreen,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  final String label;

  const _RoleBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: AppTheme.primaryGreen,
          ),
        ),
      ),
    );
  }
}

class _InstitutionCard extends StatelessWidget {
  final String name;
  final String subtitle;

  const _InstitutionCard({
    required this.name,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'INSTITUTION',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.grayText,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.account_balance,
            color: AppTheme.primaryGreen,
            size: 36,
          ),
        ],
      ),
    );
  }
}

class _AdminSignOutTile extends StatelessWidget {
  final String emailHint;
  final VoidCallback onTap;

  const _AdminSignOutTile({
    required this.emailHint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final short = emailHint.isEmpty ? 'this account' : emailHint.split('@').first;
    return Material(
      color: AppTheme.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red.shade700),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Out',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.red.shade700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Terminate session for $short',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red.shade300,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.red.shade400),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryGreen,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final List<Widget> children;

  const _AccountCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _AccountTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _AccountTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.grey.shade800, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.grayText),
      onTap: onTap,
    );
  }
}

class _UserLogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _UserLogoutButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.tonal(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFFFCE8E8),
          foregroundColor: AppTheme.accentRed,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onPressed,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 20),
            SizedBox(width: 8),
            Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _sectionLabel(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
        color: Colors.grey.shade600,
      ),
    ),
  );
}
