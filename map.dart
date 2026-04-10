// map.dart — MapScreen widget only (imported by main.dart)
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

// ─── Map Colors ───────────────────────────────────────────────────────────────
class _MC {
  static const Color primary = Color(0xFFB45309);
  static const Color danger = Color(0xFFDC2626);
  static const Color safe = Color(0xFF16A34A);
  static const Color blue = Color(0xFF1D4ED8);
  static const Color warning = Color(0xFFD97706);
  static const Color bg = Color(0xFFF7F5F0);
  static const Color text = Color(0xFF1C1917);
  static const Color muted = Color(0xFF78716C);
}

// ─── Data Models ──────────────────────────────────────────────────────────────
class EmergencyIncident {
  final String id;
  final String title;
  final String description;
  final String type;
  final _LatLng location;
  final DateTime reportedAt;
  final int respondersNeeded;
  final int respondersCount;
  final String area;

  const EmergencyIncident({
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
}

class _LatLng {
  final double lat;
  final double lng;
  const _LatLng(this.lat, this.lng);
}

class NearbyVolunteer {
  final String id;
  final String name;
  final List<String> skills;
  final bool isAvailable;

  const NearbyVolunteer({
    required this.id,
    required this.name,
    required this.skills,
    required this.isAvailable,
  });
}

// ══════════════════════════════════════════════════════════════════════════════
//  MAP SCREEN
// ══════════════════════════════════════════════════════════════════════════════
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  // ── Mock data (replace with real Firebase/Geolocator when integrated) ──────
  final List<EmergencyIncident> _incidents = [
    EmergencyIncident(
      id: '1',
      title: 'Cardiac Arrest Reported',
      description:
          'Person collapsed near the main road. CPR-trained volunteer needed immediately.',
      type: 'Medical',
      location: const _LatLng(13.0850, 80.2785),
      reportedAt: DateTime.now().subtract(const Duration(minutes: 3)),
      respondersNeeded: 3,
      respondersCount: 1,
      area: 'Anna Nagar, 0.8 km',
    ),
    EmergencyIncident(
      id: '2',
      title: 'Building Fire',
      description:
          'Small fire reported at top floor apartment. Fire brigade en route.',
      type: 'Fire',
      location: const _LatLng(13.0612, 80.2337),
      reportedAt: DateTime.now().subtract(const Duration(minutes: 11)),
      respondersNeeded: 5,
      respondersCount: 4,
      area: 'T. Nagar, 2.1 km',
    ),
    EmergencyIncident(
      id: '3',
      title: 'Road Accident',
      description: 'Two-vehicle collision. First aid required for injured.',
      type: 'Accident',
      location: const _LatLng(13.0012, 80.2565),
      reportedAt: DateTime.now().subtract(const Duration(minutes: 42)),
      respondersNeeded: 3,
      respondersCount: 3,
      area: 'Adyar, 4.3 km',
    ),
    EmergencyIncident(
      id: '4',
      title: 'Flash Flood Warning',
      description: 'Low-lying streets flooding. Evacuation assistance needed.',
      type: 'Flood',
      location: const _LatLng(13.1180, 80.2900),
      reportedAt: DateTime.now().subtract(const Duration(minutes: 22)),
      respondersNeeded: 6,
      respondersCount: 2,
      area: 'Perambur, 3.5 km',
    ),
  ];

  final List<NearbyVolunteer> _volunteers = [
    NearbyVolunteer(
      id: 'v1',
      name: 'Arun K.',
      skills: ['CPR', 'First Aid'],
      isAvailable: true,
    ),
    NearbyVolunteer(
      id: 'v2',
      name: 'Meena R.',
      skills: ['Fire Safety'],
      isAvailable: true,
    ),
    NearbyVolunteer(
      id: 'v3',
      name: 'Karthik S.',
      skills: ['CPR'],
      isAvailable: false,
    ),
    NearbyVolunteer(
      id: 'v4',
      name: 'Priya L.',
      skills: ['First Aid'],
      isAvailable: true,
    ),
    NearbyVolunteer(
      id: 'v5',
      name: 'Vijay T.',
      skills: ['Flood Response'],
      isAvailable: false,
    ),
    NearbyVolunteer(
      id: 'v6',
      name: 'Divya M.',
      skills: ['First Aid', 'CPR'],
      isAvailable: true,
    ),
    NearbyVolunteer(
      id: 'v7',
      name: 'Rahul P.',
      skills: ['Fire Safety'],
      isAvailable: false,
    ),
  ];

  // ── State ──────────────────────────────────────────────────────────────────
  EmergencyIncident? _selectedIncident;
  String _activeFilter = 'All';
  bool _showVolunteers = true;
  bool _showVolunteerList = false;

  late AnimationController _sheetAnim;
  late Animation<double> _sheetSlide;

  final List<String> _filters = ['All', 'Medical', 'Fire', 'Flood', 'Accident'];

  @override
  void initState() {
    super.initState();
    _sheetAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _sheetSlide = CurvedAnimation(
      parent: _sheetAnim,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _sheetAnim.dispose();
    super.dispose();
  }

  List<EmergencyIncident> get _filteredIncidents => _activeFilter == 'All'
      ? _incidents
      : _incidents.where((i) => i.type == _activeFilter).toList();

  void _selectIncident(EmergencyIncident incident) {
    setState(() {
      _selectedIncident = incident;
      _showVolunteerList = false;
    });
    _sheetAnim.forward();
  }

  void _dismissSheet() {
    _sheetAnim.reverse().then((_) {
      if (mounted) setState(() => _selectedIncident = null);
    });
  }

  void _setFilter(String f) {
    setState(() => _activeFilter = f);
    if (_selectedIncident != null &&
        f != 'All' &&
        _selectedIncident!.type != f) {
      _dismissSheet();
    }
  }

  void _respondToIncident(EmergencyIncident incident) {
    _dismissSheet();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Responding to: ${incident.title}'),
        backgroundColor: _incidentColor(incident.type),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Color _incidentColor(String type) {
    switch (type) {
      case 'Medical':
        return _MC.safe;
      case 'Fire':
        return _MC.danger;
      case 'Flood':
        return _MC.blue;
      case 'Accident':
        return _MC.warning;
      default:
        return _MC.muted;
    }
  }

  IconData _incidentIcon(String type) {
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

  String _timeAgo(DateTime dt) {
    final d = DateTime.now().difference(dt);
    if (d.inMinutes < 1) return 'Just now';
    if (d.inMinutes < 60) return '${d.inMinutes}m ago';
    return '${d.inHours}h ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _MC.bg,
      body: Stack(
        children: [
          // ── Canvas map (no Google Maps dependency needed for now) ─────────
          _buildCanvasMap(),

          // ── Top search bar ────────────────────────────────────────────────
          SafeArea(child: _buildTopBar()),

          // ── Filter bar ────────────────────────────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 70,
            left: 0,
            right: 0,
            child: _buildFilterBar(),
          ),

          // ── Map controls ──────────────────────────────────────────────────
          Positioned(
            right: 16,
            bottom: _selectedIncident != null ? 290 : 110,
            child: _buildMapControls(),
          ),

          // ── Legend ────────────────────────────────────────────────────────
          Positioned(
            left: 16,
            bottom: _selectedIncident != null ? 290 : 110,
            child: _buildLegend(),
          ),

          // ── Incident pill ─────────────────────────────────────────────────
          if (!_showVolunteerList)
            Positioned(
              bottom: _selectedIncident != null ? 272 : 94,
              left: 0,
              right: 0,
              child: Center(child: _buildIncidentPill()),
            ),

          // ── Volunteer list pill ───────────────────────────────────────────
          if (_showVolunteers &&
              !_showVolunteerList &&
              _selectedIncident == null)
            Positioned(
              bottom: 138,
              left: 0,
              right: 0,
              child: Center(child: _buildVolunteerPill()),
            ),

          // ── Volunteer list sheet ──────────────────────────────────────────
          if (_showVolunteerList)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildVolunteerSheet(),
            ),

          // ── Incident detail sheet ─────────────────────────────────────────
          if (_selectedIncident != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildIncidentDetailSheet(),
            ),
        ],
      ),
    );
  }

  // ── Canvas Map (self-contained, no packages required) ─────────────────────
  Widget _buildCanvasMap() {
    return CustomPaint(
      size: Size.infinite,
      painter: _ChennaiMapPainter(
        incidents: _filteredIncidents,
        volunteers: _showVolunteers ? _volunteers : [],
        selectedId: _selectedIncident?.id,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapUp: (details) {
          // Hit-test incident pins painted on canvas
          final size = MediaQuery.of(context).size;
          final tapped = _tapIncident(details.globalPosition, size);
          if (tapped != null) {
            _selectIncident(tapped);
          } else if (_selectedIncident != null) {
            _dismissSheet();
          } else if (_showVolunteerList) {
            setState(() => _showVolunteerList = false);
          }
        },
        child: const SizedBox.expand(),
      ),
    );
  }

  // Returns incident whose pin was tapped (rough hit test based on painted pos)
  EmergencyIncident? _tapIncident(Offset tap, Size size) {
    for (final incident in _filteredIncidents) {
      final pos = _projectLatLng(incident.location, size);
      if ((tap - pos).distance < 28) return incident;
    }
    return null;
  }

  // Simple equirectangular projection centred on Chennai
  static Offset _projectLatLng(_LatLng ll, Size size) {
    const centreLat = 13.0827;
    const centreLng = 80.2707;
    const scale = 22000.0; // pixels per degree
    final dx = (ll.lng - centreLng) * scale;
    final dy = (centreLat - ll.lat) * scale;
    return Offset(size.width / 2 + dx, size.height / 2 + dy);
  }

  // ── Top Search / Layer Bar ─────────────────────────────────────────────────
  Widget _buildTopBar() {
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
            const Icon(Icons.search_rounded, color: _MC.muted, size: 20),
            const SizedBox(width: 10),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search areas or incidents...',
                  hintStyle: TextStyle(color: _MC.muted, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: TextStyle(color: _MC.text, fontSize: 14),
              ),
            ),
            Container(width: 1, height: 24, color: const Color(0xFFE5E5E5)),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => setState(() => _showVolunteers = !_showVolunteers),
              child: Icon(
                Icons.layers_rounded,
                color: _showVolunteers ? _MC.primary : _MC.muted,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () =>
                  setState(() => _showVolunteerList = !_showVolunteerList),
              child: Icon(
                Icons.people_rounded,
                color: _showVolunteerList ? _MC.primary : _MC.muted,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  // ── Filter Bar ─────────────────────────────────────────────────────────────
  Widget _buildFilterBar() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final f = _filters[i];
          final sel = _activeFilter == f;
          return GestureDetector(
            onTap: () => _setFilter(f),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: sel ? _MC.primary : Colors.white,
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
                f,
                style: TextStyle(
                  color: sel ? Colors.white : _MC.text,
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

  // ── Map Controls ───────────────────────────────────────────────────────────
  Widget _buildMapControls() {
    return Column(
      children: [
        _mapFab(Icons.my_location_rounded, 'My location', () {}),
        const SizedBox(height: 10),
        _mapFab(Icons.add_rounded, 'Zoom in', () {}),
        const SizedBox(height: 10),
        _mapFab(Icons.remove_rounded, 'Zoom out', () {}),
      ],
    );
  }

  Widget _mapFab(IconData icon, String tooltip, VoidCallback onTap) {
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
          child: Icon(icon, color: _MC.text, size: 20),
        ),
      ),
    );
  }

  // ── Legend ─────────────────────────────────────────────────────────────────
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
          const SizedBox(height: 5),
          _legendItem(_MC.safe, 'Volunteer'),
          const SizedBox(height: 5),
          _legendItem(_MC.danger, 'Medical'),
          const SizedBox(height: 5),
          _legendItem(_MC.warning, 'Accident'),
          const SizedBox(height: 5),
          _legendItem(_MC.blue, 'Flood'),
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
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: _MC.text,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // ── Incident Pill ──────────────────────────────────────────────────────────
  Widget _buildIncidentPill() {
    final count = _filteredIncidents.length;
    final hasActive = _filteredIncidents.any(
      (i) => i.respondersCount < i.respondersNeeded,
    );
    return GestureDetector(
      onTap: () {
        if (_filteredIncidents.isNotEmpty) {
          _selectIncident(_filteredIncidents.first);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: hasActive ? _MC.danger : _MC.safe,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: (hasActive ? _MC.danger : _MC.safe).withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasActive ? Icons.warning_rounded : Icons.check_circle_rounded,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              count > 0
                  ? '$count incident${count != 1 ? 's' : ''} nearby — tap to view'
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

  // ── Volunteer Pill ─────────────────────────────────────────────────────────
  Widget _buildVolunteerPill() {
    final avail = _volunteers.where((v) => v.isAvailable).length;
    return GestureDetector(
      onTap: () => setState(() => _showVolunteerList = true),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _MC.safe.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.people_rounded, color: _MC.safe, size: 16),
            const SizedBox(width: 6),
            Text(
              '$avail of ${_volunteers.length} volunteers available',
              style: const TextStyle(
                fontSize: 12,
                color: _MC.text,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Volunteer List Sheet ───────────────────────────────────────────────────
  Widget _buildVolunteerSheet() {
    return Container(
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
          _sheetHandle(),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: Row(
              children: [
                const Text(
                  'Nearby Volunteers',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _MC.text,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_volunteers.length} total',
                  style: const TextStyle(fontSize: 12, color: _MC.muted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: _volunteers.length,
              separatorBuilder: (_, __) =>
                  Divider(color: Colors.grey.shade100, height: 1),
              itemBuilder: (_, i) {
                final v = _volunteers[i];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: v.isAvailable
                          ? _MC.safe.withOpacity(0.1)
                          : Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      color: v.isAvailable ? _MC.safe : Colors.grey,
                      size: 18,
                    ),
                  ),
                  title: Text(
                    v.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    v.skills.join(', '),
                    style: const TextStyle(fontSize: 11, color: _MC.muted),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: v.isAvailable
                          ? _MC.safe.withOpacity(0.1)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      v.isAvailable ? 'Available' : 'Busy',
                      style: TextStyle(
                        fontSize: 10,
                        color: v.isAvailable ? _MC.safe : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ── Incident Detail Sheet ──────────────────────────────────────────────────
  Widget _buildIncidentDetailSheet() {
    final incident = _selectedIncident!;
    final color = _incidentColor(incident.type);

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
            _sheetHandle(),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _incidentIcon(incident.type),
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
                                color: _MC.text,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  size: 12,
                                  color: _MC.muted,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  incident.area,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: _MC.muted,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.access_time_rounded,
                                  size: 12,
                                  color: _MC.muted,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  _timeAgo(incident.reportedAt),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: _MC.muted,
                                  ),
                                ),
                              ],
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
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          incident.type,
                          style: TextStyle(
                            color: color,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    incident.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: _MC.muted,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Responders progress
                  Row(
                    children: [
                      const Icon(
                        Icons.people_rounded,
                        size: 14,
                        color: _MC.muted,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${incident.respondersCount}/${incident.respondersNeeded} responders',
                        style: const TextStyle(
                          fontSize: 12,
                          color: _MC.muted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: incident.respondersNeeded > 0
                                ? (incident.respondersCount /
                                      incident.respondersNeeded)
                                : 0,
                            backgroundColor: const Color(0xFFF0EDE8),
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                            minHeight: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Opening directions to ${incident.area}',
                                ),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.all(16),
                              ),
                            );
                          },
                          icon: const Icon(Icons.directions_rounded, size: 16),
                          label: const Text('Directions'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _MC.text,
                            side: const BorderSide(color: Color(0xFFE5E5E5)),
                            padding: const EdgeInsets.symmetric(vertical: 11),
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
                          onPressed: () => _respondToIncident(incident),
                          icon: const Icon(Icons.bolt_rounded, size: 18),
                          label: const Text('Respond Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
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
      ),
    );
  }

  Widget _sheetHandle() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E5E5),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  CANVAS MAP PAINTER — renders a stylised Chennai map with incident pins
// ══════════════════════════════════════════════════════════════════════════════
class _ChennaiMapPainter extends CustomPainter {
  final List<EmergencyIncident> incidents;
  final List<NearbyVolunteer> volunteers;
  final String? selectedId;

  static const _centreLat = 13.0827;
  static const _centreLng = 80.2707;
  static const _scale = 22000.0;

  _ChennaiMapPainter({
    required this.incidents,
    required this.volunteers,
    this.selectedId,
  });

  Offset _project(_LatLng ll, Size size) {
    final dx = (ll.lng - _centreLng) * _scale;
    final dy = (_centreLat - ll.lat) * _scale;
    return Offset(size.width / 2 + dx, size.height / 2 + dy);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // ── Background ────────────────────────────────────────────────────────
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFF5F3EE),
    );

    // ── Grid (streets) ────────────────────────────────────────────────────
    final gridPaint = Paint()
      ..color = const Color(0xFFE2DDD6)
      ..strokeWidth = 0.5;
    for (double x = 0; x <= size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y <= size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // ── Roads ─────────────────────────────────────────────────────────────
    final roadPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final roadPaintMinor = Paint()
      ..color = const Color(0xFFECE9E3)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Major roads
    canvas.drawLine(
      Offset(0, size.height * 0.45),
      Offset(size.width, size.height * 0.45),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.65),
      Offset(size.width, size.height * 0.65),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.38, 0),
      Offset(size.width * 0.38, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.62, 0),
      Offset(size.width * 0.62, size.height),
      roadPaint,
    );

    // Minor roads
    canvas.drawLine(
      Offset(0, size.height * 0.28),
      Offset(size.width, size.height * 0.28),
      roadPaintMinor,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.82),
      Offset(size.width, size.height * 0.82),
      roadPaintMinor,
    );
    canvas.drawLine(
      Offset(size.width * 0.2, 0),
      Offset(size.width * 0.2, size.height),
      roadPaintMinor,
    );
    canvas.drawLine(
      Offset(size.width * 0.78, 0),
      Offset(size.width * 0.78, size.height),
      roadPaintMinor,
    );

    // ── Park patches ─────────────────────────────────────────────────────
    final parkPaint = Paint()..color = const Color(0xFFD4EAC8);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.05, size.height * 0.15, 60, 40),
        const Radius.circular(8),
      ),
      parkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.7, size.height * 0.7, 50, 34),
        const Radius.circular(8),
      ),
      parkPaint,
    );

    // ── Water ─────────────────────────────────────────────────────────────
    final waterPaint = Paint()..color = const Color(0xFFBBDDE6);
    final waterPath = Path()
      ..moveTo(size.width * 0.82, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.6)
      ..quadraticBezierTo(
        size.width * 0.88,
        size.height * 0.4,
        size.width * 0.82,
        0,
      )
      ..close();
    canvas.drawPath(waterPath, waterPaint);

    // ── Coverage circle ────────────────────────────────────────────────
    final coveragePaint = Paint()
      ..color = Colors.blue.withOpacity(0.06)
      ..style = PaintingStyle.fill;
    final coverageBorder = Paint()
      ..color = Colors.blue.withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final centre = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(centre, size.width * 0.32, coveragePaint);
    canvas.drawCircle(centre, size.width * 0.32, coverageBorder);

    // ── User pin (centre) ─────────────────────────────────────────────
    _drawPin(
      canvas,
      centre,
      Colors.blue,
      Icons.person,
      'You',
      size,
      radius: 14,
    );

    // ── Volunteer pins ────────────────────────────────────────────────
    if (volunteers.isNotEmpty) {
      final rng = math.Random(42);
      for (int i = 0; i < volunteers.length; i++) {
        final v = volunteers[i];
        final angle = (i / volunteers.length) * 2 * math.pi;
        final dist = size.width * 0.15 + rng.nextDouble() * size.width * 0.12;
        final pos = Offset(
          centre.dx + math.cos(angle) * dist,
          centre.dy + math.sin(angle) * dist,
        );
        _drawPin(
          canvas,
          pos,
          v.isAvailable ? _MC.safe : Colors.grey,
          Icons.people,
          '',
          size,
          radius: 10,
        );
      }
    }

    // ── Incident pins ─────────────────────────────────────────────────
    for (final incident in incidents) {
      final pos = _project(incident.location, size);
      final isSelected = incident.id == selectedId;
      final color = _incidentColorStatic(incident.type);
      _drawIncidentPin(canvas, pos, color, incident.type, isSelected, size);
    }
  }

  void _drawPin(
    Canvas canvas,
    Offset pos,
    Color color,
    IconData icon,
    String label,
    Size size, {
    double radius = 13,
  }) {
    // Shadow
    canvas.drawCircle(
      pos + const Offset(0, 2),
      radius + 2,
      Paint()..color = Colors.black.withOpacity(0.18),
    );
    // Circle
    canvas.drawCircle(pos, radius, Paint()..color = color);
    canvas.drawCircle(
      pos,
      radius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    if (label.isNotEmpty) {
      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
    }
  }

  void _drawIncidentPin(
    Canvas canvas,
    Offset pos,
    Color color,
    String type,
    bool isSelected,
    Size size,
  ) {
    final r = isSelected ? 18.0 : 14.0;

    if (isSelected) {
      canvas.drawCircle(pos, r + 8, Paint()..color = color.withOpacity(0.2));
    }

    canvas.drawCircle(
      pos + const Offset(0, 2),
      r + 2,
      Paint()..color = Colors.black.withOpacity(0.2),
    );
    canvas.drawCircle(pos, r, Paint()..color = color);
    canvas.drawCircle(
      pos,
      r,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );

    // Type initial
    final letter = type.substring(0, 1);
    final tp = TextPainter(
      text: TextSpan(
        text: letter,
        style: TextStyle(
          color: Colors.white,
          fontSize: isSelected ? 11 : 9,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
  }

  Color _incidentColorStatic(String type) {
    switch (type) {
      case 'Medical':
        return _MC.safe;
      case 'Fire':
        return _MC.danger;
      case 'Flood':
        return _MC.blue;
      case 'Accident':
        return _MC.warning;
      default:
        return _MC.muted;
    }
  }

  @override
  bool shouldRepaint(_ChennaiMapPainter old) =>
      old.incidents != incidents ||
      old.volunteers != volunteers ||
      old.selectedId != selectedId;
}
