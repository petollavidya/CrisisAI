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
// ENUMS & DATA MODELS
// ─────────────────────────────────────────────

enum BlockStatus { locked, inProgress, completed }

enum BlockTier { bronze, silver, gold, army }

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
  final double progress;
  final List<TrainingMission> missions;
  final bool isArmy;
  final BlockTier tier;
  final String
  blockType; // 'basic','survival','puzzle','medical','fire','rescue','drill','combined','army'

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
    this.tier = BlockTier.bronze,
    this.blockType = 'basic',
  });
}

class TrainingMission {
  final String title;
  final String type;
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

class PuzzleQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const PuzzleQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class DrillScenario {
  final String title;
  final String department;
  final String location;
  final String authorisedPerson;
  final String objective;
  final List<String> steps;
  final int durationMin;

  const DrillScenario({
    required this.title,
    required this.department,
    required this.location,
    required this.authorisedPerson,
    required this.objective,
    required this.steps,
    required this.durationMin,
  });
}

// ─────────────────────────────────────────────
// PUZZLE DATA
// ─────────────────────────────────────────────

const List<PuzzleQuestion> survivalPuzzles = [
  PuzzleQuestion(
    question:
        'A flood is rising fast. You are on the ground floor. What is the FIRST thing you should do?',
    options: [
      'Collect valuables',
      'Move to the highest floor immediately',
      'Call for help from the window',
      'Switch off electricity at mains',
    ],
    correctIndex: 3,
    explanation:
        'Always switch off electricity first to prevent electrocution, then move upward.',
  ),
  PuzzleQuestion(
    question:
        'You find an unconscious person during a fire. They are breathing. What do you do?',
    options: [
      'Leave them and exit',
      'Put them in recovery position and shout for help',
      'Splash water on face',
      'Perform CPR immediately',
    ],
    correctIndex: 1,
    explanation:
        'A breathing unconscious person needs recovery position. CPR is for non-breathing victims.',
  ),
  PuzzleQuestion(
    question: 'During an earthquake, you are indoors. The safest action is?',
    options: [
      'Run outside immediately',
      'Stand near windows',
      'Drop, cover, hold under a sturdy table',
      'Go to the elevator',
    ],
    correctIndex: 2,
    explanation:
        'Drop-Cover-Hold is the globally recommended protocol during an earthquake.',
  ),
  PuzzleQuestion(
    question:
        'Your water supply is contaminated after a disaster. You should drink?',
    options: [
      'River water directly',
      'Boiled or chemically treated water',
      'Soft drinks only',
      'Rainwater without treatment',
    ],
    correctIndex: 1,
    explanation:
        'Boiling or chemical treatment (chlorine/iodine tablets) makes water safe to drink.',
  ),
  PuzzleQuestion(
    question:
        'Which color triage tag indicates a victim who needs IMMEDIATE life-saving treatment?',
    options: ['Green', 'Yellow', 'Red', 'Black'],
    correctIndex: 2,
    explanation:
        'Red = Immediate. Yellow = Delayed. Green = Minor. Black = Deceased/Unsalvageable.',
  ),
  PuzzleQuestion(
    question: 'During a building evacuation, you should use?',
    options: [
      'Elevator for speed',
      'Staircase only',
      'Windows if ground floor is blocked',
      'Wait for rescue in your room',
    ],
    correctIndex: 1,
    explanation:
        'Always use stairs. Elevators may fail, trap you, or open at fire floors.',
  ),
  PuzzleQuestion(
    question: 'The universal distress signal using sound is?',
    options: [
      '4 short blasts',
      '2 long blasts',
      'SOS: 3 short + 3 long + 3 short',
      'Continuous horn',
    ],
    correctIndex: 2,
    explanation:
        'SOS (• • • — — — • • •) is the internationally recognized distress signal.',
  ),
  PuzzleQuestion(
    question:
        'A victim has a deep cut on their arm and is bleeding heavily. First action?',
    options: [
      'Apply tourniquet immediately',
      'Apply direct pressure with clean cloth',
      'Pour antiseptic directly',
      'Elevate arm and wait',
    ],
    correctIndex: 1,
    explanation:
        'Direct pressure is the first step. Tourniquet is a last resort for limb-threatening bleeding.',
  ),
  PuzzleQuestion(
    question: 'During a gas leak in a building, you should NOT?',
    options: [
      'Open windows and doors',
      'Switch on lights or use phone inside',
      'Evacuate immediately',
      'Alert neighbors',
    ],
    correctIndex: 1,
    explanation:
        'Any spark — including switching on lights or using phones — can ignite leaked gas.',
  ),
  PuzzleQuestion(
    question: 'Identify the correct order for basic life support?',
    options: [
      'Airway → Breathing → Circulation',
      'Circulation → Airway → Breathing',
      'Breathing → Circulation → Airway',
      'Airway → Circulation → Breathing',
    ],
    correctIndex: 0,
    explanation:
        'ABC: Airway first, then Breathing, then Circulation — the standard BLS protocol.',
  ),
];

// ─────────────────────────────────────────────
// DRILL DATA
// ─────────────────────────────────────────────

const List<DrillScenario> fireDrills = [
  DrillScenario(
    title: 'Kitchen Fire Containment',
    department: 'Fire & Rescue Services',
    location: 'Chennai Fire Station, Anna Nagar',
    authorisedPerson: 'Fire Officer R. Venkatesh',
    objective:
        'Contain a Class B fire using CO2 extinguisher without spreading flames.',
    steps: [
      'Don PPE — helmet, gloves, boots',
      'Identify fire class (cooking oil = Class B)',
      'Grab CO2 extinguisher',
      'PASS: Pull pin, Aim at base, Squeeze handle, Sweep side to side',
      'Do not use water on oil fire',
      'Alert others and assist evacuation',
    ],
    durationMin: 30,
  ),
  DrillScenario(
    title: 'High-Rise Evacuation Lead',
    department: 'Fire & Rescue Services',
    location: 'TNFRS Training Ground, Egmore',
    authorisedPerson: 'Senior Officer P. Meena',
    objective:
        'Lead 20 occupants from 8th floor to assembly point within 4 minutes.',
    steps: [
      'Sound alarm on your floor',
      'Check doors for heat before opening',
      'Direct people to nearest stairwell',
      'Count occupants at each landing',
      'Assist differently-abled persons',
      'Report headcount at assembly point',
    ],
    durationMin: 40,
  ),
  DrillScenario(
    title: 'Hose Operation at Live Site',
    department: 'Fire & Rescue Services',
    location: 'Tambaram Fire Station',
    authorisedPerson: 'Sub-Officer K. Rajan',
    objective:
        'Operate a 65mm delivery hose to extinguish a controlled live fire.',
    steps: [
      'Unroll hose without kinks',
      'Connect to hydrant coupling',
      'Signal to open valve slowly',
      'Grip hose with both hands, crouch low',
      'Aim at base of fire, not the flames',
      'Signal cut-off when fire is out',
    ],
    durationMin: 45,
  ),
  DrillScenario(
    title: 'Search & Rescue in Smoke-Filled Corridor',
    department: 'Fire & Rescue Services',
    location: 'Mock Structure, Guindy',
    authorisedPerson: 'Fire Officer S. Dharani',
    objective:
        'Navigate smoke-filled corridors using a guideline rope and locate a dummy victim.',
    steps: [
      'Don SCBA and check air level',
      'Attach guideline rope at entry',
      'Crawl below smoke level',
      'Navigate using wall-touch method',
      'Locate and tag dummy with triage marker',
      'Withdraw following guideline rope',
    ],
    durationMin: 50,
  ),
  DrillScenario(
    title: 'Electrical Fire Safety Protocol',
    department: 'Fire & Rescue Services',
    location: 'TNEB Training Centre, Royapuram',
    authorisedPerson: 'Chief Electrical Officer M. Suresh',
    objective:
        'Handle Class C (electrical) fire and de-energise source safely.',
    steps: [
      'Do NOT use water on electrical fire',
      'Locate and isolate main circuit breaker',
      'Use dry powder extinguisher',
      'Maintain safe standoff distance',
      'Prevent others from re-energising',
      'Document panel board status',
    ],
    durationMin: 35,
  ),
  DrillScenario(
    title: 'Casualty Extraction from Burning Vehicle',
    department: 'Fire & Rescue Services',
    location: 'SDRF Training Facility, Poonamallee',
    authorisedPerson: 'Senior Rescue Officer V. Priya',
    objective:
        'Extract an immobilised casualty from a simulated burning vehicle safely.',
    steps: [
      'Park rescue vehicle upwind of fire',
      'Stabilise the casualty vehicle using chocks',
      'Break glass using centre punch',
      'Apply neck collar before extraction',
      'Use long spine board for extraction',
      'Move casualty 30m from vehicle before treatment',
    ],
    durationMin: 60,
  ),
  DrillScenario(
    title: 'Mass Evacuation Coordination Drill',
    department: 'Fire & Rescue Services',
    location: 'Rajiv Gandhi Government Hospital, Omandurar',
    authorisedPerson: 'Hospital Safety Officer Dr. S. Kavitha',
    objective:
        'Coordinate evacuation of 50+ hospital patients including bedridden persons.',
    steps: [
      'Activate hospital fire alarm',
      'Assign team roles: sweeper, guide, assembly warden',
      'Use evacuation chairs for mobility-impaired',
      'Clear all wards floor-by-floor starting from fire floor',
      'Do NOT use lifts for patients',
      'Establish triage post at assembly point',
    ],
    durationMin: 70,
  ),
];

const List<DrillScenario> rescueDrills = [
  DrillScenario(
    title: 'Flood Water Rescue with Boat',
    department: 'NDRF / SDRF',
    location: 'NDRF Regional Centre, Chennai',
    authorisedPerson: 'NDRF Inspector G. Arun',
    objective:
        'Navigate an inflatable rescue boat in fast-moving water and extract 3 victims.',
    steps: [
      'Don PFD and helmet',
      'Launch boat upstream of victim',
      'Approach victim from downstream side',
      'Throw rescue rope if within 10m',
      'Pull victim over bow — never the side',
      'Transport to safe elevated ground',
    ],
    durationMin: 60,
  ),
  DrillScenario(
    title: 'Rope Rescue from Height',
    department: 'NDRF / SDRF',
    location: 'SDRF Training Tower, Ambattur',
    authorisedPerson: 'Rope Rescue Specialist R. Devi',
    objective:
        'Perform a two-person rope rescue from a simulated 4th floor window.',
    steps: [
      'Set anchor point — belay device + backup',
      'Don harness and check buckle threefold',
      'Attach casualty in improvised seat harness',
      'Rappel in tandem controlling descent rate',
      'Signal ground crew for lower-off assist',
      'Document rescue in log sheet',
    ],
    durationMin: 90,
  ),
  DrillScenario(
    title: 'Collapsed Structure Victim Search',
    department: 'Urban Search & Rescue',
    location: 'Mock Rubble Site, Porur',
    authorisedPerson: 'USAR Team Leader N. Balaji',
    objective:
        'Use search dogs and listening devices to locate 2 victims in collapsed structure.',
    steps: [
      'Establish search grid on structure map',
      'Deploy canine search team first',
      'Use acoustic listening device in voids',
      'Mark confirmed locations with spray paint',
      'Stabilise debris before tunnelling',
      'Extricate victim using manual lifting frame',
    ],
    durationMin: 120,
  ),
  DrillScenario(
    title: 'Swiftwater Swimmer Rescue',
    department: 'State Disaster Response Force',
    location: 'Chembarambakkam Reservoir, Chennai',
    authorisedPerson: 'Swiftwater Rescue Trainer P. Sathish',
    objective:
        'Swim across a current and assist a panicking victim to shore using contact rescue.',
    steps: [
      'Assess current speed and hazards',
      'Enter water at 45° angle upstream',
      'Approach victim from behind to avoid being grabbed',
      'Apply cross-chest carry',
      'Angle body to use current for shore assistance',
      'Exit water at pre-selected calm eddy',
    ],
    durationMin: 75,
  ),
  DrillScenario(
    title: 'Mass Casualty Triage Setup',
    department: 'NDRF Medical Division',
    location: 'Govt Medical College, Omandurar',
    authorisedPerson: 'Dr. M. Vijayalakshmi',
    objective:
        'Set up a field triage post for 30 casualties using START protocol within 15 minutes.',
    steps: [
      'Mark four triage zones using coloured tape',
      'Assign one medic per zone',
      'Apply START: Breathing → Circulation → Mental Status',
      'Tag each patient Red/Yellow/Green/Black',
      'Direct ambulances by priority',
      'Document all tags in casualty register',
    ],
    durationMin: 90,
  ),
  DrillScenario(
    title: 'Night Search Operation with Torchlight Grid',
    department: 'NDRF / Police',
    location: 'Thiruvanmiyur Beach, Chennai',
    authorisedPerson: 'Police Inspector T. Ragavan',
    objective:
        'Conduct a night-time beach search for missing persons using grid formation.',
    steps: [
      'Brief team on missing person description',
      'Divide beach into 50m grid sectors',
      'Maintain 5m spacing between searchers',
      'Call "CHECK" every 100m for headcount',
      'Use whistle codes: 1 = stop, 3 = found',
      'Report findings to incident commander immediately',
    ],
    durationMin: 80,
  ),
  DrillScenario(
    title: 'Chemical Spill Rescue Protocol',
    department: 'NDRF HazMat Unit',
    location: 'Industrial Zone, Manali',
    authorisedPerson: 'HazMat Officer K. Selvam',
    objective:
        'Extract a victim from a chemical spill zone while avoiding contamination.',
    steps: [
      'Don Level B PPE — full-face respirator + chemical suit',
      'Establish hot/warm/cold zones with barrier tape',
      'Decontamination station set up in warm zone',
      'Enter hot zone in pair, never alone',
      'Extract victim without direct contact',
      'Conduct full decon before exiting warm zone',
    ],
    durationMin: 100,
  ),
];

const List<DrillScenario> medicalDrills = [
  DrillScenario(
    title: 'Adult CPR Certification',
    department: 'Medical & Health Services',
    location: 'Apollo Hospital, Greams Road',
    authorisedPerson: 'Dr. A. Subramanian (MBBS, MD)',
    objective:
        'Perform continuous chest compressions and rescue breaths for 2 minutes on a manikin.',
    steps: [
      'Check scene safety and call for help',
      'Check responsiveness — tap and shout',
      'Call 108 or delegate someone to call',
      'Begin 30 chest compressions at 100-120/min',
      'Open airway — head-tilt chin-lift',
      'Give 2 rescue breaths, each 1 second',
      'Continue 30:2 cycle until AED arrives',
    ],
    durationMin: 90,
  ),
  DrillScenario(
    title: 'Wound Care & Bandaging',
    department: 'Medical & Health Services',
    location: 'Primary Health Centre, Villivakkam',
    authorisedPerson: 'Nurse In-charge Sister Meenakshi',
    objective:
        'Clean, dress, and bandage three types of wounds correctly without contamination.',
    steps: [
      'Wash hands or don gloves',
      'Irrigate wound with clean saline',
      'Remove visible debris using sterile forceps',
      'Apply non-stick dressing pad',
      'Secure with roller bandage using figure-8 technique',
      'Check distal circulation after bandaging',
    ],
    durationMin: 45,
  ),
  DrillScenario(
    title: 'Choking & Heimlich Maneuver',
    department: 'Medical & Health Services',
    location: 'GH Chennai, Park Town',
    authorisedPerson: 'Emergency Dr. P. Ramesh',
    objective:
        'Identify choking and perform Heimlich maneuver on adult and infant manikins.',
    steps: [
      'Ask "Are you choking?" — if no response, act',
      'For adult: give 5 back blows between shoulder blades',
      'Follow with 5 abdominal thrusts',
      'Repeat until object expelled or person collapses',
      'For infant: face-down 5 back blows + 5 chest thrusts',
      'After object removed, check airway before leaving',
    ],
    durationMin: 40,
  ),
  DrillScenario(
    title: 'AED Usage in Cardiac Arrest',
    department: 'Medical & Health Services',
    location: 'MIOT International, Manapakkam',
    authorisedPerson: 'Cardiologist Dr. N. Anand',
    objective:
        'Operate an AED on an unconscious cardiac arrest victim within 3 minutes of collapse.',
    steps: [
      'Confirm unconsciousness and no breathing',
      'Start CPR while assistant retrieves AED',
      'Turn on AED — follow voice prompts',
      'Attach pads: upper right chest + lower left rib',
      'Clear patient — press analyse',
      'Deliver shock if advised, resume CPR immediately',
    ],
    durationMin: 60,
  ),
  DrillScenario(
    title: 'Fracture Splinting & Immobilisation',
    department: 'Medical & Health Services',
    location: 'Govt Orthopaedic Hospital, Kilpauk',
    authorisedPerson: 'Orthopaedic Surgeon Dr. T. Vijay',
    objective:
        'Immobilise a suspected lower leg fracture using improvised and SAM splints.',
    steps: [
      'Do not try to realign bone',
      'Control any bleeding with gentle pressure',
      'Pad all bony prominences before splinting',
      'Position SAM splint along bone length',
      'Secure with triangular bandage ties above and below fracture',
      'Check CMS: Circulation, Movement, Sensation after splinting',
    ],
    durationMin: 50,
  ),
];

// ─────────────────────────────────────────────
// COMBINED DRILL DATA
// ─────────────────────────────────────────────

const List<DrillScenario> combinedDrills = [
  DrillScenario(
    title: 'Multi-Storey Building Collapse — Integrated Response',
    department: 'Fire + NDRF + Medical + Police',
    location: 'Mock Site, Porur Industrial Area',
    authorisedPerson: 'Incident Commander Col. (Retd) S. Murugesh',
    objective:
        'All departments respond, rescue trapped victims, treat casualties, and restore order within 60 minutes.',
    steps: [
      'Police: secure perimeter and manage crowd',
      'Fire: control gas leak and structural fire',
      'NDRF: locate and extricate trapped persons',
      'Medical: set up triage post at safe distance',
      'All: use common radio channel for coordination',
      'Incident commander logs timeline and resource use',
    ],
    durationMin: 120,
  ),
  DrillScenario(
    title: 'Cyclone Landfall Evacuation Drill',
    department: 'SDRF + Police + Revenue + Medical',
    location: 'Marina Beach Coastal Zone, Chennai',
    authorisedPerson: 'District Collector Representative',
    objective:
        'Evacuate coastal village of 200 simulated residents to cyclone shelter in 90 minutes.',
    steps: [
      'Revenue: identify high-risk households on map',
      'Police: lead road convoy of buses',
      'SDRF: handle reluctant/mobility-impaired residents',
      'Medical: station ambulance at each shelter',
      'All departments check-in at shelter with count',
      'Conduct post-drill debrief and identify gaps',
    ],
    durationMin: 90,
  ),
  DrillScenario(
    title: 'Industrial Chemical Explosion Response',
    department: 'Fire HazMat + NDRF + Medical + Police',
    location: 'Manali Industrial Corridor',
    authorisedPerson: 'Fire Officer HazMat Division, TNFRS',
    objective:
        'Simultaneously manage fire, chemical hazard, mass casualties and public panic.',
    steps: [
      'Police: block access roads and establish 500m exclusion zone',
      'Fire: extinguish secondary fires, prevent spread to adjacent tanks',
      'HazMat team: identify chemical, neutralise spill',
      'NDRF: search building for trapped workers',
      'Medical: set up decon shower + 3-zone triage',
      'Media liaison officer: release verified info every 30 minutes',
    ],
    durationMin: 150,
  ),
  DrillScenario(
    title: 'Flood Relief — Search, Rescue & Medical Aid',
    department: 'NDRF + SDRF + Medical + Volunteers',
    location: 'Flood-Simulated Zone, Adyar River Bank',
    authorisedPerson: 'NDRF Team Commander Lt. R. Krishnan',
    objective:
        'Locate, rescue, and medically stabilise 10 flood victims across 5 locations within 2 hours.',
    steps: [
      'Aerial mapping team identifies isolated clusters',
      'Boat teams deploy in pairs to each cluster',
      'Volunteers receive victims at shore landing point',
      'Medical team: triage, treat, refer critical cases',
      'Relief team: provide food, water, warm clothing',
      'Document all rescued persons with ID details',
    ],
    durationMin: 120,
  ),
  DrillScenario(
    title: 'Earthquake Aftermath — Full City Simulation',
    department: 'All Emergency Services + Army',
    location: 'NDMA Training Campus, Delhi (Simulation)',
    authorisedPerson: 'National Crisis Management Trainer',
    objective:
        'Simulate 72-hour response to a magnitude 7.0 earthquake with 500 simulated casualties.',
    steps: [
      'Hour 0-6: Search & rescue from collapsed structures',
      'Hour 6-24: Set up 3 field hospitals with 50-bed capacity each',
      'Hour 24-48: Restore water/power to critical facilities',
      'Hour 48-72: Manage displaced population in camps',
      'Continuous: inter-agency communication via EOC',
      'Final: after action review with all department heads',
    ],
    durationMin: 180,
  ),
  DrillScenario(
    title: 'Mass Casualty Incident — Stadium Event',
    department: 'Police + Medical + Fire + SDRF',
    location: 'CMBT Stadium, Arumbakkam',
    authorisedPerson: 'Event Safety Director + DCP Operations',
    objective:
        'Manage crowd stampede with 100 simulated casualties including cardiac arrests.',
    steps: [
      'Police: activate crowd control — close entry gates, open exits',
      'Fire: ensure all emergency exits are unobstructed',
      'Medical teams pre-positioned at 4 corners of ground',
      'SDRF volunteers guide crowd to safe zones in calm voice',
      'Triage post inside stadium — no external transfer until stable',
      'Helicopter landing zone marked on pitch for critical cases',
    ],
    durationMin: 90,
  ),
  DrillScenario(
    title: 'Tsunami Early Warning Response Drill',
    department: 'Coast Guard + NDRF + Police + Medical',
    location: 'East Coast Road, Mahabalipuram',
    authorisedPerson: 'District Emergency Operations Centre',
    objective:
        'Evacuate entire coastal belt 5km inland within 20 minutes of warning siren.',
    steps: [
      'INCOIS issues tsunami alert — siren activation',
      'Police: activate vehicle-mounted PA system',
      'Coast Guard: recall all fishing boats by radio',
      'NDRF: deploy to known vulnerable pockets',
      'All roads converted to one-way outbound flow',
      'Inland checkpoints account for incoming evacuees',
      'Medical: mobile units follow evacuation convoy',
    ],
    durationMin: 60,
  ),
];

// ─────────────────────────────────────────────
// TRAINING BLOCKS DATA (Bottom to Top = Basic → Army)
// ─────────────────────────────────────────────

final List<TrainingBlock> trainingBlocks = [
  // ARMY (TOP) - locked unless ALL missions completed + rescue participation
  TrainingBlock(
    id: 'army',
    title: 'ARMY CORPS',
    subtitle: 'Elite Volunteer Force',
    description:
        'Reserved for heroes who complete all levels AND have participated in a real rescue operation. Work directly with defence personnel on joint disaster response.',
    icon: Icons.military_tech_rounded,
    color: const Color(0xFF1A1A2E),
    lightColor: const Color(0xFF2D2D4A),
    xpReward: 5000,
    level: 9,
    status: BlockStatus.locked,
    progress: 0.0,
    isArmy: true,
    tier: BlockTier.army,
    blockType: 'army',
    missions: [],
  ),

  // GOLD TIER
  TrainingBlock(
    id: 'combined_drills',
    title: 'COMBINED DRILLS',
    subtitle: 'Gold Level · All Departments',
    description:
        'AI-generated multi-agency crisis drills. All departments — fire, rescue, medical — work as one to manage large-scale disasters.',
    icon: Icons.hub_rounded,
    color: const Color(0xFFC79000),
    lightColor: const Color(0xFFFFFDE7),
    xpReward: 2000,
    level: 8,
    status: BlockStatus.locked,
    progress: 0.0,
    tier: BlockTier.gold,
    blockType: 'combined',
  ),

  // SILVER TIER
  TrainingBlock(
    id: 'drill',
    title: 'DEPARTMENT DRILLS',
    subtitle: 'Silver Level · On-Ground Practice',
    description:
        'Choose a department — Fire, Medical, or Rescue — then train at real govt facilities with authorised personnel using AI-generated drill scenarios.',
    icon: Icons.directions_run_rounded,
    color: const Color(0xFF607D8B),
    lightColor: const Color(0xFFECEFF1),
    xpReward: 1200,
    level: 7,
    status: BlockStatus.locked,
    progress: 0.0,
    tier: BlockTier.silver,
    blockType: 'drill',
  ),
  TrainingBlock(
    id: 'rescue',
    title: 'RESCUE TEAM',
    subtitle: 'Silver Level · Disaster Rescue',
    description:
        'Partner with NDRF and SDRF for hands-on flood, collapse, and night rescue missions. Missions cleared by authorised rescue personnel.',
    icon: Icons.flood_rounded,
    color: const Color(0xFF2E6B4F),
    lightColor: const Color(0xFFE8F5E9),
    xpReward: 1000,
    level: 6,
    status: BlockStatus.locked,
    progress: 0.0,
    tier: BlockTier.silver,
    blockType: 'rescue',
    missions: [
      TrainingMission(
        title: 'Flood Water Rescue with Boat',
        type: 'practical',
        xp: 200,
        durationMin: 60,
      ),
      TrainingMission(
        title: 'Rope Rescue from Height',
        type: 'practical',
        xp: 220,
        durationMin: 90,
      ),
      TrainingMission(
        title: 'Collapsed Structure Victim Search',
        type: 'practical',
        xp: 250,
        durationMin: 120,
      ),
      TrainingMission(
        title: 'Swiftwater Swimmer Rescue',
        type: 'practical',
        xp: 200,
        durationMin: 75,
      ),
      TrainingMission(
        title: 'Mass Casualty Triage Setup',
        type: 'practical',
        xp: 180,
        durationMin: 90,
      ),
      TrainingMission(
        title: 'Night Search Operation',
        type: 'practical',
        xp: 160,
        durationMin: 80,
      ),
      TrainingMission(
        title: 'Chemical Spill Rescue Protocol',
        type: 'practical',
        xp: 230,
        durationMin: 100,
      ),
      TrainingMission(
        title: 'Completion Certificate from NDRF/SDRF',
        type: 'certificate',
        xp: 500,
        durationMin: 0,
      ),
    ],
  ),
  TrainingBlock(
    id: 'fire',
    title: 'FIRE DEPARTMENT',
    subtitle: 'Silver Level · Fire Safety',
    description:
        'Live drills at your local fire station. Extinguisher handling, hose operation, evacuation leading, and more — certified by authorised fire officer.',
    icon: Icons.local_fire_department_rounded,
    color: const Color(0xFFB84A00),
    lightColor: const Color(0xFFFFF3E0),
    xpReward: 800,
    level: 5,
    status: BlockStatus.locked,
    progress: 0.0,
    tier: BlockTier.silver,
    blockType: 'fire',
    missions: [
      TrainingMission(
        title: 'Kitchen Fire Containment',
        type: 'practical',
        xp: 150,
        durationMin: 30,
      ),
      TrainingMission(
        title: 'High-Rise Evacuation Lead',
        type: 'practical',
        xp: 180,
        durationMin: 40,
      ),
      TrainingMission(
        title: 'Hose Operation at Live Site',
        type: 'practical',
        xp: 160,
        durationMin: 45,
      ),
      TrainingMission(
        title: 'Search & Rescue in Smoke-Filled Corridor',
        type: 'practical',
        xp: 200,
        durationMin: 50,
      ),
      TrainingMission(
        title: 'Electrical Fire Safety Protocol',
        type: 'practical',
        xp: 140,
        durationMin: 35,
      ),
      TrainingMission(
        title: 'Casualty Extraction from Burning Vehicle',
        type: 'practical',
        xp: 220,
        durationMin: 60,
      ),
      TrainingMission(
        title: 'Mass Evacuation Coordination Drill',
        type: 'practical',
        xp: 200,
        durationMin: 70,
      ),
      TrainingMission(
        title: 'Completion Certificate from Fire Station',
        type: 'certificate',
        xp: 400,
        durationMin: 0,
      ),
    ],
  ),

  // BRONZE TIER
  TrainingBlock(
    id: 'medical',
    title: 'MEDICAL TRAINING',
    subtitle: 'Bronze Level · Life-Saving Skills',
    description:
        'Complete hands-on medical missions at nearby hospitals and health centres. Missions include CPR, first aid, wound care. Certificate issued by authorised doctor or incharge.',
    icon: Icons.favorite_rounded,
    color: const Color(0xFFD94035),
    lightColor: const Color(0xFFFFEBEB),
    xpReward: 600,
    level: 4,
    status: BlockStatus.inProgress,
    progress: 0.5,
    tier: BlockTier.bronze,
    blockType: 'medical',
    missions: [
      TrainingMission(
        title: 'Adult CPR Certification',
        type: 'practical',
        xp: 200,
        durationMin: 90,
        completed: true,
        score: '88/100',
      ),
      TrainingMission(
        title: 'Wound Care & Bandaging',
        type: 'practical',
        xp: 120,
        durationMin: 45,
        completed: true,
        score: '95/100',
      ),
      TrainingMission(
        title: 'Choking & Heimlich Maneuver',
        type: 'practical',
        xp: 100,
        durationMin: 40,
      ),
      TrainingMission(
        title: 'AED Usage in Cardiac Arrest',
        type: 'practical',
        xp: 150,
        durationMin: 60,
      ),
      TrainingMission(
        title: 'Fracture Splinting & Immobilisation',
        type: 'practical',
        xp: 120,
        durationMin: 50,
      ),
      TrainingMission(
        title: 'Completion Certificate from Doctor',
        type: 'certificate',
        xp: 300,
        durationMin: 0,
      ),
    ],
  ),
  TrainingBlock(
    id: 'puzzle',
    title: 'PUZZLE SOLVING',
    subtitle: 'Bronze Level · Crisis Decision Making',
    description:
        'Test your survival and emergency knowledge with 10 scenario-based puzzles. Each puzzle covers a different crisis situation.',
    icon: Icons.extension_rounded,
    color: const Color(0xFF6A3FA0),
    lightColor: const Color(0xFFF3E5F5),
    xpReward: 400,
    level: 3,
    status: BlockStatus.completed,
    progress: 1.0,
    tier: BlockTier.bronze,
    blockType: 'puzzle',
    missions: [
      TrainingMission(
        title: 'Flood Escape Route',
        type: 'puzzle',
        xp: 40,
        durationMin: 5,
        completed: true,
        score: '100/100',
      ),
      TrainingMission(
        title: 'Fire Response Decision',
        type: 'puzzle',
        xp: 40,
        durationMin: 5,
        completed: true,
        score: '90/100',
      ),
      TrainingMission(
        title: 'Earthquake Safety Protocol',
        type: 'puzzle',
        xp: 40,
        durationMin: 5,
        completed: true,
        score: '100/100',
      ),
      TrainingMission(
        title: 'Water Safety Crisis',
        type: 'puzzle',
        xp: 40,
        durationMin: 5,
        completed: true,
        score: '80/100',
      ),
      TrainingMission(
        title: 'Triage Colour Code Test',
        type: 'puzzle',
        xp: 40,
        durationMin: 5,
        completed: true,
        score: '100/100',
      ),
      TrainingMission(
        title: 'Building Evacuation Logic',
        type: 'puzzle',
        xp: 40,
        durationMin: 5,
        completed: true,
        score: '90/100',
      ),
      TrainingMission(
        title: 'Distress Signal Recognition',
        type: 'puzzle',
        xp: 40,
        durationMin: 5,
        completed: true,
        score: '100/100',
      ),
      TrainingMission(
        title: 'Bleeding Control Protocol',
        type: 'puzzle',
        xp: 40,
        durationMin: 5,
        completed: true,
        score: '85/100',
      ),
      TrainingMission(
        title: 'Gas Leak Emergency',
        type: 'puzzle',
        xp: 40,
        durationMin: 5,
        completed: true,
        score: '100/100',
      ),
      TrainingMission(
        title: 'Basic Life Support Order',
        type: 'puzzle',
        xp: 40,
        durationMin: 5,
        completed: true,
        score: '95/100',
      ),
    ],
  ),
  TrainingBlock(
    id: 'survival',
    title: 'SURVIVAL',
    subtitle: 'Bronze Level · Crisis Survival Skills',
    description:
        'Safety rules, crisis handling guides, and animated short videos. Learn what to do when disaster strikes — practical, visual, and to the point.',
    icon: Icons.eco_rounded,
    color: const Color(0xFF3D7A3A),
    lightColor: const Color(0xFFE8F5E9),
    xpReward: 200,
    level: 2,
    status: BlockStatus.completed,
    progress: 1.0,
    tier: BlockTier.bronze,
    blockType: 'survival',
    missions: [
      TrainingMission(
        title: 'Water Safety & Purification',
        type: 'video',
        xp: 30,
        durationMin: 5,
        completed: true,
        score: '100/100',
      ),
      TrainingMission(
        title: 'Basic Shelter Principles',
        type: 'video',
        xp: 25,
        durationMin: 5,
        completed: true,
        score: '96/100',
      ),
      TrainingMission(
        title: 'Crisis Do\'s & Don\'ts',
        type: 'video',
        xp: 30,
        durationMin: 6,
        completed: true,
        score: '92/100',
      ),
      TrainingMission(
        title: 'Emergency Kit Checklist',
        type: 'quiz',
        xp: 20,
        durationMin: 4,
        completed: true,
        score: '100/100',
      ),
      TrainingMission(
        title: 'Survival Signaling Methods',
        type: 'video',
        xp: 30,
        durationMin: 6,
        completed: true,
        score: '88/100',
      ),
    ],
  ),
  TrainingBlock(
    id: 'basic',
    title: 'BASIC KNOWLEDGE',
    subtitle: 'Bronze Level · Emergency Awareness',
    description:
        'Foundation video lectures and animated clips on disaster types, safety measures, emergency signals, and community protocols. Start your hero journey here.',
    icon: Icons.menu_book_rounded,
    color: const Color(0xFF2A7ABD),
    lightColor: const Color(0xFFE3F2FD),
    xpReward: 150,
    level: 1,
    status: BlockStatus.completed,
    progress: 1.0,
    tier: BlockTier.bronze,
    blockType: 'basic',
    missions: [
      TrainingMission(
        title: 'Disaster Types & Classification',
        type: 'video',
        xp: 30,
        durationMin: 7,
        completed: true,
        score: '95/100',
      ),
      TrainingMission(
        title: 'Community Safety Protocols',
        type: 'video',
        xp: 25,
        durationMin: 6,
        completed: true,
        score: '90/100',
      ),
      TrainingMission(
        title: 'Emergency Signal Recognition',
        type: 'video',
        xp: 30,
        durationMin: 8,
        completed: true,
        score: '88/100',
      ),
      TrainingMission(
        title: 'Crisis Safety Measures',
        type: 'video',
        xp: 25,
        durationMin: 6,
        completed: true,
        score: '92/100',
      ),
      TrainingMission(
        title: 'Your Role as a Volunteer',
        type: 'video',
        xp: 20,
        durationMin: 5,
        completed: true,
        score: '100/100',
      ),
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
                  const _TierLegend(),
                  const SizedBox(height: 16),
                  ...trainingBlocks.map(
                    (block) => _TrainingBlockCard(block: block),
                  ),
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
              const Text(
                'Training Path',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A1A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD94035),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Hero Level 3 · Ravi Kumar',
                    style: TextStyle(fontSize: 13, color: Color(0xFF888880)),
                  ),
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
                Text(
                  '680 XP',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _StatChip(
              label: 'Completed',
              value: '3',
              color: const Color(0xFF3D7A3A),
            ),
            _Divider(),
            _StatChip(
              label: 'In Progress',
              value: '1',
              color: const Color(0xFFD94035),
            ),
            _Divider(),
            _StatChip(
              label: 'Locked',
              value: '4',
              color: const Color(0xFF888880),
            ),
            _Divider(),
            _StatChip(
              label: 'Total XP',
              value: '10.2K',
              color: const Color(0xFF0D5B8E),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF888880),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 28, color: const Color(0xFFE8E4DF));
}

class _TierLegend extends StatelessWidget {
  const _TierLegend();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _LegendChip(
            color: const Color(0xFFC79000),
            label: 'Gold',
            icon: Icons.star_rounded,
          ),
          const SizedBox(width: 10),
          _LegendChip(
            color: const Color(0xFF607D8B),
            label: 'Silver',
            icon: Icons.shield_rounded,
          ),
          const SizedBox(width: 10),
          _LegendChip(
            color: const Color(0xFFB87333),
            label: 'Bronze',
            icon: Icons.military_tech_rounded,
          ),
          const Spacer(),
          const Text(
            '↑ Army at Top',
            style: TextStyle(fontSize: 10, color: Color(0xFFAAAAAA)),
          ),
        ],
      ),
    );
  }
}

