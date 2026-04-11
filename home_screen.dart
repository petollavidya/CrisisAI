// home_screen.dart
import 'package:flutter/material.dart';
import 'profile.dart';

void main() {
  runApp(const CitizenHeroApp());
}

class CitizenHeroApp extends StatelessWidget {
  const CitizenHeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Citizen Hero Network',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE24B4A)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}

// ─── App-wide shared data store ───────────────────────────────────────────────
class AppData {
  static Map<String, dynamic> volunteerProfile = {
    'name': '',
    'email': '',
    'username': '',
    'contactNumber': '',
    'age': '',
    'address': '',
    'gender': '',
    'skills': <String>[],
    'initials': '',
    'level': 3,
    'xp': 680,
    'xpMax': 1000,
    'missionsCompleted': 14,
    'nearbyHeroes': 7,
    'rank': 42,
    'isActive': true,
  };

  static Map<String, dynamic> authorisedProfile = {
    'name': '',
    'email': '',
    'username': '',
    'id': '',
    'password': '',
    'department': '',
    'badgeId': 'AUTH-001',
    'jurisdiction': 'Chennai District',
    'initials': '',
  };

  static String loginType = 'volunteer'; // 'volunteer' or 'authorised'
}

// ─── Colors ───────────────────────────────────────────────────────────────────
class AppColors {
  static const Color red = Color(0xFFE24B4A);
  static const Color redDark = Color(0xFFA32D2D);
  static const Color redLight = Color(0xFFFCEBEB);
  static const Color teal = Color(0xFF1D9E75);
  static const Color tealLight = Color(0xFFE1F5EE);
  static const Color amber = Color(0xFFBA7517);
  static const Color amberLight = Color(0xFFFAEEDA);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color border = Color(0xFFE8E8E8);
  static const Color background = Color(0xFFF7F6F3);
  static const Color white = Colors.white;
  static const Color gemini = Color(0xFF4285F4);
  static const Color geminiLight = Color(0xFFE8F0FE);
  static const Color blue = Color(0xFF1D4ED8);
  static const Color blueLight = Color(0xFFEFF6FF);
}

// ══════════════════════════════════════════════════════════════════════════════
//  LOGIN SCREEN
// ══════════════════════════════════════════════════════════════════════════════
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  String _selectedRole = ''; // '' | 'volunteer' | 'authorised'
  final _volunteerEmailCtrl = TextEditingController();
  final _volunteerPasswordCtrl = TextEditingController();
  final _authIdCtrl = TextEditingController();
  final _authPasswordCtrl = TextEditingController();
  final _authDeptCtrl = TextEditingController();
  final _authNameCtrl = TextEditingController();
  final _authEmailCtrl = TextEditingController();
  bool _obscureVPass = true;
  bool _obscureAPass = true;
  bool _isLoading = false;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _volunteerEmailCtrl.dispose();
    _volunteerPasswordCtrl.dispose();
    _authIdCtrl.dispose();
    _authPasswordCtrl.dispose();
    _authDeptCtrl.dispose();
    _authNameCtrl.dispose();
    _authEmailCtrl.dispose();
    super.dispose();
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return 'U';
  }

  void _loginVolunteer() async {
    if (_volunteerEmailCtrl.text.trim().isEmpty ||
        _volunteerPasswordCtrl.text.trim().isEmpty) {
      _showError('Please enter your email and password.');
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    final email = _volunteerEmailCtrl.text.trim();
    final name = email.split('@')[0];
    AppData.volunteerProfile['email'] = email;
    AppData.volunteerProfile['name'] = name;
    AppData.volunteerProfile['initials'] = _initials(name);
    AppData.volunteerProfile['username'] = name.toLowerCase().replaceAll(
      ' ',
      '_',
    );
    AppData.loginType = 'volunteer';
    setState(() => _isLoading = false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void _loginAuthorised() async {
    if (_authNameCtrl.text.trim().isEmpty ||
        _authEmailCtrl.text.trim().isEmpty ||
        _authIdCtrl.text.trim().isEmpty ||
        _authPasswordCtrl.text.trim().isEmpty ||
        _authDeptCtrl.text.trim().isEmpty) {
      _showError('Please fill all fields.');
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    final name = _authNameCtrl.text.trim();
    final email = _authEmailCtrl.text.trim();
    AppData.authorisedProfile['name'] = name;
    AppData.authorisedProfile['email'] = email;
    AppData.authorisedProfile['id'] = _authIdCtrl.text.trim();
    AppData.authorisedProfile['password'] = _authPasswordCtrl.text.trim();
    AppData.authorisedProfile['department'] = _authDeptCtrl.text.trim();
    AppData.authorisedProfile['initials'] = _initials(name);
    AppData.authorisedProfile['username'] = email
        .split('@')[0]
        .toLowerCase()
        .replaceAll(' ', '_');
    AppData.loginType = 'authorised';
    setState(() => _isLoading = false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo area
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.red.withOpacity(0.35),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.shield,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Citizen Hero Network',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Empowering communities, saving lives',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Role selection
                if (_selectedRole.isEmpty) ...[
                  const Text(
                    'Choose your role to continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _roleCard(
                    icon: Icons.volunteer_activism,
                    color: AppColors.teal,
                    bg: AppColors.tealLight,
                    title: 'Volunteer Login',
                    subtitle: 'Join missions, earn XP, help your community',
                    onTap: () => setState(() => _selectedRole = 'volunteer'),
                  ),
                  const SizedBox(height: 14),
                  _roleCard(
                    icon: Icons.verified_user_rounded,
                    color: AppColors.blue,
                    bg: AppColors.blueLight,
                    title: 'Authorised Person Login',
                    subtitle: 'Officers, coordinators & authorised personnel',
                    onTap: () => setState(() => _selectedRole = 'authorised'),
                  ),
                ],

                // Volunteer login form
                if (_selectedRole == 'volunteer') ...[
                  _backButton(),
                  const SizedBox(height: 8),
                  _sectionHeader(
                    'Volunteer Login',
                    Icons.volunteer_activism,
                    AppColors.teal,
                  ),
                  const SizedBox(height: 24),
                  _inputField(
                    controller: _volunteerEmailCtrl,
                    label: 'Email Address',
                    hint: 'Enter your email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),
                  _passwordField(
                    controller: _volunteerPasswordCtrl,
                    label: 'Password',
                    hint: 'Enter your password',
                    obscure: _obscureVPass,
                    onToggle: () =>
                        setState(() => _obscureVPass = !_obscureVPass),
                  ),
                  const SizedBox(height: 28),
                  _loginButton(
                    label: 'Sign In as Volunteer',
                    color: AppColors.teal,
                    isLoading: _isLoading,
                    onTap: _loginVolunteer,
                  ),
                ],

                // Authorised login form
                if (_selectedRole == 'authorised') ...[
                  _backButton(),
                  const SizedBox(height: 8),
                  _sectionHeader(
                    'Authorised Person Login',
                    Icons.verified_user_rounded,
                    AppColors.blue,
                  ),
                  const SizedBox(height: 24),
                  _inputField(
                    controller: _authNameCtrl,
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 14),
                  _inputField(
                    controller: _authEmailCtrl,
                    label: 'Email Address',
                    hint: 'Enter your email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),
                  _inputField(
                    controller: _authIdCtrl,
                    label: 'Officer / Staff ID',
                    hint: 'Enter your official ID',
                    icon: Icons.badge_outlined,
                  ),
                  const SizedBox(height: 14),
                  _passwordField(
                    controller: _authPasswordCtrl,
                    label: 'Password',
                    hint: 'Enter your password',
                    obscure: _obscureAPass,
                    onToggle: () =>
                        setState(() => _obscureAPass = !_obscureAPass),
                  ),
                  const SizedBox(height: 14),
                  _inputField(
                    controller: _authDeptCtrl,
                    label: 'Department',
                    hint: 'e.g. Police, Fire Dept, Medical',
                    icon: Icons.account_balance_outlined,
                  ),
                  const SizedBox(height: 28),
                  _loginButton(
                    label: 'Sign In as Authorised Person',
                    color: AppColors.blue,
                    isLoading: _isLoading,
                    onTap: _loginAuthorised,
                  ),
                ],

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = ''),
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            'Back to role selection',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _roleCard({
    required IconData icon,
    required Color color,
    required Color bg,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(0.25), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: color),
          ],
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
            prefixIcon: Icon(icon, size: 18, color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
            prefixIcon: const Icon(
              Icons.lock_outline,
              size: 18,
              color: AppColors.textSecondary,
            ),
            suffixIcon: GestureDetector(
              onTap: onToggle,
              child: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginButton({
    required String label,
    required Color color,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 4,
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  HOME SCREEN
// ══════════════════════════════════════════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late AnimationController _fadeController;
  late AnimationController _alertPulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _alertPulse;

  Map<String, dynamic> get _user => AppData.loginType == 'volunteer'
      ? AppData.volunteerProfile
      : AppData.authorisedProfile;

  final List<Map<String, dynamic>> _nearbyAlerts = [
    {
      'type': 'Medical',
      'title': 'Cardiac arrest reported',
      'location': 'Anna Nagar, 0.8 km',
      'time': '2 min ago',
      'urgency': 'high',
      'volunteersNeeded': 2,
    },
    {
      'type': 'Fire',
      'title': 'Small fire at apartment',
      'location': 'T. Nagar, 2.1 km',
      'time': '8 min ago',
      'urgency': 'medium',
      'volunteersNeeded': 3,
    },
  ];

  final List<Map<String, dynamic>> _dailyTasks = [
    {
      'title': 'CPR refresher quiz',
      'xp': 30,
      'duration': '5 min',
      'done': true,
      'color': AppColors.teal,
      'icon': Icons.favorite_outline,
    },
    {
      'title': 'Fire extinguisher drill',
      'xp': 40,
      'duration': '8 min',
      'done': false,
      'progress': 0.35,
      'color': AppColors.amber,
      'icon': Icons.local_fire_department_outlined,
    },
    {
      'title': 'Flood response basics',
      'xp': 50,
      'duration': '12 min',
      'done': false,
      'locked': true,
      'color': AppColors.textSecondary,
      'icon': Icons.water_outlined,
    },
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..forward();

    _alertPulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _alertPulse = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _alertPulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _alertPulseController.dispose();
    super.dispose();
  }

  Widget _buildCurrentTab() {
    switch (_selectedIndex) {
      case 3:
        if (AppData.loginType == 'volunteer') {
          return VolunteerProfileTab(user: AppData.volunteerProfile);
        } else {
          return AuthorisedPersonProfileTab(officer: AppData.authorisedProfile);
        }
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildHeroCard(),
                  const SizedBox(height: 20),
                  _buildGeminiInsightCard(),
                  const SizedBox(height: 20),
                  _buildStatsRow(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Nearby emergencies', showBadge: true),
                  const SizedBox(height: 12),
                  _buildAlertsList(),
                  const SizedBox(height: 24),
                  _buildSectionTitle("Today's training"),
                  const SizedBox(height: 12),
                  _buildTrainingTasks(),
                  const SizedBox(height: 24),
                  _buildLiveMapCard(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildCurrentTab(),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _selectedIndex == 0 ? _buildSOSButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      floating: true,
      pinned: false,
      expandedHeight: 70,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Good morning,',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  _user['name'] ?? 'Hero',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                _buildIconBtn(Icons.notifications_outlined, () {}, badge: true),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => setState(() => _selectedIndex = 3),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.tealLight,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.teal, width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        _user['initials'] ?? 'U',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.teal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBtn(
    IconData icon,
    VoidCallback onTap, {
    bool badge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
            child: Icon(icon, size: 20, color: AppColors.textPrimary),
          ),
          if (badge)
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    final skills =
        (_user['skills'] as List<dynamic>?)?.cast<String>() ?? ['Volunteer'];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.red.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _user['initials'] ?? 'U',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
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
                        const Icon(Icons.shield, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          AppData.loginType == 'volunteer'
                              ? 'Hero Level ${_user['level']}'
                              : 'Authorised Officer',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppData.loginType == 'volunteer'
                          ? 'Active Volunteer'
                          : (_user['department'] ?? 'Department'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4ADE80),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Active',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (AppData.loginType == 'volunteer') ...[
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'XP Progress',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    Text(
                      '${_user['xp']} / ${_user['xpMax']} XP',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (_user['xp'] as int) / (_user['xpMax'] as int),
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Text(
                  'Skills: ',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    children: skills
                        .map(
                          (s) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              s,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
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
        ],
      ),
    );
  }

  Widget _buildGeminiInsightCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.geminiLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gemini.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.gemini,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Gemini AI Insight',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gemini,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gemini.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Powered by Gemini',
                        style: TextStyle(
                          fontSize: 9,
                          color: AppColors.gemini,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'You\'re 320 XP away from Level 4. Complete the fire safety module today — it matches 2 open emergencies in your area.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _showGeminiChat(context),
                  child: const Row(
                    children: [
                      Text(
                        'Ask Gemini for guidance',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.gemini,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: AppColors.gemini,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard(
          'Missions done',
          '${_user['missionsCompleted'] ?? 0}',
          Icons.check_circle_outline,
          AppColors.teal,
          AppColors.tealLight,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          'Nearby heroes',
          '${_user['nearbyHeroes'] ?? 0}',
          Icons.people_outline,
          AppColors.red,
          AppColors.redLight,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          'Your rank',
          '#${_user['rank'] ?? 42}',
          Icons.leaderboard_outlined,
          AppColors.amber,
          AppColors.amberLight,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
    Color bgColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showBadge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        Row(
          children: [
            if (showBadge)
              AnimatedBuilder(
                animation: _alertPulse,
                builder: (context, child) => Transform.scale(
                  scale: _alertPulse.value,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            if (showBadge) const SizedBox(width: 6),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'See all',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAlertsList() {
    return Column(
      children: _nearbyAlerts.map((alert) => _buildAlertCard(alert)).toList(),
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    final bool isHigh = alert['urgency'] == 'high';
    final Color urgencyColor = isHigh ? AppColors.red : AppColors.amber;
    final Color urgencyBg = isHigh ? AppColors.redLight : AppColors.amberLight;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isHigh ? AppColors.red.withOpacity(0.3) : AppColors.border,
          width: isHigh ? 1 : 0.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: urgencyBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              alert['type'] == 'Medical'
                  ? Icons.favorite_outline
                  : Icons.local_fire_department_outlined,
              color: urgencyColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        alert['title'],
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: urgencyBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isHigh ? 'Urgent' : 'Active',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: urgencyColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      alert['location'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      alert['time'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 32,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: urgencyColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text(
                            'Respond',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 32,
                      child: OutlinedButton.icon(
                        onPressed: () => _showGeminiChat(context),
                        icon: const Icon(
                          Icons.auto_awesome,
                          size: 12,
                          color: AppColors.gemini,
                        ),
                        label: const Text(
                          'AI Guide',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.gemini,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: AppColors.gemini.withOpacity(0.4),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingTasks() {
    return Column(
      children: _dailyTasks.map((task) => _buildTaskRow(task)).toList(),
    );
  }

  Widget _buildTaskRow(Map<String, dynamic> task) {
    final bool locked = task['locked'] ?? false;
    final bool done = task['done'] ?? false;
    final double progress = task['progress'] ?? 0.0;

    return Opacity(
      opacity: locked ? 0.5 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: (task['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                task['icon'] as IconData,
                size: 20,
                color: task['color'] as Color,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task['title'],
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        '+${task['xp']} XP',
                        style: TextStyle(
                          fontSize: 11,
                          color: task['color'] as Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        task['duration'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  if (!done && !locked && progress > 0) ...[
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: AppColors.border,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          task['color'] as Color,
                        ),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (done)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.tealLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else if (locked)
              const Icon(
                Icons.lock_outline,
                size: 18,
                color: AppColors.textSecondary,
              )
            else
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.redLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveMapCard() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomPaint(
              size: const Size(double.infinity, 160),
              painter: MapGridPainter(),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.35,
            top: 80,
            child: _mapPin(AppColors.gemini, Icons.person, 'You'),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.55,
            top: 45,
            child: _mapPin(AppColors.red, Icons.warning_amber_rounded, '!'),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.22,
            top: 60,
            child: _mapPin(AppColors.teal, Icons.shield, ''),
          ),
          Positioned(
            bottom: 10,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.92),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: const Text(
                'Live coverage map — Chennai',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.redLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '1 incident nearby',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapPin(Color color, IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 14, color: Colors.white),
        ),
        if (label.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 9, color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget _buildSOSButton() {
    return AnimatedBuilder(
      animation: _alertPulse,
      builder: (context, child) => Transform.scale(
        scale: _alertPulse.value,
        child: FloatingActionButton.extended(
          onPressed: () => _showSOSDialog(context),
          backgroundColor: AppColors.red,
          elevation: 6,
          icon: const Icon(Icons.sos, color: Colors.white),
          label: const Text(
            'SOS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      color: AppColors.white,
      elevation: 8,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_outlined, Icons.home, 'Home', 0),
            _navItem(Icons.map_outlined, Icons.map, 'Map', 1),
            const SizedBox(width: 48),
            _navItem(
              Icons.fitness_center_outlined,
              Icons.fitness_center,
              'Train',
              2,
            ),
            _navItem(Icons.person_outline, Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    IconData outlineIcon,
    IconData filledIcon,
    String label,
    int index,
  ) {
    final bool selected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            selected ? filledIcon : outlineIcon,
            size: 22,
            color: selected ? AppColors.red : AppColors.textSecondary,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: selected ? AppColors.red : AppColors.textSecondary,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  void _showGeminiChat(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const GeminiChatSheet(),
    );
  }

  void _showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.sos, color: AppColors.red),
            SizedBox(width: 8),
            Text(
              'Send SOS Alert',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.red,
              ),
            ),
          ],
        ),
        content: const Text(
          'This will alert all nearby volunteers and dispatch emergency services to your location.',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Send SOS',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Map Grid Painter ─────────────────────────────────────────────────────────
class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE8E8E8)
      ..strokeWidth = 0.5;
    for (double x = 0; x <= size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    final roadPaint = Paint()
      ..color = const Color(0xFFD0D0D0)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(0, size.height * 0.5),
      Offset(size.width, size.height * 0.5),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.4, 0),
      Offset(size.width * 0.4, size.height),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─── Gemini Chat Bottom Sheet ─────────────────────────────────────────────────
class GeminiChatSheet extends StatefulWidget {
  const GeminiChatSheet({super.key});
  @override
  State<GeminiChatSheet> createState() => _GeminiChatSheetState();
}

class _GeminiChatSheetState extends State<GeminiChatSheet> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  final List<Map<String, String>> _messages = [
    {
      'role': 'assistant',
      'text':
          'Hi! I\'m your Gemini AI emergency guide. How can I help you prepare or respond today?',
    },
  ];

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    _controller.clear();
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _isTyping = true;
    });
    _scrollDown();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isTyping = false;
      _messages.add({
        'role': 'assistant',
        'text':
            'Based on your CPR certification, here\'s what to do: Check for responsiveness, call for help, start chest compressions at 100-120 per minute, and use an AED if available. I\'m generating a step-by-step guide for you.',
      });
    });
    _scrollDown();
  }

  void _scrollDown() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.gemini,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gemini AI Guide',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Emergency assistance powered by Gemini',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, i) {
                if (_isTyping && i == _messages.length) {
                  return _buildTypingIndicator();
                }
                final msg = _messages[i];
                return _buildMessage(msg['text']!, msg['role'] == 'user');
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.border, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Ask about emergency steps...',
                      hintStyle: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _sendMessage(_controller.text),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.gemini,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        decoration: BoxDecoration(
          color: isUser ? AppColors.gemini : AppColors.geminiLight,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: isUser
                ? const Radius.circular(14)
                : const Radius.circular(4),
            bottomRight: isUser
                ? const Radius.circular(4)
                : const Radius.circular(14),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: isUser ? Colors.white : AppColors.textPrimary,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.geminiLight,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, size: 14, color: AppColors.gemini),
            SizedBox(width: 6),
            Text(
              'Gemini is thinking...',
              style: TextStyle(fontSize: 12, color: AppColors.gemini),
            ),
          ],
        ),
      ),
    );
  }
}
