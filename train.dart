import 'package:flutter/material.dart';


void main() {
  runApp(const HeroNetworkApp());
}

class HeroNetworkApp extends StatelessWidget {
  const HeroNetworkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Network',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: const Color(0xFFF2EDE8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD94035),
          background: const Color(0xFFF2EDE8),
        ),
      ),
      home: const TrainingScreen(),
    );
  }
}

// ─────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────

enum BlockStatus { locked, inProgress, completed }

class TrainingBlock {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final Color lightColor;
  final int xpReward;
  final int level;
  final BlockStatus status;
  final double progress; // 0.0 - 1.0
  final List<TrainingMission> missions;
  final bool isArmy;

  const TrainingBlock({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.lightColor,
    required this.xpReward,
    required this.level,
    required this.status,
    this.progress = 0.0,
    this.missions = const [],
    this.isArmy = false,
  });
}

class TrainingMission {
  final String title;
  final String type; // 'quiz', 'drill', 'practical', 'puzzle'
  final int xp;
  final int durationMin;
  final bool completed;
  final String? score;

  const TrainingMission({
    required this.title,
    required this.type,
    required this.xp,
    required this.durationMin,
    this.completed = false,
    this.score,
  });
}

// ─────────────────────────────────────────────
// TRAINING DATA
// ─────────────────────────────────────────────

