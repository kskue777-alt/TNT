import 'package:flutter/material.dart';

/// MVP settings screen additions required for the quick PTT widget roll-out.
///
/// The screen surfaces:
/// * a whitelist toggle so specific friends may auto-play voice messages,
/// * guidance on battery optimisation exclusion, and
/// * instructions for keeping notifications always-on.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _autoPlayWhitelistEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          SwitchListTile.adaptive(
            title: const Text('자동 재생 허용(화이트리스트)'),
            subtitle: const Text(
              '신뢰한 친구의 음성 메시지는 홈 위젯에서 바로 재생할 수 있도록 '
              '허용합니다. 기본값은 OFF이며, 동의한 친구만 추가할 수 있습니다.',
            ),
            value: _autoPlayWhitelistEnabled,
            onChanged: (value) {
              setState(() => _autoPlayWhitelistEnabled = value);
              // TODO(mvp-widget-1): Persist whitelist toggle to user settings.
            },
          ),
          const SizedBox(height: 24),
          _SettingsSection(
            icon: Icons.battery_alert_outlined,
            title: '배터리 최적화 제외',
            description: const Text(
              '위젯 업데이트가 안정적으로 동작하려면 기기 배터리 최적화에서 '
              '앱을 제외해야 합니다. 기기 설정 > 앱 > TNT > 배터리에서 "제한 없음" '
              '또는 "최적화 안 함"으로 설정해 주세요.',
            ),
            trailing: TextButton(
              onPressed: () {
                // TODO(mvp-widget-1): Deep-link to battery optimisation settings.
              },
              child: const Text('설정 열기'),
            ),
          ),
          const SizedBox(height: 24),
          _SettingsSection(
            icon: Icons.notifications_active_outlined,
            title: '알림 항상 허용',
            description: const Text(
              'PTT 요청과 긴급 상황을 놓치지 않으려면 알림 권한을 항상 허용으로 '
              '유지하세요. 기기 설정 > 알림 > TNT에서 "알림 허용"과 "사운드"를 '
              '활성화하고, 안드로이드 13 이상에서는 "알림 항상 허용" 옵션을 '
              '선택해 주세요.',
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.icon,
    required this.title,
    required this.description,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final Widget description;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              DefaultTextStyle.merge(
                style: Theme.of(context).textTheme.bodyMedium,
                child: description,
              ),
              if (trailing != null) ...[
                const SizedBox(height: 12),
                Align(alignment: Alignment.centerLeft, child: trailing!),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