class _LegendChip extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;
  const _LegendChip({
    required this.color,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
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

  Color get _tierAccent {
    switch (block.tier) {
      case BlockTier.gold:
        return const Color(0xFFC79000);
      case BlockTier.silver:
        return const Color(0xFF8A9BAB);
      case BlockTier.bronze:
        return const Color(0xFFB87333);
      case BlockTier.army:
        return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLocked = block.status == BlockStatus.locked;
    final bool isCompleted = block.status == BlockStatus.completed;
    final bool isInProgress = block.status == BlockStatus.inProgress;

    return GestureDetector(
      onTap: isLocked ? null : () => _openDetail(context),
      child: Column(
        children: [
          if (block.id != 'army')
            _ConnectorLine(
              isUnlocked: !isLocked,
              color: isCompleted ? block.color : const Color(0xFFD0CCC6),
            ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: isLocked ? const Color(0xFFEAE6E0) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isInProgress
                    ? block.color.withOpacity(0.5)
                    : (isCompleted
                          ? block.color.withOpacity(0.3)
                          : const Color(0xFFDDD9D3)),
                width: isInProgress ? 2 : 1,
              ),
              boxShadow: isLocked
                  ? []
                  : [
                      BoxShadow(
                        color: block.color.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: block.isArmy
                ? _ArmyBlock(block: block)
                : _StandardBlock(
                    block: block,
                    isLocked: isLocked,
                    isCompleted: isCompleted,
                    isInProgress: isInProgress,
                    tierAccent: _tierAccent,
                  ),
          ),
        ],
      ),
    );
  }

  void _openDetail(BuildContext context) {
    Widget screen;
    switch (block.blockType) {
      case 'basic':
        screen = BasicDetailScreen(block: block);
        break;
      case 'survival':
        screen = SurvivalDetailScreen(block: block);
        break;
      case 'puzzle':
        screen = PuzzleDetailScreen(block: block);
        break;
      case 'medical':
        screen = MedicalDetailScreen(block: block);
        break;
      case 'fire':
        screen = FireDetailScreen(block: block);
        break;
      case 'rescue':
        screen = RescueDetailScreen(block: block);
        break;
      case 'drill':
        screen = DrillDetailScreen(block: block);
        break;
      case 'combined':
        screen = CombinedDrillDetailScreen(block: block);
        break;
      default:
        screen = TrainingDetailScreen(block: block);
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
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
              const Icon(
                Icons.lock_outline_rounded,
                size: 14,
                color: Color(0xFFB0ACA6),
              ),
          ],
        ),
      ],
    );
  }
}

