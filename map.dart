import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  // Map specific colors
  static const Color primary = Color(0xFFB45309);
  static const Color danger = Color(0xFFDC2626);
  static const Color safe = Color(0xFF16A34A);
  static const Color blue = Color(0xFF1D4ED8);
  static const Color warning = Color(0xFFD97706);
  static const Color bg = Color(0xFFF7F5F0);
  static const Color text = Color(0xFF1C1917);
  static const Color muted = Color(0xFF78716C);
}

// ══════════════════════════════════════════════════════════════════════════════
//  DATA MODELS
// ══════════════════════════════════════════════════════════════════════════════

class EmergencyIncident {
  final String id;
  final String title;
  final String description;
  final String type; // Medical, Fire, Flood, Accident
  final LatLng location;
  final DateTime reportedAt;
  final int respondersNeeded;
  final int respondersCount;
  final String area;

  EmergencyIncident({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.location,
    required this.reportedAt,
    required this.respondersNeeded,
    required this.respondersCount,
    required this.area,
  });

  factory EmergencyIncident.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final geo = data['location'] as GeoPoint;
    return EmergencyIncident(
      id: doc.id,
      title: data['title'] ?? 'Unknown Incident',
      description: data['description'] ?? '',
      type: data['type'] ?? 'Other',
      location: LatLng(geo.latitude, geo.longitude),
      reportedAt: (data['reportedAt'] as Timestamp).toDate(),
      respondersNeeded: data['respondersNeeded'] ?? 2,
      respondersCount: data['respondersCount'] ?? 0,
      area: data['area'] ?? 'Unknown Location',
    );
  }
}

class NearbyVolunteer {
  final String id;
  final String name;
  final List<String> skills;
  final LatLng location;
  final bool isAvailable;

  NearbyVolunteer({
    required this.id,
    required this.name,
    required this.skills,
    required this.location,
    required this.isAvailable,
  });

