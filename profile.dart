// profile.dart — Profile widgets (imported by main.dart)
import 'package:flutter/material.dart';

// ─── Shared colors (re-declared to avoid cross-file dependency issues) ────────
class _PC {
  static const Color red = Color(0xFFE24B4A);
  static const Color redLight = Color(0xFFFCEBEB);
  static const Color teal = Color(0xFF1D9E75);
  static const Color tealLight = Color(0xFFE1F5EE);
  static const Color amber = Color(0xFFBA7517);
  static const Color amberLight = Color(0xFFFAEEDA);
  static const Color blue = Color(0xFF1D4ED8);
  static const Color blueLight = Color(0xFFEFF6FF);
  static const Color gemini = Color(0xFF4285F4);
  static const Color geminiLight = Color(0xFFE8F0FE);
  static const Color text = Color(0xFF1A1A1A);
  static const Color muted = Color(0xFF6B6B6B);
  static const Color border = Color(0xFFE8E8E8);
  static const Color bg = Color(0xFFF7F6F3);
  static const Color white = Colors.white;
}

// ══════════════════════════════════════════════════════════════════════════════
//  VOLUNTEER PROFILE TAB
// ══════════════════════════════════════════════════════════════════════════════
class VolunteerProfileTab extends StatelessWidget {
  final Map<String, dynamic> user;
  const VolunteerProfileTab({super.key, required this.user});

  static const _skills = [
    {
      'title': 'First Aid',
      'level': 'Advanced',
      'progress': 0.85,
      'color': _PC.red,
    },
    {
      'title': 'CPR',
      'level': 'Intermediate',
      'progress': 0.60,
      'color': _PC.gemini,
    },
    {
      'title': 'Fire Safety',
      'level': 'Beginner',
      'progress': 0.35,
      'color': _PC.amber,
    },
  ];

  static const _badges = [
    {
      'icon': Icons.local_fire_department,
      'color': _PC.red,
      'bg': _PC.redLight,
      'label': 'First\nResponder',
    },
    {
      'icon': Icons.favorite,
      'color': Color(0xFFD81B60),
      'bg': Color(0xFFFCE4EC),
      'label': 'Life\nSaver',
    },
    {
      'icon': Icons.emoji_events,
      'color': _PC.amber,
      'bg': _PC.amberLight,
      'label': 'Top\nVolunteer',
    },
    {
      'icon': Icons.shield,
      'color': _PC.blue,
      'bg': _PC.blueLight,
      'label': 'Hero\nLevel 3',
    },
  ];