class _StandardBlock extends StatelessWidget {
  final TrainingBlock block;
  final bool isLocked, isCompleted, isInProgress;
  final Color tierAccent;
  const _StandardBlock({
    required this.block,
    required this.isLocked,
    required this.isCompleted,
    required this.isInProgress,
    required this.tierAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tier badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isLocked
                      ? const Color(0xFFE0DDD8)
                      : tierAccent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  block.tier.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: isLocked ? const Color(0xFFB0ACA6) : tierAccent,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const Spacer(),
              _StatusBadge(
                isLocked: isLocked,
                isCompleted: isCompleted,
                isInProgress: isInProgress,
                color: block.color,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      block.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: isLocked
                            ? const Color(0xFFB0ACA6)
                            : const Color(0xFF1A1A1A),
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      block.subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isLocked
                            ? const Color(0xFFCCC8C3)
                            : const Color(0xFF888880),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLocked)
                Icon(
                  Icons.chevron_right_rounded,
                  color: block.color.withOpacity(0.6),
                  size: 20,
                ),
            ],
          ),
          const SizedBox(height: 10),
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
                Text(
                  '${(block.progress * 100).toInt()}% complete',
                  style: TextStyle(
                    fontSize: 10,
                    color: block.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: block.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '+${block.xpReward} XP',
                    style: TextStyle(
                      fontSize: 10,
                      color: block.color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isLocked, isCompleted, isInProgress;
  final Color color;
  const _StatusBadge({
    required this.isLocked,
    required this.isCompleted,
    required this.isInProgress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isLocked) return const SizedBox.shrink();
    if (isCompleted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 11,
              color: Color(0xFF3D7A3A),
            ),
            SizedBox(width: 3),
            Text(
              'Done',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3D7A3A),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(
            'Active',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
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
                  border: Border.all(color: Colors.amber.withOpacity(0.4)),
                ),
                child: const Icon(
                  Icons.military_tech_rounded,
                  color: Colors.amber,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'ARMY CORPS',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.amber.withOpacity(0.4),
                            ),
                          ),
                          child: const Text(
                            'ELITE',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.amber,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Elite Volunteer Force',
                      style: TextStyle(fontSize: 12, color: Colors.white60),
                    ),
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
            child: const Row(
              children: [
                Icon(Icons.lock_rounded, color: Colors.amber, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Complete ALL levels below AND participate in a real rescue operation. Only the most dedicated heroes are eligible.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _ArmyStatChip(
                label: 'XP Reward',
                value: '+5000 XP',
                icon: Icons.bolt_rounded,
                color: Colors.amber,
              ),
              const SizedBox(width: 10),
              _ArmyStatChip(
                label: 'Requirement',
                value: 'All Levels',
                icon: Icons.flag_rounded,
                color: const Color(0xFF7EB8E0),
              ),
              const SizedBox(width: 10),
              _ArmyStatChip(
                label: 'Status',
                value: 'Coming Soon',
                icon: Icons.access_time_rounded,
                color: Colors.white54,
              ),
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
  const _ArmyStatChip({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 14),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 8, color: Colors.white38),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SHARED DETAIL SCREEN BASE
// ─────────────────────────────────────────────

class _BaseDetailScreen extends StatelessWidget {
  final TrainingBlock block;
  final List<Widget> children;
  const _BaseDetailScreen({required this.block, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EDE8),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: block.color,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                block.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [block.color, block.color.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Icon(block.icon, color: Colors.white, size: 34),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        block.subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            sliver: SliverList(delegate: SliverChildListDelegate(children)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BASIC DETAIL SCREEN
// ─────────────────────────────────────────────

class BasicDetailScreen extends StatelessWidget {
  final TrainingBlock block;
  const BasicDetailScreen({super.key, required this.block});

  static const List<Map<String, dynamic>> videos = [
    {
      'title': 'Types of Disasters Explained',
      'duration': '4:30',
      'tag': 'Overview',
      'icon': Icons.tsunami_rounded,
    },
    {
      'title': 'Flood Warning Signs & Safety',
      'duration': '3:15',
      'tag': 'Flood',
      'icon': Icons.water_rounded,
    },
    {
      'title': 'Earthquake — Before, During & After',
      'duration': '5:00',
      'tag': 'Earthquake',
      'icon': Icons.vibration_rounded,
    },
    {
      'title': 'Fire Safety at Home & Work',
      'duration': '3:45',
      'tag': 'Fire',
      'icon': Icons.local_fire_department_rounded,
    },
    {
      'title': 'Cyclone Preparedness Guide',
      'duration': '4:10',
      'tag': 'Cyclone',
      'icon': Icons.air_rounded,
    },
    {
      'title': 'Community Alert Systems',
      'duration': '2:50',
      'tag': 'Alerts',
      'icon': Icons.campaign_rounded,
    },
    {
      'title': 'Emergency Signal Recognition',
      'duration': '3:20',
      'tag': 'Signals',
      'icon': Icons.sos_rounded,
    },
    {
      'title': 'Your Role as a Volunteer',
      'duration': '4:00',
      'tag': 'Volunteer',
      'icon': Icons.volunteer_activism_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return _BaseDetailScreen(
      block: block,
      children: [
        _SectionHeader(
          icon: Icons.play_circle_filled_rounded,
          label: 'Video Lectures & Animated Clips',
          color: block.color,
        ),
        const SizedBox(height: 12),
        const Text(
          'Short, focused video lessons covering crisis basics. Watch in order to unlock the next level.',
          style: TextStyle(fontSize: 13, color: Color(0xFF666660), height: 1.5),
        ),
        const SizedBox(height: 16),
        ...videos.asMap().entries.map(
          (e) => _VideoCard(
            video: e.value,
            index: e.key,
            color: block.color,
            completed: e.key < 5,
          ),
        ),
        const SizedBox(height: 20),
        _MissionsSection(block: block),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// SURVIVAL DETAIL SCREEN
// ─────────────────────────────────────────────

class SurvivalDetailScreen extends StatelessWidget {
  final TrainingBlock block;
  const SurvivalDetailScreen({super.key, required this.block});

  static const List<Map<String, dynamic>> safetyRules = [
    {
      'rule': 'Stay calm — panic kills faster than the disaster',
      'icon': Icons.self_improvement_rounded,
    },
    {
      'rule': 'Move to higher ground immediately during floods',
      'icon': Icons.trending_up_rounded,
    },
    {
      'rule': 'Drop, Cover, Hold during earthquakes',
      'icon': Icons.shield_rounded,
    },
    {
      'rule': 'Never re-enter a building after fire or quake',
      'icon': Icons.block_rounded,
    },
    {
      'rule': 'Keep your emergency kit within 60 seconds reach',
      'icon': Icons.backpack_rounded,
    },
    {
      'rule': 'Conserve phone battery for emergency calls only',
      'icon': Icons.battery_saver_rounded,
    },
    {
      'rule': 'Know your local evacuation routes by heart',
      'icon': Icons.map_rounded,
    },
    {
      'rule': 'Help children and elderly before assisting others',
      'icon': Icons.elderly_rounded,
    },
  ];

  static const List<Map<String, dynamic>> videos = [
    {
      'title': 'Water Purification in a Crisis',
      'duration': '2:45',
      'tag': 'Water',
      'icon': Icons.water_drop_rounded,
    },
    {
      'title': 'Building a Basic Shelter',
      'duration': '3:30',
      'tag': 'Shelter',
      'icon': Icons.home_rounded,
    },
    {
      'title': 'Sending Distress Signals',
      'duration': '2:00',
      'tag': 'Signal',
      'icon': Icons.sos_rounded,
    },
    {
      'title': 'What to Pack in Your Emergency Kit',
      'duration': '3:10',
      'tag': 'Kit',
      'icon': Icons.backpack_rounded,
    },
    {
      'title': 'Food Safety After a Disaster',
      'duration': '2:20',
      'tag': 'Food',
      'icon': Icons.restaurant_rounded,
    },
    {
      'title': 'How to Handle Stress in Crisis',
      'duration': '2:50',
      'tag': 'Mental',
      'icon': Icons.psychology_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return _BaseDetailScreen(
      block: block,
      children: [
        _SectionHeader(
          icon: Icons.rule_rounded,
          label: 'Safety Rules to Remember',
          color: block.color,
        ),
        const SizedBox(height: 12),
        ...safetyRules.map((r) => _SafetyRuleCard(rule: r, color: block.color)),
        const SizedBox(height: 20),
        _SectionHeader(
          icon: Icons.play_circle_filled_rounded,
          label: 'Animated Short Videos',
          color: block.color,
        ),
        const SizedBox(height: 12),
        const Text(
          'Quick 2-3 minute animated clips. Visual, practical, and easy to remember.',
          style: TextStyle(fontSize: 13, color: Color(0xFF666660), height: 1.5),
        ),
        const SizedBox(height: 12),
        ...videos.asMap().entries.map(
          (e) => _VideoCard(
            video: e.value,
            index: e.key,
            color: block.color,
            completed: e.key < 5,
          ),
        ),
        const SizedBox(height: 20),
        _MissionsSection(block: block),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// PUZZLE DETAIL SCREEN
// ─────────────────────────────────────────────

class PuzzleDetailScreen extends StatefulWidget {
  final TrainingBlock block;
  const PuzzleDetailScreen({super.key, required this.block});

  @override
  State<PuzzleDetailScreen> createState() => _PuzzleDetailScreenState();
}

class _PuzzleDetailScreenState extends State<PuzzleDetailScreen> {
  final List<int?> _scores = List.filled(
    10,
    null,
  ); // null = not attempted, -1 = failed, 0-100 = score

  @override
  Widget build(BuildContext context) {
    return _BaseDetailScreen(
      block: widget.block,
      children: [
        _SectionHeader(
          icon: Icons.extension_rounded,
          label: '10 Crisis Scenario Puzzles',
          color: widget.block.color,
        ),
        const SizedBox(height: 8),
        const Text(
          'Each puzzle is a unique crisis situation. Think carefully — one correct answer. Reattempt anytime to improve your score.',
          style: TextStyle(fontSize: 13, color: Color(0xFF666660), height: 1.5),
        ),
        const SizedBox(height: 16),
        ...survivalPuzzles.asMap().entries.map(
          (e) => _PuzzleCard(
            puzzle: e.value,
            index: e.key,
            color: widget.block.color,
            score: _scores[e.key],
            onScoreUpdated: (score) => setState(() => _scores[e.key] = score),
          ),
        ),
      ],
    );
  }
}

class _PuzzleCard extends StatelessWidget {
  final PuzzleQuestion puzzle;
  final int index;
  final Color color;
  final int? score;
  final ValueChanged<int> onScoreUpdated;
  const _PuzzleCard({
    required this.puzzle,
    required this.index,
    required this.color,
    required this.score,
    required this.onScoreUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final bool attempted = score != null;
    final bool passed = (score ?? 0) >= 70;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: attempted
              ? (passed ? const Color(0xFF3D7A3A) : const Color(0xFFD94035))
                    .withOpacity(0.3)
              : const Color(0xFFE8E4DF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Puzzle ${index + 1}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF888880),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (attempted)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color:
                          (passed
                                  ? const Color(0xFF3D7A3A)
                                  : const Color(0xFFD94035))
                              .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$score/100',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: passed
                            ? const Color(0xFF3D7A3A)
                            : const Color(0xFFD94035),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              puzzle.question,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _PuzzleButton(
                    label: 'Start',
                    icon: Icons.play_arrow_rounded,
                    color: color,
                    onTap: () => _startPuzzle(context),
                  ),
                ),
                const SizedBox(width: 10),
                if (attempted)
                  Expanded(
                    child: _PuzzleButton(
                      label: 'Reattempt',
                      icon: Icons.refresh_rounded,
                      color: const Color(0xFF6A3FA0),
                      onTap: () => _startPuzzle(context),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startPuzzle(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PuzzleQuizScreen(
          puzzle: puzzle,
          index: index,
          color: color,
          onComplete: (s) {
            onScoreUpdated(s);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class _PuzzleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _PuzzleButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PUZZLE QUIZ SCREEN
// ─────────────────────────────────────────────

class PuzzleQuizScreen extends StatefulWidget {
  final PuzzleQuestion puzzle;
  final int index;
  final Color color;
  final ValueChanged<int> onComplete;
  const PuzzleQuizScreen({
    super.key,
    required this.puzzle,
    required this.index,
    required this.color,
    required this.onComplete,
  });

  @override
  State<PuzzleQuizScreen> createState() => _PuzzleQuizScreenState();
}

class _PuzzleQuizScreenState extends State<PuzzleQuizScreen> {
  int? _selected;
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EDE8),
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(
          'Puzzle ${widget.index + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                widget.puzzle.question,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...widget.puzzle.options.asMap().entries.map(
              (e) => _AnswerOption(
                label: e.value,
                index: e.key,
                selected: _selected == e.key,
                submitted: _submitted,
                isCorrect: e.key == widget.puzzle.correctIndex,
                onTap: _submitted
                    ? null
                    : () => setState(() => _selected = e.key),
              ),
            ),
            const Spacer(),
            if (_submitted) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color:
                      (_selected == widget.puzzle.correctIndex
                              ? const Color(0xFF3D7A3A)
                              : const Color(0xFFD94035))
                          .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selected == widget.puzzle.correctIndex
                          ? '✓ Correct!'
                          : '✗ Incorrect',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: _selected == widget.puzzle.correctIndex
                            ? const Color(0xFF3D7A3A)
                            : const Color(0xFFD94035),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.puzzle.explanation,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF444440),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => widget.onComplete(
                    _selected == widget.puzzle.correctIndex ? 100 : 40,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.color,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Back to Puzzles',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ] else ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selected == null
                      ? null
                      : () => setState(() => _submitted = true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.color,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit Answer',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  final String label;
  final int index;
  final bool selected, submitted, isCorrect;
  final VoidCallback? onTap;
  const _AnswerOption({
    required this.label,
    required this.index,
    required this.selected,
    required this.submitted,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.white;
    Color border = const Color(0xFFE8E4DF);
    Color text = const Color(0xFF1A1A1A);
    if (submitted && isCorrect) {
      bg = const Color(0xFFE8F5E9);
      border = const Color(0xFF3D7A3A);
      text = const Color(0xFF3D7A3A);
    } else if (submitted && selected && !isCorrect) {
      bg = const Color(0xFFFFEBEB);
      border = const Color(0xFFD94035);
      text = const Color(0xFFD94035);
    } else if (selected) {
      bg = const Color(0xFFE3F2FD);
      border = const Color(0xFF2A7ABD);
      text = const Color(0xFF2A7ABD);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: border.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  ['A', 'B', 'C', 'D'][index],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: border,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: text,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MEDICAL DETAIL SCREEN
// ─────────────────────────────────────────────

class MedicalDetailScreen extends StatelessWidget {
  final TrainingBlock block;
  const MedicalDetailScreen({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    return _BaseDetailScreen(
      block: block,
      children: [
        _SectionHeader(
          icon: Icons.info_rounded,
          label: 'How This Works',
          color: block.color,
        ),
        const SizedBox(height: 8),
        _InfoBox(
          color: block.color,
          text:
              'All medical missions must be completed at a nearby hospital or health centre. An authorised doctor or incharge will issue your Completion Certificate once all missions are done.',
        ),
        const SizedBox(height: 20),
        _SectionHeader(
          icon: Icons.local_hospital_rounded,
          label: 'Nearby Medical Centres',
          color: block.color,
        ),
        const SizedBox(height: 12),
        ...[
          {
            'name': 'Apollo Hospital',
            'area': 'Greams Road',
            'type': 'Multi-specialty',
          },
          {
            'name': 'GH Chennai',
            'area': 'Park Town',
            'type': 'Government Hospital',
          },
          {
            'name': 'Primary Health Centre',
            'area': 'Villivakkam',
            'type': 'PHC',
          },
          {
            'name': 'MIOT International',
            'area': 'Manapakkam',
            'type': 'Trauma Centre',
          },
        ].map((c) => _CentreCard(centre: c, color: block.color)),
        const SizedBox(height: 20),
        _SectionHeader(
          icon: Icons.assignment_rounded,
          label: 'Medical Missions',
          color: block.color,
        ),
        const SizedBox(height: 12),
        ...medicalDrills.asMap().entries.map(
          (e) => _DrillCard(
            drill: e.value,
            index: e.key,
            color: block.color,
            completed: e.key < 2,
          ),
        ),
        const SizedBox(height: 20),
        _MissionsSection(block: block),
        const SizedBox(height: 16),
        _CertificateSection(color: block.color, department: 'Medical'),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// FIRE DETAIL SCREEN
// ─────────────────────────────────────────────

class FireDetailScreen extends StatelessWidget {
  final TrainingBlock block;
  const FireDetailScreen({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    return _BaseDetailScreen(
      block: block,
      children: [
        _SectionHeader(
          icon: Icons.info_rounded,
          label: 'How This Works',
          color: block.color,
        ),
        const SizedBox(height: 8),
        _InfoBox(
          color: block.color,
          text:
              'All fire missions must be completed at your nearest government fire station with an authorised fire officer present. Certificate issued upon completing all missions.',
        ),
        const SizedBox(height: 20),
        _SectionHeader(
          icon: Icons.fire_truck_rounded,
          label: 'Nearby Fire Stations',
          color: block.color,
        ),
        const SizedBox(height: 12),
        ...[
          {
            'name': 'Anna Nagar Fire Station',
            'area': 'Anna Nagar West',
            'type': 'District Station',
          },
          {
            'name': 'TNFRS Training Ground',
            'area': 'Egmore',
            'type': 'Training Centre',
          },
          {
            'name': 'Tambaram Fire Station',
            'area': 'Tambaram',
            'type': 'Sub Station',
          },
          {
            'name': 'Guindy Mock Structure',
            'area': 'Guindy',
            'type': 'SDRF Facility',
          },
        ].map((c) => _CentreCard(centre: c, color: block.color)),
        const SizedBox(height: 20),
        _SectionHeader(
          icon: Icons.local_fire_department_rounded,
          label: 'Fire Drill Missions',
          color: block.color,
        ),
        const SizedBox(height: 12),
        ...fireDrills.asMap().entries.map(
          (e) => _DrillCard(
            drill: e.value,
            index: e.key,
            color: block.color,
            completed: e.key < 1,
          ),
        ),
        const SizedBox(height: 20),
        _MissionsSection(block: block),
        const SizedBox(height: 16),
        _CertificateSection(color: block.color, department: 'Fire & Rescue'),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// RESCUE DETAIL SCREEN
// ─────────────────────────────────────────────

class RescueDetailScreen extends StatelessWidget {
  final TrainingBlock block;
  const RescueDetailScreen({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    return _BaseDetailScreen(
      block: block,
      children: [
        _SectionHeader(
          icon: Icons.info_rounded,
          label: 'How This Works',
          color: block.color,
        ),
        const SizedBox(height: 8),
        _InfoBox(
          color: block.color,
          text:
              'All rescue missions are conducted with NDRF or SDRF teams at authorised training locations. Certificate issued by NDRF/SDRF incharge after all missions are completed.',
        ),
        const SizedBox(height: 20),
        _SectionHeader(
          icon: Icons.location_on_rounded,
          label: 'NDRF / SDRF Centres Near You',
          color: block.color,
        ),
        const SizedBox(height: 12),
        ...[
          {
            'name': 'NDRF Regional Centre',
            'area': 'Chennai',
            'type': 'National Unit',
          },
          {
            'name': 'SDRF Training Tower',
            'area': 'Ambattur',
            'type': 'State Unit',
          },
          {'name': 'Mock Rubble Site', 'area': 'Porur', 'type': 'USAR Site'},
          {
            'name': 'Chembarambakkam Reservoir',
            'area': 'West Chennai',
            'type': 'Swiftwater',
          },
        ].map((c) => _CentreCard(centre: c, color: block.color)),
        const SizedBox(height: 20),
        _SectionHeader(
          icon: Icons.flood_rounded,
          label: 'Rescue Missions',
          color: block.color,
        ),
        const SizedBox(height: 12),
        ...rescueDrills.asMap().entries.map(
          (e) => _DrillCard(
            drill: e.value,
            index: e.key,
            color: block.color,
            completed: false,
          ),
        ),
        const SizedBox(height: 20),
        _MissionsSection(block: block),
        const SizedBox(height: 16),
        _CertificateSection(color: block.color, department: 'NDRF / SDRF'),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// DRILL DETAIL SCREEN (Silver — choose department)
// ─────────────────────────────────────────────

class DrillDetailScreen extends StatefulWidget {
  final TrainingBlock block;
  const DrillDetailScreen({super.key, required this.block});

  @override
  State<DrillDetailScreen> createState() => _DrillDetailScreenState();
}

class _DrillDetailScreenState extends State<DrillDetailScreen> {
  String? _selectedDept;

  static const List<Map<String, dynamic>> departments = [
    {
      'id': 'fire',
      'label': 'Fire Department',
      'icon': Icons.local_fire_department_rounded,
      'color': Color(0xFFB84A00),
    },
    {
      'id': 'medical',
      'label': 'Medical Services',
      'icon': Icons.favorite_rounded,
      'color': Color(0xFFD94035),
    },
    {
      'id': 'rescue',
      'label': 'Rescue Team (NDRF)',
      'icon': Icons.flood_rounded,
      'color': Color(0xFF2E6B4F),
    },
  ];

  List<DrillScenario> get _drills {
    switch (_selectedDept) {
      case 'fire':
        return fireDrills;
      case 'medical':
        return medicalDrills;
      case 'rescue':
        return rescueDrills;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return _BaseDetailScreen(
      block: widget.block,
      children: [
        _SectionHeader(
          icon: Icons.directions_run_rounded,
          label: 'Select Your Department',
          color: widget.block.color,
        ),
        const SizedBox(height: 8),
        const Text(
          'Choose a department to view nearby govt offices, authorised personnel, and AI-generated drill scenarios.',
          style: TextStyle(fontSize: 13, color: Color(0xFF666660), height: 1.5),
        ),
        const SizedBox(height: 16),
        Row(
          children: departments.map((d) {
            final selected = _selectedDept == d['id'];
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedDept = d['id']),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: selected ? (d['color'] as Color) : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selected
                          ? (d['color'] as Color)
                          : const Color(0xFFE8E4DF),
                      width: selected ? 2 : 1,
                    ),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: (d['color'] as Color).withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        d['icon'] as IconData,
                        color: selected ? Colors.white : (d['color'] as Color),
                        size: 26,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        d['label'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: selected
                              ? Colors.white
                              : const Color(0xFF444440),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (_selectedDept != null) ...[
          const SizedBox(height: 24),
          _SectionHeader(
            icon: Icons.location_on_rounded,
            label: 'Nearby Govt Departments',
            color: widget.block.color,
          ),
          const SizedBox(height: 12),
          ..._getNearbyForDept(
            _selectedDept!,
          ).map((c) => _CentreCard(centre: c, color: widget.block.color)),
          const SizedBox(height: 20),
          _SectionHeader(
            icon: Icons.auto_awesome_rounded,
            label: 'AI-Generated Drills',
            color: widget.block.color,
          ),
          const SizedBox(height: 8),
          const Text(
            'These drills are AI-generated for on-ground practical experience. Each drill is unique and tailored to the selected department.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF666660),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          ..._drills.asMap().entries.map(
            (e) => _DrillCard(
              drill: e.value,
              index: e.key,
              color: widget.block.color,
              completed: false,
            ),
          ),
        ],
      ],
    );
  }

  List<Map<String, dynamic>> _getNearbyForDept(String dept) {
    switch (dept) {
      case 'fire':
        return [
          {
            'name': 'Anna Nagar Fire Station',
            'area': 'Anna Nagar West',
            'type': 'District Station',
          },
          {
            'name': 'TNFRS Training Ground',
            'area': 'Egmore',
            'type': 'Training Centre',
          },
        ];
      case 'medical':
        return [
          {
            'name': 'Apollo Hospital',
            'area': 'Greams Road',
            'type': 'Multi-specialty',
          },
          {
            'name': 'GH Chennai',
            'area': 'Park Town',
            'type': 'Government Hospital',
          },
        ];
      case 'rescue':
        return [
          {
            'name': 'NDRF Regional Centre',
            'area': 'Chennai',
            'type': 'National Unit',
          },
          {'name': 'SDRF HQ', 'area': 'Fort St. George', 'type': 'State Unit'},
        ];
      default:
        return [];
    }
  }
}

// ─────────────────────────────────────────────
// COMBINED DRILL DETAIL SCREEN
// ─────────────────────────────────────────────

class CombinedDrillDetailScreen extends StatelessWidget {
  final TrainingBlock block;
  const CombinedDrillDetailScreen({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    return _BaseDetailScreen(
      block: block,
      children: [
        _SectionHeader(
          icon: Icons.auto_awesome_rounded,
          label: 'AI-Generated Combined Drills',
          color: block.color,
        ),
        const SizedBox(height: 8),
        _InfoBox(
          color: block.color,
          text:
              'These AI-generated drills simulate a real crisis where ALL departments — fire, rescue, medical, and police — must work together. Each drill is a different scenario.',
        ),
        const SizedBox(height: 20),
        _SectionHeader(
          icon: Icons.hub_rounded,
          label: 'Multi-Agency Scenarios',
          color: block.color,
        ),
        const SizedBox(height: 12),
        ...combinedDrills.asMap().entries.map(
          (e) => _DrillCard(
            drill: e.value,
            index: e.key,
            color: block.color,
            completed: false,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// SHARED DETAIL SCREEN (fallback)
// ─────────────────────────────────────────────

class TrainingDetailScreen extends StatelessWidget {
  final TrainingBlock block;
  const TrainingDetailScreen({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    return _BaseDetailScreen(
      block: block,
      children: [_MissionsSection(block: block)],
    );
  }
}

// ─────────────────────────────────────────────
// SHARED COMPONENTS
// ─────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _SectionHeader({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  final Color color;
  final String text;
  const _InfoBox({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: color,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final Map<String, dynamic> video;
  final int index;
  final Color color;
  final bool completed;
  const _VideoCard({
    required this.video,
    required this.index,
    required this.color,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: completed
              ? const Color(0xFF3D7A3A).withOpacity(0.3)
              : const Color(0xFFE8E4DF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: completed
                    ? const Color(0xFFE8F5E9)
                    : color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                completed
                    ? Icons.check_circle_rounded
                    : (video['icon'] as IconData),
                color: completed ? const Color(0xFF3D7A3A) : color,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          video['tag'] as String,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.access_time_rounded,
                        size: 12,
                        color: const Color(0xFF888880),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        video['duration'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF888880),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!completed)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Watch',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            else
              const Text(
                'Done',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3D7A3A),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SafetyRuleCard extends StatelessWidget {
  final Map<String, dynamic> rule;
  final Color color;
  const _SafetyRuleCard({required this.rule, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(rule['icon'] as IconData, color: color, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              rule['rule'] as String,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF1A1A1A),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrillCard extends StatefulWidget {
  final DrillScenario drill;
  final int index;
  final Color color;
  final bool completed;
  const _DrillCard({
    required this.drill,
    required this.index,
    required this.color,
    required this.completed,
  });

  @override
  State<_DrillCard> createState() => _DrillCardState();
}

class _DrillCardState extends State<_DrillCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.completed
              ? const Color(0xFF3D7A3A).withOpacity(0.3)
              : const Color(0xFFE8E4DF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '${widget.index + 1}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: widget.color,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.drill.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      Icon(
                        _expanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: const Color(0xFF888880),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 42),
                      Expanded(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            _DrillChip(
                              icon: Icons.apartment_rounded,
                              label: widget.drill.department,
                              color: widget.color,
                            ),
                            _DrillChip(
                              icon: Icons.access_time_rounded,
                              label: '${widget.drill.durationMin} min',
                              color: widget.color,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 8),
                  _DrillInfoRow(
                    icon: Icons.location_on_rounded,
                    label: 'Location',
                    value: widget.drill.location,
                  ),
                  const SizedBox(height: 6),
                  _DrillInfoRow(
                    icon: Icons.badge_rounded,
                    label: 'Authorised by',
                    value: widget.drill.authorisedPerson,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Objective',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: widget.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.drill.objective,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF444440),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Steps',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.drill.steps.asMap().entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: widget.color,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${e.key + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              e.value,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF444440),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Start Drill',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
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
}

class _DrillChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _DrillChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrillInfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _DrillInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF888880)),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF888880),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, color: Color(0xFF444440)),
          ),
        ),
      ],
    );
  }
}

class _CentreCard extends StatelessWidget {
  final Map<String, dynamic> centre;
  final Color color;
  const _CentreCard({required this.centre, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.location_on_rounded, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  centre['name'] as String,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  centre['area'] as String,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF888880),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              centre['type'] as String,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.directions_rounded, color: color, size: 18),
        ],
      ),
    );
  }
}

class _CertificateSection extends StatelessWidget {
  final Color color;
  final String department;
  const _CertificateSection({required this.color, required this.department});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.workspace_premium_rounded, color: color, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Completion Certificate',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Issued by authorised $department personnel',
                      style: TextStyle(fontSize: 11, color: color),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Once you complete all missions at the centre, the authorised doctor/incharge will digitally sign and issue your completion certificate. This certificate is required to unlock the next level.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF444440),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.upload_rounded, color: Colors.white, size: 18),
                const SizedBox(width: 6),
                const Text(
                  'Upload Certificate',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
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
    if (block.missions.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          icon: Icons.task_alt_rounded,
          label: 'Missions',
          color: block.color,
        ),
        const SizedBox(height: 12),
        ...block.missions.asMap().entries.map(
          (entry) => _MissionCard(
            mission: entry.value,
            index: entry.key,
            blockColor: block.color,
            isLocked:
                block.status == BlockStatus.locked ||
                (entry.key > 0 &&
                    !block.missions[entry.key - 1].completed &&
                    !entry.value.completed),
          ),
        ),
      ],
    );
  }
}

class _MissionCard extends StatelessWidget {
  final TrainingMission mission;
  final int index;
  final Color blockColor;
  final bool isLocked;
  const _MissionCard({
    required this.mission,
    required this.index,
    required this.blockColor,
    required this.isLocked,
  });

  static const Map<String, Color> _typeColors = {
    'quiz': Color(0xFF2A7ABD),
    'drill': Color(0xFFB84A00),
    'practical': Color(0xFF2E6B4F),
    'puzzle': Color(0xFF6A3FA0),
    'operation': Color(0xFF8B1A1A),
    'video': Color(0xFF0D5B8E),
    'certificate': Color(0xFFC79000),
  };
  static const Map<String, IconData> _typeIcons = {
    'quiz': Icons.quiz_rounded,
    'drill': Icons.fitness_center_rounded,
    'practical': Icons.handshake_rounded,
    'puzzle': Icons.extension_rounded,
    'operation': Icons.crisis_alert_rounded,
    'video': Icons.play_circle_rounded,
    'certificate': Icons.workspace_premium_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final typeColor = _typeColors[mission.type] ?? blockColor;
    final typeIcon = _typeIcons[mission.type] ?? Icons.task_rounded;
    final bool isCert = mission.type == 'certificate';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isCert
            ? const Color(0xFFFFFDE7)
            : (isLocked ? const Color(0xFFF5F2EE) : Colors.white),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: mission.completed
              ? const Color(0xFF3D7A3A).withOpacity(0.3)
              : (isCert
                    ? const Color(0xFFC79000).withOpacity(0.4)
                    : const Color(0xFFE8E4DF)),
        ),
        boxShadow: isLocked
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isLocked
                  ? const Color(0xFFE0DDD8)
                  : typeColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isLocked
                  ? Icons.lock_outline_rounded
                  : (mission.completed ? Icons.check_rounded : typeIcon),
              color: isLocked
                  ? const Color(0xFFB0ACA6)
                  : (mission.completed ? const Color(0xFF3D7A3A) : typeColor),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mission.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isLocked
                        ? const Color(0xFFB0ACA6)
                        : const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isLocked
                            ? const Color(0xFFE8E4DF)
                            : typeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        mission.type.toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: isLocked ? const Color(0xFFB0ACA6) : typeColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    if (mission.durationMin > 0) ...[
                      const SizedBox(width: 6),
                      Text(
                        '${mission.durationMin} min',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF888880),
                        ),
                      ),
                    ],
                    const SizedBox(width: 6),
                    Text(
                      '+${mission.xp} XP',
                      style: TextStyle(
                        fontSize: 11,
                        color: isLocked ? const Color(0xFFB0ACA6) : blockColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (mission.score != null)
            Column(
              children: [
                Text(
                  mission.score!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF3D7A3A),
                  ),
                ),
                const Text(
                  'score',
                  style: TextStyle(fontSize: 9, color: Color(0xFF888880)),
                ),
              ],
            )
          else if (!isLocked && !mission.completed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isCert ? const Color(0xFFC79000) : blockColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isCert ? 'Upload' : 'Start',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          else if (isLocked)
            const Icon(Icons.lock_rounded, color: Color(0xFFB0ACA6), size: 18),
        ],
      ),
    );
  }
}