  factory NearbyVolunteer.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final geo = data['location'] as GeoPoint;
    return NearbyVolunteer(
      id: doc.id,
      name: data['name'] ?? 'Unknown Volunteer',
      skills: List<String>.from(data['skills'] ?? []),
      location: LatLng(geo.latitude, geo.longitude),
      isAvailable: data['isAvailable'] ?? false,
    );
  }
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
//  HOME SCREEN
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
//  MAP SCREEN - Fully Integrated
// ══════════════════════════════════════════════════════════════════════════════

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  final Completer<GoogleMapController> _mapController = Completer();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  LatLng? _userPosition;
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};

  StreamSubscription<QuerySnapshot>? _incidentSub;
  StreamSubscription<QuerySnapshot>? _volunteerSub;
  StreamSubscription<Position>? _locationSub;

  List<EmergencyIncident> _incidents = [];
  List<NearbyVolunteer> _volunteers = [];

  EmergencyIncident? _selectedIncident;
  bool _isLoading = true;
  bool _showVolunteers = true;
  bool _showIncidents = true;

  late AnimationController _sheetAnim;
  late Animation<double> _sheetSlide;

  String _activeFilter = 'All';
  final List<String> _filters = ['All', 'Medical', 'Fire', 'Flood', 'Accident'];

  static const LatLng _defaultLocation = LatLng(13.0827, 80.2707);
  static const double _coverageRadius = 3000;

  @override
  void initState() {
    super.initState();
    _sheetAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _sheetSlide = CurvedAnimation(parent: _sheetAnim, curve: Curves.easeOutCubic);
    _initLocation();
  }

  @override
  void dispose() {
    _incidentSub?.cancel();
    _volunteerSub?.cancel();
    _locationSub?.cancel();
    _sheetAnim.dispose();
    super.dispose();
  }

  Future<void> _initLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _setFallbackLocation();
        return;
      }

      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }

      if (perm == LocationPermission.deniedForever ||
          perm == LocationPermission.denied) {
        _setFallbackLocation();
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _onLocationUpdate(pos);

      _locationSub = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 15,
        ),
      ).listen(_onLocationUpdate);

      _listenToIncidents();
      _listenToVolunteers();
    } catch (e) {
      _setFallbackLocation();
    }
  }

  void _setFallbackLocation() {
    _userPosition = _defaultLocation;
    _addUserMarker(_defaultLocation);
    _addCoverageCircle(_defaultLocation);
    _listenToIncidents();
    _listenToVolunteers();
  }

  void _onLocationUpdate(Position pos) {
    final latlng = LatLng(pos.latitude, pos.longitude);
    setState(() {
      _userPosition = latlng;
      _isLoading = false;
    });
    _addUserMarker(latlng);
    _addCoverageCircle(latlng);
    _animateCameraTo(latlng);
  }

  Future<void> _animateCameraTo(LatLng pos, {double zoom = 14.5}) async {
    if (!_mapController.isCompleted) return;
    final ctrl = await _mapController.future;
    ctrl.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: pos, zoom: zoom, tilt: 0),
    ));
  }

  void _addUserMarker(LatLng pos) {
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == 'user_marker');
      _markers.add(Marker(
        markerId: const MarkerId('user_marker'),
        position: pos,
        zIndex: 100,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(
          title: 'Your Location',
          snippet: 'Coverage: 3km radius',
        ),
      ));
    });
  }

  void _addCoverageCircle(LatLng pos) {
    setState(() {
      _circles.removeWhere((c) => c.circleId.value == 'coverage_circle');
      _circles.add(Circle(
        circleId: const CircleId('coverage_circle'),
        center: pos,
        radius: _coverageRadius,
        fillColor: AppColors.blue.withOpacity(0.08),
        strokeColor: AppColors.blue.withOpacity(0.2),
        strokeWidth: 2,
      ));
    });
  }

  void _refreshIncidentMarkers() {
    _markers.removeWhere((m) => m.markerId.value.startsWith('incident_'));

    for (final incident in _incidents) {
      if (!_showIncidents) break;
      if (_activeFilter != 'All' && incident.type != _activeFilter) continue;

      _markers.add(Marker(
        markerId: MarkerId('incident_${incident.id}'),
        position: incident.location,
        zIndex: 50,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          _getMarkerHue(incident.type),
        ),
        infoWindow: InfoWindow(
          title: incident.title,
          snippet: '${incident.area} • ${_formatTime(incident.reportedAt)}',
        ),
        onTap: () => _selectIncident(incident),
      ));
    }
    setState(() {});
  }

  void _refreshVolunteerMarkers() {
    _markers.removeWhere((m) => m.markerId.value.startsWith('volunteer_'));

    if (!_showVolunteers) {
      setState(() {});
      return;
    }

    for (final volunteer in _volunteers) {
      _markers.add(Marker(
        markerId: MarkerId('volunteer_${volunteer.id}'),
        position: volunteer.location,
        zIndex: 30,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          volunteer.isAvailable
              ? BitmapDescriptor.hueGreen
              : BitmapDescriptor.hueViolet,
        ),
        infoWindow: InfoWindow(
          title: volunteer.name,
          snippet: volunteer.isAvailable ? '🟢 Available' : '🔴 Busy',
        ),
      ));
    }
    setState(() {});
  }

  void _listenToIncidents() {
    _incidentSub = _db
        .collection('incidents')
        .where('status', isEqualTo: 'active')
        .snapshots()
        .listen((snap) {
      _incidents = snap.docs
          .map((d) => EmergencyIncident.fromFirestore(d))
          .toList();
      _refreshIncidentMarkers();
    });
  }

  void _listenToVolunteers() {
    _volunteerSub = _db
        .collection('volunteers')
        .where('isOnline', isEqualTo: true)
        .snapshots()
        .listen((snap) {
      _volunteers = snap.docs
          .map((d) => NearbyVolunteer.fromFirestore(d))
          .toList();
      _refreshVolunteerMarkers();
    });
  }

  void _selectIncident(EmergencyIncident incident) {
    setState(() => _selectedIncident = incident);
    _sheetAnim.forward();
    _animateCameraTo(incident.location, zoom: 15.5);
  }

  void _dismissIncidentSheet() {
    _sheetAnim.reverse().then((_) {
      setState(() => _selectedIncident = null);
    });
  }

  void _setFilter(String filter) {
    setState(() => _activeFilter = filter);
    _refreshIncidentMarkers();
  }

  void _toggleVolunteerDisplay() {
    setState(() => _showVolunteers = !_showVolunteers);
    _refreshVolunteerMarkers();
  }

  void _recenterMap() {
    if (_userPosition != null) {
      _animateCameraTo(_userPosition!);
    }
  }

  Color _getIncidentColor(String type) {
    switch (type) {
      case 'Medical':
        return AppColors.safe;
      case 'Fire':
        return AppColors.danger;
      case 'Flood':
        return AppColors.blue;
      case 'Accident':
        return AppColors.warning;
      default:
        return AppColors.muted;
    }
  }

  IconData _getIncidentIcon(String type) {
    switch (type) {
      case 'Medical':
        return Icons.medical_services_rounded;
      case 'Fire':
        return Icons.local_fire_department_rounded;
      case 'Flood':
        return Icons.water_rounded;
      case 'Accident':
        return Icons.car_crash_rounded;
      default:
        return Icons.warning_amber_rounded;
    }
  }

  double _getMarkerHue(String type) {
    switch (type) {
      case 'Medical':
        return BitmapDescriptor.hueGreen;
      case 'Fire':
        return BitmapDescriptor.hueRed;
      case 'Flood':
        return BitmapDescriptor.hueBlue;
      case 'Accident':
        return BitmapDescriptor.hueOrange;
      default:
        return BitmapDescriptor.hueYellow;
    }
  }

  String _formatTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  void _respondToIncident(EmergencyIncident incident) {
    try {
      _db.collection('incidents').doc(incident.id).update({
        'respondersCount': FieldValue.increment(1),
      });
      _dismissIncidentSheet();
      _showSnackBar(
        'You are responding to: ${incident.title}',
        backgroundColor: _getIncidentColor(incident.type),
      );
    } catch (e) {
      _showSnackBar('Error responding to incident', isError: true);
    }
  }

  void _showSnackBar(String message,
      {Color? backgroundColor, bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            backgroundColor ?? (isError ? AppColors.danger : AppColors.safe),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          _buildMap(),
          SafeArea(child: _buildTopSearchBar()),
          Positioned(
            top: MediaQuery.of(context).padding.top + 78,
            left: 0,
            right: 0,
            child: _buildFilterBar(),
          ),
          Positioned(
            right: 16,
            bottom: _selectedIncident != null ? 280 : 110,
            child: _buildMapControls(),
          ),
          Positioned(
            left: 16,
            bottom: _selectedIncident != null ? 280 : 110,
            child: _buildLegend(),
          ),
          if (_incidents.isNotEmpty)
            Positioned(
              bottom: _selectedIncident != null ? 260 : 90,
              left: 0,
              right: 0,
              child: Center(child: _buildIncidentPill()),
            ),
          if (_selectedIncident != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildIncidentDetailSheet(),
            ),
          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.8),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 3,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _userPosition ?? _defaultLocation,
        zoom: 14.5,
      ),
      onMapCreated: (ctrl) {
        _mapController.complete(ctrl);
        ctrl.setMapStyle(_getMapStyle());
      },
      markers: _markers,
      circles: _circles,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      compassEnabled: false,
      buildingsEnabled: true,
      trafficEnabled: false,
      onTap: (_) => _dismissIncidentSheet(),
      padding: EdgeInsets.only(
        bottom: _selectedIncident != null ? 260 : 80,
        top: 130,
      ),
    );
  }

  Widget _buildTopSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.search_rounded,
                color: AppColors.muted, size: 20),
            const SizedBox(width: 10),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search areas or incidents...',
                  hintStyle: TextStyle(
                    color: AppColors.muted,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 24,
              color: const Color(0xFFE5E5E5),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _toggleVolunteerDisplay,
              child: Icon(
                Icons.layers_rounded,
                color: _showVolunteers ? AppColors.primary : AppColors.muted,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final filter = _filters[i];
          final isSelected = _activeFilter == filter;
          return GestureDetector(
            onTap: () => _setFilter(filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.text,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMapControls() {
    return Column(
      children: [
        _mapFab(
          icon: Icons.my_location_rounded,
          onTap: _recenterMap,
          tooltip: 'My location',
        ),
        const SizedBox(height: 10),
        _mapFab(
          icon: Icons.add_rounded,
          onTap: () async {
            if (_mapController.isCompleted) {
              final ctrl = await _mapController.future;
              ctrl.animateCamera(CameraUpdate.zoomIn());
            }
          },
          tooltip: 'Zoom in',
        ),
        const SizedBox(height: 10),
        _mapFab(
          icon: Icons.remove_rounded,
          onTap: () async {
            if (_mapController.isCompleted) {
              final ctrl = await _mapController.future;
              ctrl.animateCamera(CameraUpdate.zoomOut());
            }
          },
          tooltip: 'Zoom out',
        ),
      ],
    );
  }

  Widget _mapFab({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.14),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.text, size: 20),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _legendItem(Colors.blue, 'You'),
          const SizedBox(height: 6),
          _legendItem(AppColors.safe, 'Volunteer'),
          const SizedBox(height: 6),
          _legendItem(AppColors.danger, 'Incident'),
          const SizedBox(height: 6),
          _legendItem(AppColors.warning, 'Warning'),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.text,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildIncidentPill() {
    final count = _activeFilter == 'All'
        ? _incidents.length
        : _incidents.where((i) => i.type == _activeFilter).length;

    return GestureDetector(
      onTap: () {
        if (_incidents.isNotEmpty && _selectedIncident == null) {
          _selectIncident(_incidents.first);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: count > 0 ? AppColors.danger : AppColors.safe,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: (count > 0 ? AppColors.danger : AppColors.safe)
                  .withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              count > 0 ? Icons.warning_rounded : Icons.check_circle_rounded,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              count > 0
                  ? '$count incident${count != 1 ? 's' : ''} nearby'
                  : 'All clear nearby',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncidentDetailSheet() {
    final incident = _selectedIncident!;
    final color = _getIncidentColor(incident.type);

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(_sheetSlide),
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 24,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getIncidentIcon(incident.type),
                          color: color,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              incident.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.location_on_rounded,
                                    size: 12, color: AppColors.muted),
                                const SizedBox(width: 3),
                                Text(
                                  incident.area,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.muted,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.access_time_rounded,
                                    size: 12, color: AppColors.muted),
                                const SizedBox(width: 3),
                                Text(
                                  _formatTime(incident.reportedAt),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.muted,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          incident.type,
                          style: TextStyle(
                            color: color,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    incident.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.muted,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(Icons.people_rounded,
                          size: 14, color: AppColors.muted),
                      const SizedBox(width: 6),
                      Text(
                        '${incident.respondersCount}/${incident.respondersNeeded} responders',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.muted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: incident.respondersNeeded > 0
                                ? incident.respondersCount /
                                    incident.respondersNeeded
                                : 0,
                            backgroundColor: const Color(0xFFF0EDE8),
                            valueColor:
                                AlwaysStoppedAnimation<Color>(color),
                            minHeight: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _showSnackBar(
                              'Opening directions to ${incident.area}',
                            );
                          },
                          icon: const Icon(Icons.directions_rounded, size: 16),
                          label: const Text('Directions'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.text,
                            side: const BorderSide(
                                color: Color(0xFFE5E5E5)),
                            padding:
                                const EdgeInsets.symmetric(vertical: 11),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              _respondToIncident(_selectedIncident!),
                          icon: const Icon(Icons.bolt_rounded, size: 18),
                          label: const Text('Respond Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding:
                                const EdgeInsets.symmetric(vertical: 11),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMapStyle() {
    return '''
    [
      {"elementType":"geometry","stylers":[{"color":"#f5f5f0"}]},
      {"elementType":"labels.icon","stylers":[{"visibility":"off"}]},
      {"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},
      {"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},
      {"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeede8"}]},
      {"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#d9e8c8"}]},
      {"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},
      {"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#f8e9a0"}]},
      {"featureType":"water","elementType":"geometry","stylers":[{"color":"#aed9e0"}]}
    ]
    ''';
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  HOME TAB
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
          SliverAppBar(
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
                    const SizedBox(width: 8),
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildHeroCard(),
                  const SizedBox(height: 24),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
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
        ]),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  PROFILE TAB & TRAINING SCREEN
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Profile',
                        style: TextStyle(
                            fontSize: 14, color: AppColors.textSecondary)),
                    Text(user['name'],
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Achievements coming soon...',
                style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Training Screen',
          style: TextStyle(fontSize: 18, color: AppColors.textPrimary)),
    );
  }
}