final List<TrainingBlock> trainingBlocks = [
  TrainingBlock(
    id: 'army',
    title: 'ARMY CORPS',
    subtitle: 'Elite Volunteer Force',
    description:
        'Reserved for heroes who master all levels. Real coordinated operations with defense personnel.',
    icon: Icons.military_tech_rounded,
    color: const Color(0xFF1A1A2E),
    lightColor: const Color(0xFF2D2D4A),
    xpReward: 5000,
    level: 9,
    status: BlockStatus.locked,
    progress: 0.0,
    isArmy: true,
    missions: [
      TrainingMission(title: 'Joint Disaster Op — Flood Zone Alpha', type: 'operation', xp: 800, durationMin: 120),
      TrainingMission(title: 'Evacuation Coordination Drill', type: 'operation', xp: 600, durationMin: 90),
      TrainingMission(title: 'Search & Rescue Night Mission', type: 'operation', xp: 700, durationMin: 100),
    ],
  ),
  TrainingBlock(
    id: 'real_ops',
    title: 'REAL OPERATIONS',
    subtitle: 'Live Scenario Response',
    description:
        'AI-reconstructed past disasters. React in real-time simulations of actual flood, fire, and mass-casualty events.',
    icon: Icons.crisis_alert_rounded,
    color: const Color(0xFF8B1A1A),
    lightColor: const Color(0xFFFFE8E8),
    xpReward: 2000,
    level: 8,
    status: BlockStatus.locked,
    progress: 0.0,
    missions: [
      TrainingMission(title: '2015 Chennai Floods — Sector 4 Rescue', type: 'operation', xp: 350, durationMin: 45),
      TrainingMission(title: 'Multi-building Fire — Mass Evacuation', type: 'operation', xp: 300, durationMin: 40),
      TrainingMission(title: 'Earthquake Aftermath — Triage Setup', type: 'operation', xp: 400, durationMin: 60),
    ],
  ),
  TrainingBlock(
    id: 'ai_drills',
    title: 'AI SCENARIO DRILLS',
    subtitle: 'Adaptive Intelligence Training',
    description:
        'AI-generated emergencies that adapt to your weak points. Advanced quizzes and decision-tree puzzles.',
    icon: Icons.psychology_rounded,
    color: const Color(0xFF0D5B8E),
    lightColor: const Color(0xFFE3F2FD),
    xpReward: 1200,
    level: 7,
    status: BlockStatus.locked,
    progress: 0.0,
    missions: [
      TrainingMission(title: 'Dynamic Triage Scenario', type: 'quiz', xp: 180, durationMin: 15),
      TrainingMission(title: 'Multi-hazard Decision Tree', type: 'puzzle', xp: 200, durationMin: 20),
      TrainingMission(title: 'Crowd Control Simulation', type: 'drill', xp: 220, durationMin: 25),
      TrainingMission(title: 'Resource Allocation Challenge', type: 'puzzle', xp: 160, durationMin: 18),
    ],
  ),
  TrainingBlock(
    id: 'disaster_mgmt',
    title: 'DISASTER MANAGEMENT',
    subtitle: 'With Rescue Teams',
    description:
        'Hands-on sessions with NDRF and state rescue teams. Rope rescue, water safety, and mass triage.',
    icon: Icons.flood_rounded,
    color: const Color(0xFF2E6B4F),
    lightColor: const Color(0xFFE8F5E9),
    xpReward: 1000,
    level: 6,
    status: BlockStatus.locked,
    progress: 0.0,
    missions: [
      TrainingMission(title: 'NDRF Rope Rescue Drill', type: 'practical', xp: 200, durationMin: 60),
      TrainingMission(title: 'Flood Boat Operation Basics', type: 'practical', xp: 180, durationMin: 45),
      TrainingMission(title: 'Mass Casualty Triage Setup', type: 'practical', xp: 220, durationMin: 50),
    ],
  ),
  TrainingBlock(
    id: 'fire_dept',
    title: 'FIRE DEPARTMENT',
    subtitle: 'Hands-On Practice',
    description:
        'Live drills at your local fire station. Extinguisher handling, hose operation, and evacuation lead.',
    icon: Icons.local_fire_department_rounded,
    color: const Color(0xFFB84A00),
    lightColor: const Color(0xFFFFF3E0),
    xpReward: 800,
    level: 5,
    status: BlockStatus.inProgress,
    progress: 0.35,
    missions: [
      TrainingMission(title: 'Fire Extinguisher Drill', type: 'practical', xp: 150, durationMin: 30, completed: true, score: '92/100'),
      TrainingMission(title: 'Building Evacuation Lead', type: 'practical', xp: 180, durationMin: 40),
      TrainingMission(title: 'Hose Operation Basics', type: 'practical', xp: 160, durationMin: 35),
      TrainingMission(title: 'Fire Safety Quiz', type: 'quiz', xp: 80, durationMin: 10),
    ],
  ),
  TrainingBlock(
    id: 'cpr_firstaid',
    title: 'CPR & FIRST AID',
    subtitle: 'Local Camps & Hospitals',
    description:
        'Certified sessions at partnered hospitals and community health camps near you.',
    icon: Icons.favorite_rounded,
    color: const Color(0xFFD94035),
    lightColor: const Color(0xFFFFEBEB),
    xpReward: 600,
    level: 4,
    status: BlockStatus.inProgress,
    progress: 0.6,
    missions: [
      TrainingMission(title: 'CPR Certification — Apollo Hospital', type: 'practical', xp: 200, durationMin: 90, completed: true, score: '88/100'),
      TrainingMission(title: 'Wound Care & Bandaging', type: 'practical', xp: 120, durationMin: 45, completed: true, score: '95/100'),
      TrainingMission(title: 'Choking & Heimlich Maneuver', type: 'practical', xp: 100, durationMin: 30),
      TrainingMission(title: 'AED Usage Quiz', type: 'quiz', xp: 60, durationMin: 8),
    ],
  ),
  TrainingBlock(
    id: 'situation_puzzles',
    title: 'SITUATION PUZZLES',
    subtitle: 'Logic & Survival Thinking',
    description:
        'Decision-making games, scenario puzzles, and logic challenges that sharpen survival instincts.',
    icon: Icons.extension_rounded,
    color: const Color(0xFF6A3FA0),
    lightColor: const Color(0xFFF3E5F5),
    xpReward: 400,
    level: 3,
    status: BlockStatus.completed,
    progress: 1.0,
    missions: [
      TrainingMission(title: 'Escape Route Puzzle', type: 'puzzle', xp: 80, durationMin: 12, completed: true, score: '100/100'),
      TrainingMission(title: 'Crowd Panic Management Game', type: 'puzzle', xp: 90, durationMin: 15, completed: true, score: '78/100'),
      TrainingMission(title: 'Resource Priority Challenge', type: 'puzzle', xp: 70, durationMin: 10, completed: true, score: '85/100'),
      TrainingMission(title: 'Emergency Communication Quiz', type: 'quiz', xp: 50, durationMin: 7, completed: true, score: '92/100'),
    ],
  ),
  TrainingBlock(
    id: 'basic_knowledge',
    title: 'BASIC KNOWLEDGE',
    subtitle: 'Emergency Awareness',
    description:
        'Fundamental knowledge of disaster types, emergency signals, and community safety protocols.',
    icon: Icons.menu_book_rounded,
    color: const Color(0xFF2A7ABD),
    lightColor: const Color(0xFFE3F2FD),
    xpReward: 250,
    level: 2,
    status: BlockStatus.completed,
    progress: 1.0,
    missions: [
      TrainingMission(title: 'Disaster Types Overview', type: 'quiz', xp: 40, durationMin: 8, completed: true, score: '95/100'),
      TrainingMission(title: 'Emergency Signal Recognition', type: 'quiz', xp: 35, durationMin: 6, completed: true, score: '90/100'),
      TrainingMission(title: 'Community Alert Systems', type: 'quiz', xp: 45, durationMin: 9, completed: true, score: '88/100'),
    ],
  ),
  TrainingBlock(
    id: 'survival_basics',
    title: 'SURVIVAL BASICS',
    subtitle: 'Start Your Hero Journey',
    description:
        'Core survival skills: food, water, shelter, signaling for help. Every hero starts here.',
    icon: Icons.eco_rounded,
    color: const Color(0xFF3D7A3A),
    lightColor: const Color(0xFFE8F5E9),
    xpReward: 150,
    level: 1,
    status: BlockStatus.completed,
    progress: 1.0,
    missions: [
      TrainingMission(title: 'Water Safety & Purification', type: 'quiz', xp: 30, durationMin: 5, completed: true, score: '100/100'),
      TrainingMission(title: 'Basic Shelter Principles', type: 'quiz', xp: 25, durationMin: 5, completed: true, score: '96/100'),
      TrainingMission(title: 'Survival Signaling Methods', type: 'quiz', xp: 30, durationMin: 6, completed: true, score: '92/100'),
      TrainingMission(title: 'Emergency Kit Checklist', type: 'quiz', xp: 20, durationMin: 4, completed: true, score: '100/100'),
    ],
  ),
];

