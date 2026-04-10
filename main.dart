import 'package:flutter/material.dart';
import 'train.dart';
import 'map.dart';
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
      ),
      home: const LoginScreen(),
    );
  }
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
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isLoginMode = true;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this)
      ..forward();
    _slideController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this)
      ..forward();
    _pulseController = AnimationController(
        duration: const Duration(milliseconds: 1800), vsync: this)
      ..repeat(reverse: true);

    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(
            begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _slideController, curve: Curves.easeOutCubic));
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.06).animate(
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => const HomeScreen(),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
                parent: animation, curve: Curves.easeOutCubic)),
            child: child,
          ),
        ),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _toggleMode() {
    setState(() => _isLoginMode = !_isLoginMode);
    _slideController.reset();
    _slideController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),
                      _buildHeader(),
                      const SizedBox(height: 40),
                      SlideTransition(
                          position: _slideAnimation,
                          child: _buildFormCard()),
                      const SizedBox(height: 24),
                      _buildDivider(),
                      const SizedBox(height: 20),
                      _buildSocialLogin(),
                      const SizedBox(height: 32),
                      _buildToggleMode(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(children: [
      Positioned(
        top: -60, right: -40,
        child: Container(
          width: 200, height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.red.withOpacity(0.07),
          ),
        ),
      ),
      Positioned(
        bottom: -80, left: -50,
        child: Container(
          width: 260, height: 260,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.teal.withOpacity(0.06),
          ),
        ),
      ),
    ]);
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScaleTransition(
          scale: _pulseAnimation,
          child: Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.red.withOpacity(0.3),
                  blurRadius: 16, offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.shield_outlined,
                color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          _isLoginMode ? 'Welcome back,' : 'Join the network,',
          style: const TextStyle(
              fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          _isLoginMode ? 'Hero.' : 'Be a Hero.',
          style: const TextStyle(
            fontSize: 36, fontWeight: FontWeight.w700,
            color: AppColors.textPrimary, height: 1.1, letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(children: [
          Container(
              width: 32, height: 3,
              decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 6),
          Container(
              width: 10, height: 3,
              decoration: BoxDecoration(
                  color: AppColors.teal,
                  borderRadius: BorderRadius.circular(2))),
        ]),
      ],
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 24, offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_isLoginMode) ...[
              _buildInputField(
                label: 'Full name', hint: 'Ravi Kumar',
                icon: Icons.person_outline,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 16),
            ],
            _buildInputField(
              label: 'Email address', hint: 'you@example.com',
              icon: Icons.mail_outline,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Enter your email';
                if (!v.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildPasswordField(),
            if (_isLoginMode) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: const Text('Forgot password?',
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.red,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ],
            const SizedBox(height: 24),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    TextEditingController? controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600,
              color: AppColors.textPrimary, letterSpacing: 0.3,
            )),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(
              fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.6),
                fontSize: 14),
            prefixIcon:
                Icon(icon, size: 18, color: AppColors.textSecondary),
            filled: true, fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: AppColors.border, width: 0.5)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: AppColors.border, width: 0.5)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.red, width: 1.5)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.red, width: 1)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.red, width: 1.5)),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Password',
            style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600,
              color: AppColors.textPrimary, letterSpacing: 0.3,
            )),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Enter your password';
            if (v.length < 6) return 'Minimum 6 characters';
            return null;
          },
          style: const TextStyle(
              fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.6),
                fontSize: 14),
            prefixIcon: const Icon(Icons.lock_outline,
                size: 18, color: AppColors.textSecondary),
            suffixIcon: GestureDetector(
              onTap: () => setState(
                  () => _isPasswordVisible = !_isPasswordVisible),
              child: Icon(
                _isPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 18, color: AppColors.textSecondary,
              ),
            ),
            filled: true, fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: AppColors.border, width: 0.5)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: AppColors.border, width: 0.5)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.red, width: 1.5)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.red, width: 1)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.red, width: 1.5)),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity, height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.red.withOpacity(0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20, height: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_isLoginMode ? 'Sign in' : 'Create account',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 18),
                ],
              ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(children: [
      Expanded(
          child: Divider(color: AppColors.border, thickness: 0.5)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text('or continue with',
            style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary.withOpacity(0.7))),
      ),
      Expanded(
          child: Divider(color: AppColors.border, thickness: 0.5)),
    ]);
  }

  Widget _buildSocialLogin() {
    return Row(children: [
      Expanded(child: _buildSocialButton('Google', Icons.g_mobiledata)),
      const SizedBox(width: 12),
      Expanded(child: _buildSocialButton('Phone', Icons.phone_outlined)),
    ]);
  }

  Widget _buildSocialButton(String label, IconData icon) {
    return GestureDetector(
      onTap: _handleSubmit,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppColors.textPrimary),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleMode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _isLoginMode
              ? "Don't have an account? "
              : 'Already a hero? ',
          style: const TextStyle(
              fontSize: 13, color: AppColors.textSecondary),
        ),
        GestureDetector(
          onTap: _toggleMode,
          child: Text(
            _isLoginMode ? 'Register now' : 'Sign in',
            style: const TextStyle(
                fontSize: 13,
                color: AppColors.red,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  HOME SCREEN  (shell with bottom nav — owns tab switching)
// ══════════════════════════════════════════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late AnimationController _alertPulseController;
  late Animation<double> _alertPulse;

  // Shared user data passed down to both tabs
  final Map<String, dynamic> _user = {
    'name': 'Ravi Kumar',
    'initials': 'RK',
    'level': 3,
    'xp': 680,
    'xpMax': 1000,
    'missionsCompleted': 14,
    'nearbyHeroes': 7,
    'rank': 42,
    'skills': ['First Aid', 'CPR', 'Fire Safety'],
    'isActive': true,
  };

  @override
  void initState() {
    super.initState();
    _alertPulseController = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this)
      ..repeat(reverse: true);
    _alertPulse = Tween<double>(begin: 0.85, end: 1.0).animate(
        CurvedAnimation(
            parent: _alertPulseController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _alertPulseController.dispose();
    super.dispose();
  }

  void _goToProfile() => setState(() => _selectedIndex = 3);

  @override
  Widget build(BuildContext context) {
    // Build body based on selected tab
    Widget body;
    switch (_selectedIndex) {
      case 3:
        body = ProfileTab(user: _user);
        break;
      case 1:
        body = const MapScreen();
        break;
      case 2:
        body = const TrainingScreen();
        break;
      default:
        body = _HomeTab(
          user: _user,
          alertPulse: _alertPulse,
          onProfileTap: _goToProfile,
        );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: KeyedSubtree(key: ValueKey(_selectedIndex), child: body),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildSOSButton(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
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
          label: const Text('SOS',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15)),
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
            _navItem(Icons.fitness_center_outlined,
                Icons.fitness_center, 'Train', 2),
            _navItem(
                Icons.person_outline, Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData outlineIcon, IconData filledIcon,
      String label, int index) {
    final bool selected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(selected ? filledIcon : outlineIcon,
              size: 22,
              color: selected
                  ? AppColors.red
                  : AppColors.textSecondary),
          const SizedBox(height: 3),
          Text(label,
              style: TextStyle(
                fontSize: 10,
                color: selected
                    ? AppColors.red
                    : AppColors.textSecondary,
                fontWeight: selected
                    ? FontWeight.w600
                    : FontWeight.w400,
              )),
        ],
      ),
    );
  }

  void _showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Row(children: [
          Icon(Icons.sos, color: AppColors.red),
          SizedBox(width: 8),
          Text('Send SOS Alert',
              style: TextStyle(
                  fontWeight: FontWeight.w700, color: AppColors.red)),
        ]),
        content: const Text(
          'This will alert all nearby volunteers and dispatch emergency services to your location.',
          style: TextStyle(
              fontSize: 14, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style:
                    TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Send SOS',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  HOME TAB  (extracted from old HomeScreen body)
// ══════════════════════════════════════════════════════════════════════════════
class _HomeTab extends StatefulWidget {
  final Map<String, dynamic> user;
  final Animation<double> alertPulse;
  final VoidCallback onProfileTap;

  const _HomeTab({
    required this.user,
    required this.alertPulse,
    required this.onProfileTap,
  });

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

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
        duration: const Duration(milliseconds: 700), vsync: this)
      ..forward();
    _fadeAnimation = CurvedAnimation(
        parent: _fadeController, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  _buildSectionTitle('Nearby emergencies',
                      showBadge: true),
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

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      floating: true,
      expandedHeight: 70,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Good morning,',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary)),
                Text(widget.user['name'],
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
              ],
            ),
            Row(children: [
              _buildIconBtn(Icons.notifications_outlined, () {},
                  badge: true),
              const SizedBox(width: 8),
              // Tapping avatar goes to Profile tab
              GestureDetector(
                onTap: widget.onProfileTap,
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.tealLight,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.teal, width: 1.5),
                  ),
                  child: Center(
                    child: Text(widget.user['initials'],
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.teal)),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBtn(IconData icon, VoidCallback onTap,
      {bool badge = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border:
                Border.all(color: AppColors.border, width: 0.5),
          ),
          child: Icon(icon, size: 20, color: AppColors.textPrimary),
        ),
        if (badge)
          Positioned(
            top: 6, right: 6,
            child: Container(
              width: 8, height: 8,
              decoration: const BoxDecoration(
                  color: AppColors.red, shape: BoxShape.circle),
            ),
          ),
      ]),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: AppColors.red.withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 8))
        ],
      ),
      child: Column(children: [
        Row(children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle),
            child: Center(
                child: Text(widget.user['initials'],
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white))),
          ),
          const SizedBox(width: 14),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children: [
                  const Icon(Icons.shield,
                      color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text(
                      'Hero Level ${widget.user['level']}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500)),
                ]),
                const SizedBox(height: 2),
                const Text('Active Volunteer',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ])),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: Colors.white.withOpacity(0.4), width: 0.5),
            ),
            child: Row(children: [
              Container(
                  width: 7, height: 7,
                  decoration: const BoxDecoration(
                      color: Color(0xFF4ADE80),
                      shape: BoxShape.circle)),
              const SizedBox(width: 5),
              const Text('Active',
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ]),
          ),
        ]),
        const SizedBox(height: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('XP Progress',
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.8))),
                Text(
                    '${widget.user['xp']} / ${widget.user['xpMax']} XP',
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ]),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: widget.user['xp'] / widget.user['xpMax'],
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
        ]),
        const SizedBox(height: 14),
        Row(children: [
          Text('Skills: ',
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withOpacity(0.7))),
          Expanded(
              child: Wrap(
            spacing: 6,
            children:
                (widget.user['skills'] as List<String>).map((s) =>
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(s,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    )).toList(),
          )),
        ]),
      ]),
    );
  }

  Widget _buildGeminiInsightCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.geminiLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: AppColors.gemini.withOpacity(0.2), width: 0.5),
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                  color: AppColors.gemini,
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.auto_awesome,
                  color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(children: [
                    const Text('Gemini AI Insight',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gemini)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: AppColors.gemini.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Text('Powered by Gemini',
                          style: TextStyle(
                              fontSize: 9,
                              color: AppColors.gemini,
                              fontWeight: FontWeight.w600)),
                    ),
                  ]),
                  const SizedBox(height: 4),
                  const Text(
                    "You're 320 XP away from Level 4. Complete the fire safety module today — it matches 2 open emergencies in your area.",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        height: 1.5),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _showGeminiChat(context),
                    child: const Row(children: [
                      Text('Ask Gemini for guidance',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.gemini,
                              fontWeight: FontWeight.w600)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward,
                          size: 14, color: AppColors.gemini),
                    ]),
                  ),
                ])),
          ]),
    );
  }

  Widget _buildStatsRow() {
    return Row(children: [
      _buildStatCard('Missions done',
          '${widget.user['missionsCompleted']}',
          Icons.check_circle_outline, AppColors.teal, AppColors.tealLight),
      const SizedBox(width: 12),
      _buildStatCard('Nearby heroes',
          '${widget.user['nearbyHeroes']}',
          Icons.people_outline, AppColors.red, AppColors.redLight),
      const SizedBox(width: 12),
      _buildStatCard('Your rank', '#${widget.user['rank']}',
          Icons.leaderboard_outlined, AppColors.amber, AppColors.amberLight),
    ]);
  }

  Widget _buildStatCard(String label, String value, IconData icon,
      Color color, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 8),
          Text(value,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: color)),
          const SizedBox(height: 2),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 10, color: AppColors.textSecondary)),
        ]),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showBadge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary)),
        Row(children: [
          if (showBadge)
            AnimatedBuilder(
              animation: widget.alertPulse,
              builder: (context, child) => Transform.scale(
                scale: widget.alertPulse.value,
                child: Container(
                    width: 8, height: 8,
                    decoration: const BoxDecoration(
                        color: AppColors.red,
                        shape: BoxShape.circle)),
              ),
            ),
          if (showBadge) const SizedBox(width: 6),
          GestureDetector(
            onTap: () {},
            child: const Text('See all',
                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.red,
                    fontWeight: FontWeight.w600)),
          ),
        ]),
      ],
    );
  }

  Widget _buildAlertsList() {
    return Column(
        children: _nearbyAlerts.map(_buildAlertCard).toList());
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    final bool isHigh = alert['urgency'] == 'high';
    final Color urgencyColor =
        isHigh ? AppColors.red : AppColors.amber;
    final Color urgencyBg =
        isHigh ? AppColors.redLight : AppColors.amberLight;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isHigh
              ? AppColors.red.withOpacity(0.3)
              : AppColors.border,
          width: isHigh ? 1 : 0.5,
        ),
      ),
      child: Row(children: [
        Container(
          width: 42, height: 42,
          decoration: BoxDecoration(
              color: urgencyBg,
              borderRadius: BorderRadius.circular(12)),
          child: Icon(
            alert['type'] == 'Medical'
                ? Icons.favorite_outline
                : Icons.local_fire_department_outlined,
            color: urgencyColor, size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Row(children: [
                Expanded(
                    child: Text(alert['title'],
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary))),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                      color: urgencyBg,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(isHigh ? 'Urgent' : 'Active',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: urgencyColor)),
                ),
              ]),
              const SizedBox(height: 4),
              Row(children: [
                Icon(Icons.location_on_outlined,
                    size: 12, color: AppColors.textSecondary),
                const SizedBox(width: 3),
                Text(alert['location'],
                    style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary)),
                const SizedBox(width: 8),
                Icon(Icons.access_time,
                    size: 12, color: AppColors.textSecondary),
                const SizedBox(width: 3),
                Text(alert['time'],
                    style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary)),
              ]),
              const SizedBox(height: 8),
              Row(children: [
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
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text('Respond',
                        style: TextStyle(fontSize: 12)),
                  ),
                )),
                const SizedBox(width: 8),
                SizedBox(
                  height: 32,
                  child: OutlinedButton.icon(
                    onPressed: () => _showGeminiChat(context),
                    icon: const Icon(Icons.auto_awesome,
                        size: 12, color: AppColors.gemini),
                    label: const Text('AI Guide',
                        style: TextStyle(
                            fontSize: 11,
                            color: AppColors.gemini)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color:
                              AppColors.gemini.withOpacity(0.4)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10),
                    ),
                  ),
                ),
              ]),
            ])),
      ]),
    );
  }

  Widget _buildTrainingTasks() {
    return Column(
        children: _dailyTasks.map(_buildTaskRow).toList());
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
        child: Row(children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: (task['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(task['icon'] as IconData,
                size: 20, color: task['color'] as Color),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            Text(task['title'],
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 3),
            Row(children: [
              Text('+${task['xp']} XP',
                  style: TextStyle(
                      fontSize: 11,
                      color: task['color'] as Color,
                      fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              Text(task['duration'],
                  style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary)),
            ]),
            if (!done && !locked && progress > 0) ...[
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      task['color'] as Color),
                  minHeight: 4,
                ),
              ),
            ],
          ])),
          const SizedBox(width: 8),
          if (done)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: AppColors.tealLight,
                  borderRadius: BorderRadius.circular(8)),
              child: const Text('Done',
                  style: TextStyle(
                      fontSize: 11,
                      color: AppColors.teal,
                      fontWeight: FontWeight.w600)),
            )
          else if (locked)
            const Icon(Icons.lock_outline,
                size: 18, color: AppColors.textSecondary)
          else
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                    color: AppColors.redLight,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text('Start',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppColors.red,
                        fontWeight: FontWeight.w600)),
              ),
            ),
        ]),
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
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CustomPaint(
            size: const Size(double.infinity, 160),
            painter: MapGridPainter(),
          ),
        ),
        Positioned(
            left: MediaQuery.of(context).size.width * 0.35, top: 80,
            child: _mapPin(AppColors.gemini, Icons.person, 'You')),
        Positioned(
            left: MediaQuery.of(context).size.width * 0.55, top: 45,
            child: _mapPin(
                AppColors.red, Icons.warning_amber_rounded, '!')),
        Positioned(
            left: MediaQuery.of(context).size.width * 0.22, top: 60,
            child: _mapPin(AppColors.teal, Icons.shield, '')),
        Positioned(
          bottom: 10, left: 14,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.92),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: AppColors.border, width: 0.5),
            ),
            child: const Text('Live coverage map — Chennai',
                style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary)),
          ),
        ),
        Positioned(
          bottom: 10, right: 14,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: AppColors.redLight,
                borderRadius: BorderRadius.circular(8)),
            child: const Text('1 incident nearby',
                style: TextStyle(
                    fontSize: 11,
                    color: AppColors.red,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      ]),
    );
  }

  Widget _mapPin(Color color, IconData icon, String label) {
    return Column(children: [
      Container(
        width: 28, height: 28,
        decoration: BoxDecoration(
          color: color, shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        child: Icon(icon, size: 14, color: Colors.white),
      ),
      if (label.isNotEmpty)
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4)),
          child: Text(label,
              style: const TextStyle(
                  fontSize: 9, color: Colors.white)),
        ),
    ]);
  }

  void _showGeminiChat(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const GeminiChatSheet(),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  PROFILE TAB
// ══════════════════════════════════════════════════════════════════════════════
class ProfileTab extends StatelessWidget {
  final Map<String, dynamic> user;
  const ProfileTab({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
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

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Good morning,',
                style: TextStyle(
                    fontSize: 14, color: AppColors.textSecondary)),
            Text(user['name'],
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary)),
          ],
        ),
        Row(children: [
          Stack(children: [
            IconButton(
                icon: const Icon(Icons.notifications_none, size: 28),
                onPressed: () {}),
            Positioned(
              right: 10, top: 10,
              child: Container(
                width: 8, height: 8,
                decoration: const BoxDecoration(
                    color: AppColors.red, shape: BoxShape.circle),
              ),
            ),
          ]),
          const SizedBox(width: 4),
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.tealLight,
            child: Text(user['initials'],
                style: const TextStyle(
                    color: AppColors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
        ]),
      ],
    );
  }

  Widget _buildHeroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: AppColors.red.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: Text(user['initials'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Row(children: [
                const Icon(Icons.shield,
                    color: Colors.white70, size: 14),
                const SizedBox(width: 4),
                Text('Hero Level ${user['level']}',
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 13)),
              ]),
              const SizedBox(height: 2),
              const Text('Active Volunteer',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(children: const [
                Icon(Icons.circle,
                    color: Color(0xFF66BB6A), size: 8),
                SizedBox(width: 5),
                Text('Active',
                    style: TextStyle(
                        color: Colors.white, fontSize: 13)),
              ]),
            ),
          ]),
          const SizedBox(height: 18),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('XP Progress',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13)),
                Text('${user['xp']} / ${user['xpMax']} XP',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ]),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: user['xp'] / user['xpMax'],
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 14),
          Row(children: [
            Text('Skills: ',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13)),
            Wrap(
              spacing: 6,
              children:
                  (user['skills'] as List<String>).map((s) =>
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(s,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12)),
                      )).toList(),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(children: [
      _statCard(Icons.check_circle_outline, AppColors.teal,
          '${user['missionsCompleted']}', 'Missions done'),
      const SizedBox(width: 12),
      _statCard(Icons.people_outline, AppColors.red,
          '${user['nearbyHeroes']}', 'Nearby heroes'),
      const SizedBox(width: 12),
      _statCard(Icons.bar_chart, AppColors.amber,
          '#${user['rank']}', 'Your rank'),
    ]);
  }

  Widget _statCard(
      IconData icon, Color color, String value, String label) {
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
        child: Column(children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  color: color,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 11),
              textAlign: TextAlign.center),
        ]),
      ),
    );
  }

  Widget _buildSkillsSection() {
    final skills = [
      {
        'title': 'First Aid',
        'level': 'Advanced',
        'progress': 0.85,
        'color': AppColors.red
      },
      {
        'title': 'CPR',
        'level': 'Intermediate',
        'progress': 0.60,
        'color': AppColors.gemini
      },
      {
        'title': 'Fire Safety',
        'level': 'Beginner',
        'progress': 0.35,
        'color': AppColors.amber
      },
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
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                Text(s['title'] as String,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                Text(s['level'] as String,
                    style: TextStyle(
                        color: color, fontSize: 12)),
              ]),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: s['progress'] as double,
                  minHeight: 7,
                  backgroundColor: color.withOpacity(0.15),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ]),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAchievementsSection() {
    final badges = [
      {
        'icon': Icons.local_fire_department,
        'color': AppColors.red,
        'label': 'First\nResponder'
      },
      {
        'icon': Icons.favorite,
        'color': const Color(0xFFD81B60),
        'label': 'Life\nSaver'
      },
      {
        'icon': Icons.emoji_events,
        'color': AppColors.amber,
        'label': 'Top\nVolunteer'
      },
      {
        'icon': Icons.shield,
        'color': const Color(0xFF1565C0),
        'label': 'Hero\nLevel 3'
      },
    ];

    return _sectionCard(
      title: 'Achievements',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: badges.map((b) {
          final color = b['color'] as Color;
          return Column(children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle),
              child: Icon(b['icon'] as IconData,
                  color: color, size: 26),
            ),
            const SizedBox(height: 6),
            Text(b['label'] as String,
                style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary),
                textAlign: TextAlign.center),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildMissionHistory() {
    final missions = [
      {
        'title': 'Cardiac Arrest Response',
        'location': 'Anna Nagar',
        'date': 'Apr 8, 2026',
        'xp': '+120 XP'
      },
      {
        'title': 'Fire Safety Drill',
        'location': 'T. Nagar',
        'date': 'Apr 5, 2026',
        'xp': '+80 XP'
      },
      {
        'title': 'First Aid Support',
        'location': 'Adyar',
        'date': 'Apr 2, 2026',
        'xp': '+100 XP'
      },
    ];

    return _sectionCard(
      title: 'Recent Missions',
      child: Column(
        children: missions.asMap().entries.map((entry) {
          final m = entry.value;
          final isLast = entry.key == missions.length - 1;
          return Column(children: [
            Row(children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: AppColors.redLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.check_circle,
                    color: AppColors.red, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                Text(m['title']!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
                Text(
                    '${m['location']} • ${m['date']}',
                    style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12)),
              ])),
              Text(m['xp']!,
                  style: const TextStyle(
                      color: AppColors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 13)),
            ]),
            if (!isLast)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                    color: Colors.grey.shade100, height: 1),
              ),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    final items = [
      {'icon': Icons.edit_outlined, 'label': 'Edit Profile'},
      {
        'icon': Icons.notifications_outlined,
        'label': 'Notification Settings'
      },
      {
        'icon': Icons.privacy_tip_outlined,
        'label': 'Privacy & Safety'
      },
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
          return Column(children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: Icon(item['icon'] as IconData,
                  color: isRed
                      ? AppColors.red
                      : AppColors.textSecondary,
                  size: 22),
              title: Text(item['label'] as String,
                  style: TextStyle(
                      fontSize: 14,
                      color: isRed
                          ? AppColors.red
                          : AppColors.textPrimary,
                      fontWeight: isRed
                          ? FontWeight.w600
                          : FontWeight.normal)),
              trailing: isRed
                  ? null
                  : const Icon(Icons.chevron_right,
                      color: AppColors.textSecondary, size: 20),
              onTap: () {
                if (isRed) {
                  // Sign out → back to login
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LoginScreen()),
                    (_) => false,
                  );
                }
              },
            ),
            if (!isLast)
              Divider(color: Colors.grey.shade100, height: 1),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _sectionCard(
      {required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary)),
        const SizedBox(height: 14),
        child,
      ]),
    );
  }
}