  static const _missions = [
    {
      'title': 'Cardiac Arrest Response',
      'location': 'Anna Nagar',
      'date': 'Apr 8, 2026',
      'xp': '+120 XP',
    },
    {
      'title': 'Fire Safety Drill',
      'location': 'T. Nagar',
      'date': 'Apr 5, 2026',
      'xp': '+80 XP',
    },
    {
      'title': 'First Aid Support',
      'location': 'Adyar',
      'date': 'Apr 2, 2026',
      'xp': '+100 XP',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildHeroCard(),
            const SizedBox(height: 16),
            _buildStatsRow(),
            const SizedBox(height: 16),
            _buildSkillsSection(),
            const SizedBox(height: 16),
            _buildAchievementsSection(),
            const SizedBox(height: 16),
            _buildMissionHistory(),
            const SizedBox(height: 16),
            _buildSettingsSection(context),
          ],
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good morning,',
              style: TextStyle(fontSize: 13, color: _PC.muted),
            ),
            Text(
              user['name'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _PC.text,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, size: 26),
                  onPressed: () {},
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: _PC.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: _PC.tealLight,
              child: Text(
                user['initials'],
                style: const TextStyle(
                  color: _PC.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Hero Card ─────────────────────────────────────────────────────────────
  Widget _buildHeroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _PC.red,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _PC.red.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Text(
                  user['initials'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.shield,
                          color: Colors.white70,
                          size: 13,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Hero Level ${user['level']}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Active Volunteer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _activePill(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'XP Progress',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
              Text(
                '${user['xp']} / ${user['xpMax']} XP',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: user['xp'] / user['xpMax'],
              minHeight: 7,
              backgroundColor: Colors.white.withOpacity(0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                'Skills: ',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 12,
                ),
              ),
              Expanded(
                child: Wrap(
                  spacing: 6,
                  children: (user['skills'] as List<String>)
                      .map(
                        (s) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            s,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _activePill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.circle, color: Color(0xFF66BB6A), size: 8),
          SizedBox(width: 5),
          Text('Active', style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  // ── Stats Row ─────────────────────────────────────────────────────────────
  Widget _buildStatsRow() {
    return Row(
      children: [
        _statCard(
          Icons.check_circle_outline,
          _PC.teal,
          '${user['missionsCompleted']}',
          'Missions done',
        ),
        const SizedBox(width: 12),
        _statCard(
          Icons.people_outline,
          _PC.red,
          '${user['nearbyHeroes']}',
          'Nearby heroes',
        ),
        const SizedBox(width: 12),
        _statCard(Icons.bar_chart, _PC.amber, '#${user['rank']}', 'Your rank'),
      ],
    );
  }

  Widget _statCard(IconData icon, Color color, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: _PC.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(color: _PC.muted, fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ── Skills ────────────────────────────────────────────────────────────────
  Widget _buildSkillsSection() {
    return _sectionCard(
      title: 'My Skills',
      child: Column(
        children: _skills.asMap().entries.map((e) {
          final s = e.value;
          final color = s['color'] as Color;
          final isLast = e.key == _skills.length - 1;
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      s['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      s['level'] as String,
                      style: TextStyle(color: color, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: s['progress'] as double,
                    minHeight: 7,
                    backgroundColor: color.withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Achievements ──────────────────────────────────────────────────────────
  Widget _buildAchievementsSection() {
    return _sectionCard(
      title: 'Achievements',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _badges.map((b) {
          final color = b['color'] as Color;
          final bg = b['bg'] as Color;
          return Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                child: Icon(b['icon'] as IconData, color: color, size: 24),
              ),
              const SizedBox(height: 6),
              Text(
                b['label'] as String,
                style: const TextStyle(fontSize: 10, color: _PC.muted),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ── Mission History ───────────────────────────────────────────────────────
  Widget _buildMissionHistory() {
    return _sectionCard(
      title: 'Recent Missions',
      child: Column(
        children: _missions.asMap().entries.map((e) {
          final m = e.value;
          final isLast = e.key == _missions.length - 1;
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _PC.redLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: _PC.red,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '${m['location']} • ${m['date']}',
                          style: const TextStyle(
                            color: _PC.muted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    m['xp']!,
                    style: const TextStyle(
                      color: _PC.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              if (!isLast)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(color: Colors.grey.shade100, height: 1),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ── Settings ──────────────────────────────────────────────────────────────
  Widget _buildSettingsSection(BuildContext context) {
    final items = [
      {
        'icon': Icons.edit_outlined,
        'label': 'Edit Profile',
        'sub': 'Name, photo, bio',
      },
      {
        'icon': Icons.notifications_outlined,
        'label': 'Notification Settings',
        'sub': 'Alerts, missions, updates',
      },
      {
        'icon': Icons.location_on_outlined,
        'label': 'Location & Radius',
        'sub': '5 km active zone',
      },
      {
        'icon': Icons.privacy_tip_outlined,
        'label': 'Privacy & Safety',
        'sub': 'Visibility, data controls',
      },
      {
        'icon': Icons.help_outline,
        'label': 'Help & Support',
        'sub': 'FAQs, contact us',
      },
      {'icon': Icons.logout, 'label': 'Sign Out', 'isRed': true},
    ];

    return _sectionCard(
      title: 'Settings',
      child: Column(
        children: items.asMap().entries.map((e) {
          final item = e.value;
          final isRed = item['isRed'] == true;
          final isLast = e.key == items.length - 1;
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: isRed ? _PC.redLight : const Color(0xFFF1EFE8),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: isRed ? _PC.red : _PC.muted,
                    size: 18,
                  ),
                ),
                title: Text(
                  item['label'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: isRed ? _PC.red : _PC.text,
                    fontWeight: isRed ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                subtitle: item['sub'] != null
                    ? Text(
                        item['sub'] as String,
                        style: const TextStyle(fontSize: 11, color: _PC.muted),
                      )
                    : null,
                trailing: isRed
                    ? null
                    : const Icon(
                        Icons.chevron_right,
                        color: _PC.muted,
                        size: 20,
                      ),
                onTap: () {
                  if (isRed) {
                    // Pop back to role selection
                    Navigator.of(context).popUntil((r) => r.isFirst);
                  }
                },
              ),
              if (!isLast) Divider(color: Colors.grey.shade100, height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ── Shared card ───────────────────────────────────────────────────────────
  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _PC.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _PC.text,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  AUTHORISED PERSON PROFILE TAB  (re-exported for completeness — also used
//  inline in main.dart's _AuthorisedProfileTab, kept here for standalone use)
// ══════════════════════════════════════════════════════════════════════════════
class AuthorisedPersonProfileTab extends StatelessWidget {
  final Map<String, dynamic> officer;
  const AuthorisedPersonProfileTab({super.key, required this.officer});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page title
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Officer Profile',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: _PC.text,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _PC.blueLight,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _PC.blue.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.verified_user_rounded,
                        size: 12,
                        color: _PC.blue,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        officer['badgeId'] ?? '',
                        style: const TextStyle(
                          fontSize: 11,
                          color: _PC.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Officer ID card
            _officerCard(),
            const SizedBox(height: 20),
            // Stats
            _buildStatsRow(),
            const SizedBox(height: 20),
            // Settings
            _buildSettingsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _officerCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _PC.blue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _PC.blue.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Text(
                  officer['initials'] ?? 'OF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.verified_user_rounded,
                          color: Colors.white70,
                          size: 13,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Authorised Officer',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      officer['name'] ?? 'Officer',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.circle, color: Color(0xFF4ADE80), size: 8),
                    SizedBox(width: 5),
                    Text(
                      'On Duty',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _detail(Icons.badge_outlined, 'Badge ID', officer['badgeId'] ?? '—'),
          const SizedBox(height: 8),
          _detail(
            Icons.location_city_rounded,
            'Jurisdiction',
            officer['jurisdiction'] ?? '—',
          ),
          const SizedBox(height: 8),
          _detail(
            Icons.account_balance_rounded,
            'Department',
            officer['department'] ?? '—',
          ),
        ],
      ),
    );
  }

  Widget _detail(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 13),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 11, color: Colors.white70),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _statCard(
          'Active Incidents',
          '2',
          Icons.warning_rounded,
          _PC.red,
          _PC.redLight,
        ),
        const SizedBox(width: 12),
        _statCard(
          'On-field Today',
          '17',
          Icons.people_rounded,
          _PC.teal,
          _PC.tealLight,
        ),
        const SizedBox(width: 12),
        _statCard(
          'Resolved',
          '5',
          Icons.check_circle_rounded,
          _PC.amber,
          _PC.amberLight,
        ),
      ],
    );
  }

  Widget _statCard(
    String label,
    String value,
    IconData icon,
    Color color,
    Color bg,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: _PC.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 15, color: color),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9, color: _PC.muted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    final items = [
      {
        'icon': Icons.edit_outlined,
        'label': 'Edit Profile',
        'sub': 'Name, badge, department',
      },
      {
        'icon': Icons.notifications_outlined,
        'label': 'Alert Preferences',
        'sub': 'Push, SMS, radio',
      },
      {
        'icon': Icons.security_outlined,
        'label': 'Access & Permissions',
        'sub': 'Manage access levels',
      },
      {
        'icon': Icons.help_outline,
        'label': 'Help & Support',
        'sub': 'FAQs, contact control room',
      },
      {'icon': Icons.logout, 'label': 'Sign Out', 'isRed': true},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _PC.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _PC.text,
            ),
          ),
          const SizedBox(height: 12),
          ...items.asMap().entries.map((e) {
            final item = e.value;
            final isRed = item['isRed'] == true;
            final isLast = e.key == items.length - 1;
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: isRed ? _PC.redLight : _PC.blueLight,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: isRed ? _PC.red : _PC.blue,
                      size: 18,
                    ),
                  ),
                  title: Text(
                    item['label'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      color: isRed ? _PC.red : _PC.text,
                      fontWeight: isRed ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  subtitle: item['sub'] != null
                      ? Text(
                          item['sub'] as String,
                          style: const TextStyle(
                            fontSize: 11,
                            color: _PC.muted,
                          ),
                        )
                      : null,
                  trailing: isRed
                      ? null
                      : const Icon(
                          Icons.chevron_right,
                          color: _PC.muted,
                          size: 20,
                        ),
                  onTap: () {
                    if (isRed) {
                      Navigator.of(context).popUntil((r) => r.isFirst);
                    }
                  },
                ),
                if (!isLast) Divider(color: Colors.grey.shade100, height: 1),
              ],
            );
          }),
        ],
      ),
    );
  }
}