// ─────────────────────────────────────────────
// TRAINING SCREEN
// ─────────────────────────────────────────────

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Reverse so survival is at bottom visually (we show list top-to-bottom but label it as bottom-to-top)
    return Scaffold(
      backgroundColor: const Color(0xFFF2EDE8),
      body: SafeArea(
        child: Column(
          children: [
            _TrainingHeader(),
            _XPSummaryBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                children: [
                  const _ChainLegend(),
                  const SizedBox(height: 16),
                  ...trainingBlocks.map((block) => _TrainingBlockCard(block: block)),
                ],
              ),
            ),
          ],
        ),
      ),
     
    );
  }
}

class _TrainingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Training Path', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A), letterSpacing: -0.5)),
              const SizedBox(height: 2),
              Row(
                children: [
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFD94035), shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  const Text('Hero Level 3 · Ravi Kumar', style: TextStyle(fontSize: 13, color: Color(0xFF888880))),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFD94035),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.bolt_rounded, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text('680 XP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _XPSummaryBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            _StatChip(label: 'Completed', value: '3', color: const Color(0xFF3D7A3A)),
            _Divider(),
            _StatChip(label: 'In Progress', value: '2', color: const Color(0xFFD94035)),
            _Divider(),
            _StatChip(label: 'Locked', value: '4', color: const Color(0xFF888880)),
            _Divider(),
            _StatChip(label: 'Total XP', value: '11.6K', color: const Color(0xFF0D5B8E)),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 9, color: Color(0xFF888880), fontWeight: FontWeight.w500), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 28, color: const Color(0xFFE8E4DF));
}

