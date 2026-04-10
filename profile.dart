import 'package:flutter/material.dart';

void main() {
  runApp(const VolunteerApp());
}

class VolunteerApp extends StatelessWidget {
  const VolunteerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer Hero',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F5F0),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE53935)),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 3; // Profile tab selected

  final List<Widget> _screens = [
    const Center(child: Text('Home')),
    const Center(child: Text('Map')),
    const Center(child: Text('Train')),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildSOSButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildSOSButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 80,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFE53935),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE53935).withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'SOS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      elevation: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_outlined, 'Home', 0),
            _navItem(Icons.map_outlined, 'Map', 1),
            const SizedBox(width: 56),
            _navItem(Icons.fitness_center_outlined, 'Train', 2),
            _navItem(Icons.person_outline, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? const Color(0xFFE53935) : Colors.grey;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          Text(label, style: TextStyle(color: color, fontSize: 11)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PROFILE SCREEN
// ─────────────────────────────────────────────
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
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
              _buildSettingsSection(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Good morning,',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            Text('Ravi Kumar',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
          ],
        ),
        Row(
          children: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, size: 28),
                  onPressed: () {},
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE53935),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Text(
                'RK',
                style: TextStyle(
                  color: const Color(0xFF2E7D32),
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

  // ── Hero Card ─────────────────────────────
  Widget _buildHeroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE53935),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE53935).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar + title row
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: const Text(
                  'RK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.shield, color: Colors.white70, size: 14),
                        const SizedBox(width: 4),
                        const Text('Hero Level 3',
                            style: TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text('Active Volunteer',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.circle, color: Color(0xFF66BB6A), size: 8),
                    SizedBox(width: 5),
                    Text('Active',
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // XP Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('XP Progress',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
              Text('680 / 1000 XP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.68,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 14),

          // Skills chips
          Row(
            children: [
              const Text('Skills: ',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
              _skillChip('First Aid'),
              const SizedBox(width: 6),
              _skillChip('CPR'),
              const SizedBox(width: 6),
              _skillChip('Fire Safety'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _skillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  // ── Stats Row ─────────────────────────────
  Widget _buildStatsRow() {
    return Row(
      children: [
        _statCard(
          icon: Icons.check_circle_outline,
          iconColor: const Color(0xFF43A047),
          value: '14',
          label: 'Missions done',
        ),
        const SizedBox(width: 12),
        _statCard(
          icon: Icons.people_outline,
          iconColor: const Color(0xFFE53935),
          value: '7',
          label: 'Nearby heroes',
        ),
        const SizedBox(width: 12),
        _statCard(
          icon: Icons.bar_chart,
          iconColor: const Color(0xFFF9A825),
          value: '#42',
          label: 'Your rank',
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 6),
            Text(value,
                style: TextStyle(
                    color: iconColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(color: Colors.black54, fontSize: 11),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  // ── Skills Section ────────────────────────
  Widget _buildSkillsSection() {
    final skills = [
      {'title': 'First Aid', 'level': 'Advanced', 'progress': 0.85, 'color': const Color(0xFFE53935)},
      {'title': 'CPR', 'level': 'Intermediate', 'progress': 0.60, 'color': const Color(0xFF1E88E5)},
      {'title': 'Fire Safety', 'level': 'Beginner', 'progress': 0.35, 'color': const Color(0xFFF57C00)},
    ];

    return _sectionCard(
      title: 'My Skills',
      child: Column(
        children: skills.map((s) {
          final color = s['color'] as Color;
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(s['title'] as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    Text(s['level'] as String,
                        style: TextStyle(color: color, fontSize: 12)),
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

  // ── Achievements ──────────────────────────
  Widget _buildAchievementsSection() {
    final badges = [
      {'icon': Icons.local_fire_department, 'color': const Color(0xFFE53935), 'label': 'First\nResponder'},
      {'icon': Icons.favorite, 'color': const Color(0xFFD81B60), 'label': 'Life\nSaver'},
      {'icon': Icons.emoji_events, 'color': const Color(0xFFF9A825), 'label': 'Top\nVolunteer'},
      {'icon': Icons.shield, 'color': const Color(0xFF1565C0), 'label': 'Hero\nLevel 3'},
    ];

    return _sectionCard(
      title: 'Achievements',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: badges.map((b) {
          final color = b['color'] as Color;
          return Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(b['icon'] as IconData, color: color, size: 26),
              ),
              const SizedBox(height: 6),
              Text(
                b['label'] as String,
                style: const TextStyle(fontSize: 11, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ── Mission History ───────────────────────
  Widget _buildMissionHistory() {
    final missions = [
      {'title': 'Cardiac Arrest Response', 'location': 'Anna Nagar', 'date': 'Apr 8, 2026', 'xp': '+120 XP'},
      {'title': 'Fire Safety Drill', 'location': 'T. Nagar', 'date': 'Apr 5, 2026', 'xp': '+80 XP'},
      {'title': 'First Aid Support', 'location': 'Adyar', 'date': 'Apr 2, 2026', 'xp': '+100 XP'},
    ];

    return _sectionCard(
      title: 'Recent Missions',
      child: Column(
        children: missions.asMap().entries.map((entry) {
          final m = entry.value;
          final isLast = entry.key == missions.length - 1;
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE53935).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.check_circle,
                        color: Color(0xFFE53935), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m['title']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13)),
                        Text('${m['location']} • ${m['date']}',
                            style: const TextStyle(
                                color: Colors.black45, fontSize: 12)),
                      ],
                    ),
                  ),
                  Text(m['xp']!,
                      style: const TextStyle(
                          color: Color(0xFF43A047),
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
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

  // ── Settings Section ──────────────────────
  Widget _buildSettingsSection() {
    final items = [
      {'icon': Icons.edit_outlined, 'label': 'Edit Profile'},
      {'icon': Icons.notifications_outlined, 'label': 'Notification Settings'},
      {'icon': Icons.privacy_tip_outlined, 'label': 'Privacy & Safety'},
      {'icon': Icons.help_outline, 'label': 'Help & Support'},
      {'icon': Icons.logout, 'label': 'Sign Out', 'isRed': true},
    ];

    return _sectionCard(
      title: 'Settings',
      child: Column(
        children: items.asMap().entries.map((entry) {
          final item = entry.value;
          final isRed = item['isRed'] == true;
          final isLast = entry.key == items.length - 1;
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: Icon(item['icon'] as IconData,
                    color: isRed
                        ? const Color(0xFFE53935)
                        : Colors.black54,
                    size: 22),
                title: Text(item['label'] as String,
                    style: TextStyle(
                        fontSize: 14,
                        color: isRed
                            ? const Color(0xFFE53935)
                            : Colors.black87,
                        fontWeight: isRed
                            ? FontWeight.w600
                            : FontWeight.normal)),
                trailing: isRed
                    ? null
                    : const Icon(Icons.chevron_right,
                        color: Colors.black38, size: 20),
                onTap: () {},
              ),
              if (!isLast) Divider(color: Colors.grey.shade100, height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ── Reusable Section Card ─────────────────
  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