// ─── Map Painter ──────────────────────────────────────────────────────────────
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
    canvas.drawLine(Offset(0, size.height * 0.5),
        Offset(size.width, size.height * 0.5), roadPaint);
    canvas.drawLine(Offset(size.width * 0.4, 0),
        Offset(size.width * 0.4, size.height), roadPaint);
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─── Gemini Chat Sheet ────────────────────────────────────────────────────────
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
          "Hi! I'm your Gemini AI emergency guide. How can I help you prepare or respond today?",
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
            "Based on your CPR certification, here's what to do: Check for responsiveness, call for help, start chest compressions at 100-120 per minute, and use an AED if available.",
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
            curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(children: [
        const SizedBox(height: 12),
        Container(
            width: 40, height: 4,
            decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                  color: AppColors.gemini,
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.auto_awesome,
                  color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            const Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Text('Gemini AI Guide',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary)),
              Text('Emergency assistance powered by Gemini',
                  style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary)),
            ])),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close,
                  color: AppColors.textSecondary),
            ),
          ]),
        ),
        const SizedBox(height: 12),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount:
                _messages.length + (_isTyping ? 1 : 0),
            itemBuilder: (context, i) {
              if (_isTyping && i == _messages.length)
                return _buildTypingIndicator();
              final msg = _messages[i];
              return _buildMessage(
                  msg['text']!, msg['role'] == 'user');
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: AppColors.border, width: 0.5))),
          child: Row(children: [
            Expanded(
                child: TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Ask about emergency steps...',
                hintStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
              onSubmitted: _sendMessage,
            )),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => _sendMessage(_controller.text),
              child: Container(
                width: 42, height: 42,
                decoration: BoxDecoration(
                    color: AppColors.gemini,
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.send_rounded,
                    color: Colors.white, size: 18),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _buildMessage(String text, bool isUser) {
    return Align(
      alignment: isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width * 0.72),
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
        child: Text(text,
            style: TextStyle(
                fontSize: 13,
                color: isUser
                    ? Colors.white
                    : AppColors.textPrimary,
                height: 1.5)),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: AppColors.geminiLight,
            borderRadius: BorderRadius.circular(14)),
        child: const Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.auto_awesome,
              size: 14, color: AppColors.gemini),
          SizedBox(width: 6),
          Text('Gemini is thinking...',
              style: TextStyle(
                  fontSize: 12, color: AppColors.gemini)),
        ]),
      ),
    );
  }
}