class _ChainLegend extends StatelessWidget {
  const _ChainLegend();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.military_tech_rounded, size: 14, color: Color(0xFF1A1A2E)),
        const SizedBox(width: 6),
        const Text('Army (Top)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
        const SizedBox(width: 12),
        Container(width: 20, height: 2, color: const Color(0xFFCCCCC5)),
        const SizedBox(width: 12),
        const Icon(Icons.eco_rounded, size: 14, color: Color(0xFF3D7A3A)),
        const SizedBox(width: 6),
        const Text('Survival (Base)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF3D7A3A))),
        const Spacer(),
        const Text('↑ Scroll up', style: TextStyle(fontSize: 10, color: Color(0xFFAAAAAA))),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// TRAINING BLOCK CARD
// ─────────────────────────────────────────────

class _TrainingBlockCard extends StatelessWidget {
  final TrainingBlock block;
  const _TrainingBlockCard({required this.block});

  @override
  Widget build(BuildContext context) {
    final bool isLocked = block.status == BlockStatus.locked;
    final bool isCompleted = block.status == BlockStatus.completed;
    final bool isInProgress = block.status == BlockStatus.inProgress;

    return GestureDetector(
      onTap: isLocked ? null : () => _openDetail(context, block),
      child: Column(
        children: [
          // Connector line from previous block
          if (block.id != 'army')
            _ConnectorLine(
              isUnlocked: !isLocked,
              color: isCompleted ? block.color : const Color(0xFFD0CCC6),
            ),

          // The card
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: isLocked ? const Color(0xFFEAE6E0) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isInProgress ? block.color.withOpacity(0.5) : (isCompleted ? block.color.withOpacity(0.3) : const Color(0xFFDDD9D3)),
                width: isInProgress ? 2 : 1,
              ),
              boxShadow: isLocked
                  ? []
                  : [BoxShadow(color: block.color.withOpacity(0.1), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: block.isArmy ? _ArmyBlock(block: block) : _StandardBlock(block: block, isLocked: isLocked, isCompleted: isCompleted, isInProgress: isInProgress),
          ),
        ],
      ),
    );
  }

  void _openDetail(BuildContext context, TrainingBlock block) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => TrainingDetailScreen(block: block)));
  }
}

class _ConnectorLine extends StatelessWidget {
  final bool isUnlocked;
  final Color color;
  const _ConnectorLine({required this.isUnlocked, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              width: 2,
              height: 20,
              color: isUnlocked ? color : const Color(0xFFD0CCC6),
            ),
            if (isUnlocked)
              Icon(Icons.arrow_drop_up_rounded, color: color, size: 20)
            else
              Icon(Icons.lock_outline_rounded, size: 14, color: const Color(0xFFB0ACA6)),
          ],
        ),
      ],
    );
  }
}

class _StandardBlock extends StatelessWidget {
  final TrainingBlock block;
  final bool isLocked, isCompleted, isInProgress;
  const _StandardBlock({required this.block, required this.isLocked, required this.isCompleted, required this.isInProgress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Icon circle
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isLocked ? const Color(0xFFE0DDD8) : block.lightColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              isLocked ? Icons.lock_rounded : block.icon,
              color: isLocked ? const Color(0xFFB0ACA6) : block.color,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          // Text + progress
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(block.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: isLocked ? const Color(0xFFB0ACA6) : const Color(0xFF1A1A1A),
                            letterSpacing: 0.3,
                          )),
                    ),
                    _StatusBadge(isLocked: isLocked, isCompleted: isCompleted, isInProgress: isInProgress, color: block.color),
                  ],
                ),
                const SizedBox(height: 2),
                Text(block.subtitle, style: TextStyle(fontSize: 12, color: isLocked ? const Color(0xFFCCC8C3) : const Color(0xFF888880))),
                const SizedBox(height: 8),
                if (!isLocked) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: block.progress,
                      backgroundColor: const Color(0xFFEEEAE4),
                      valueColor: AlwaysStoppedAnimation<Color>(block.color),
                      minHeight: 5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('${(block.progress * 100).toInt()}% complete', style: TextStyle(fontSize: 10, color: block.color, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(color: block.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Text('+${block.xpReward} XP', style: TextStyle(fontSize: 10, color: block.color, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ] else
                  Text(
                    'Complete level ${block.level - 1} to unlock',
                    style: const TextStyle(fontSize: 10, color: Color(0xFFB0ACA6)),
                  ),
              ],
            ),
          ),
          if (!isLocked) ...[
            const SizedBox(width: 8),
            Icon(Icons.chevron_right_rounded, color: block.color.withOpacity(0.6), size: 20),
          ],
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isLocked, isCompleted, isInProgress;
  final Color color;
  const _StatusBadge({required this.isLocked, required this.isCompleted, required this.isInProgress, required this.color});

  @override
  Widget build(BuildContext context) {
    if (isLocked) return const SizedBox.shrink();
    if (isCompleted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(8)),
        child: const Row(
          children: [
            Icon(Icons.check_circle_rounded, size: 11, color: Color(0xFF3D7A3A)),
            SizedBox(width: 3),
            Text('Done', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF3D7A3A))),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 4),
          Text('Active', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }
}

class _ArmyBlock extends StatelessWidget {
  final TrainingBlock block;
  const _ArmyBlock({required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF2D2D4A), Color(0xFF1A1A2E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.amber.withOpacity(0.4), width: 1),
                ),
                child: const Icon(Icons.military_tech_rounded, color: Colors.amber, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('ARMY CORPS', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 1.5)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.amber.withOpacity(0.4))),
                          child: const Text('ELITE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.amber, letterSpacing: 1)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text('Elite Volunteer Force', style: TextStyle(fontSize: 12, color: Colors.white60)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock_rounded, color: Colors.amber, size: 16),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Complete ALL levels below to unlock. Only the most dedicated heroes are eligible.',
                    style: TextStyle(fontSize: 11, color: Colors.white70, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _ArmyStatChip(label: 'XP Reward', value: '+5000 XP', icon: Icons.bolt_rounded, color: Colors.amber),
              const SizedBox(width: 10),
              _ArmyStatChip(label: 'Missions', value: '3 Ops', icon: Icons.flag_rounded, color: const Color(0xFF7EB8E0)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ArmyStatChip extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const _ArmyStatChip({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(icon, color: color, size: 14),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
                Text(label, style: const TextStyle(fontSize: 9, color: Colors.white38)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TRAINING DETAIL SCREEN
// ─────────────────────────────────────────────

class TrainingDetailScreen extends StatelessWidget {
  final TrainingBlock block;
  const TrainingDetailScreen({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = block.status == BlockStatus.completed;

    return Scaffold(
      backgroundColor: const Color(0xFFF2EDE8),
      body: CustomScrollView(
        slivers: [
          _DetailAppBar(block: block),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BlockStats(block: block),
                  const SizedBox(height: 20),
                  if (isCompleted) _ScoreCard(block: block),
                  const SizedBox(height: 20),
                  _MissionsSection(block: block),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailAppBar extends StatelessWidget {
  final TrainingBlock block;
  const _DetailAppBar({required this.block});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      backgroundColor: block.color,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [block.color, block.color.withOpacity(0.7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48, height: 48,
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                        child: Icon(block.icon, color: Colors.white, size: 26),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('LEVEL ${block.level}', style: const TextStyle(fontSize: 11, color: Colors.white60, letterSpacing: 2, fontWeight: FontWeight.w600)),
                            Text(block.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(block.description, style: const TextStyle(fontSize: 12, color: Colors.white70, height: 1.4)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BlockStats extends StatelessWidget {
  final TrainingBlock block;
  const _BlockStats({required this.block});

  @override
  Widget build(BuildContext context) {
    final completed = block.missions.where((m) => m.completed).length;
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _DetailStat(value: '$completed/${block.missions.length}', label: 'Completed', color: block.color),
              Container(width: 1, height: 36, color: const Color(0xFFEEEAE4)),
              _DetailStat(value: '+${block.xpReward}', label: 'Total XP', color: block.color),
              Container(width: 1, height: 36, color: const Color(0xFFEEEAE4)),
              _DetailStat(value: '${block.missions.fold(0, (s, m) => s + m.durationMin)} min', label: 'Duration', color: block.color),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: block.progress,
              backgroundColor: const Color(0xFFEEEAE4),
              valueColor: AlwaysStoppedAnimation<Color>(block.color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${(block.progress * 100).toInt()}% complete', style: TextStyle(fontSize: 11, color: block.color, fontWeight: FontWeight.w600)),
              Text('${block.missions.length} missions', style: const TextStyle(fontSize: 11, color: Color(0xFF888880))),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailStat extends StatelessWidget {
  final String value, label;
  final Color color;
  const _DetailStat({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: color)),
          Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF888880))),
        ],
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final TrainingBlock block;
  const _ScoreCard({required this.block});

  @override
  Widget build(BuildContext context) {
    final scores = block.missions.where((m) => m.score != null).map((m) {
      final parts = m.score!.split('/');
      return parts.length == 2 ? int.tryParse(parts[0]) ?? 0 : 0;
    }).toList();
    final avg = scores.isEmpty ? 0 : scores.reduce((a, b) => a + b) ~/ scores.length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3D7A3A).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: const Color(0xFF3D7A3A), shape: BoxShape.circle),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$avg', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                const Text('%', style: TextStyle(fontSize: 9, color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Average Score', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A))),
                SizedBox(height: 3),
                Text('Great performance! Keep it up to unlock next level.', style: TextStyle(fontSize: 12, color: Color(0xFF3D7A3A), height: 1.3)),
              ],
            ),
          ),
          const Icon(Icons.emoji_events_rounded, color: Color(0xFF3D7A3A), size: 28),
        ],
      ),
    );
  }
}

class _MissionsSection extends StatelessWidget {
  final TrainingBlock block;
  const _MissionsSection({required this.block});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Missions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 12),
        ...block.missions.asMap().entries.map((entry) => _MissionCard(
              mission: entry.value,
              index: entry.key,
              blockColor: block.color,
              isLocked: block.status == BlockStatus.locked ||
                  (entry.key > 0 && !block.missions[entry.key - 1].completed && !entry.value.completed),
            )),
      ],
    );
  }
}

class _MissionCard extends StatelessWidget {
  final TrainingMission mission;
  final int index;
  final Color blockColor;
  final bool isLocked;
  const _MissionCard({required this.mission, required this.index, required this.blockColor, required this.isLocked});

  static const Map<String, Color> _typeColors = {
    'quiz': Color(0xFF2A7ABD),
    'drill': Color(0xFFB84A00),
    'practical': Color(0xFF2E6B4F),
    'puzzle': Color(0xFF6A3FA0),
    'operation': Color(0xFF8B1A1A),
  };

  static const Map<String, IconData> _typeIcons = {
    'quiz': Icons.quiz_rounded,
    'drill': Icons.fitness_center_rounded,
    'practical': Icons.handshake_rounded,
    'puzzle': Icons.extension_rounded,
    'operation': Icons.crisis_alert_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final typeColor = _typeColors[mission.type] ?? blockColor;
    final typeIcon = _typeIcons[mission.type] ?? Icons.task_rounded;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isLocked ? const Color(0xFFF5F2EE) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: mission.completed ? const Color(0xFF3D7A3A).withOpacity(0.3) : const Color(0xFFE8E4DF),
        ),
        boxShadow: isLocked ? [] : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: isLocked ? const Color(0xFFE0DDD8) : typeColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isLocked ? Icons.lock_outline_rounded : (mission.completed ? Icons.check_rounded : typeIcon),
              color: isLocked ? const Color(0xFFB0ACA6) : (mission.completed ? const Color(0xFF3D7A3A) : typeColor),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mission.title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isLocked ? const Color(0xFFB0ACA6) : const Color(0xFF1A1A1A),
                    )),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isLocked ? const Color(0xFFE8E4DF) : typeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        mission.type.toUpperCase(),
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: isLocked ? const Color(0xFFB0ACA6) : typeColor, letterSpacing: 0.5),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text('${mission.durationMin} min', style: const TextStyle(fontSize: 11, color: Color(0xFF888880))),
                    const SizedBox(width: 6),
                    Text('+${mission.xp} XP', style: TextStyle(fontSize: 11, color: isLocked ? const Color(0xFFB0ACA6) : blockColor, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (mission.score != null)
            Column(
              children: [
                Text(mission.score!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF3D7A3A))),
                const Text('score', style: TextStyle(fontSize: 9, color: Color(0xFF888880))),
              ],
            )
          else if (!isLocked && !mission.completed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: blockColor, borderRadius: BorderRadius.circular(8)),
              child: const Text('Start', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
            )
          else if (isLocked)
            const Icon(Icons.lock_rounded, color: Color(0xFFB0ACA6), size: 18),
        ],
      ),
    );
  }
}

