import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';
import 'send_report_screen.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    _HomeTab(),
    _ProfileTab(),
    _AlertsTab(),
    _WaterQualityTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_rounded), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop_rounded), label: 'Water'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// TAB 1 — HOME
// ═══════════════════════════════════════════
class _HomeTab extends StatefulWidget {
  const _HomeTab();
  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _reports = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() => _loading = true);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    try {
      final data = await _supabase
          .from('patient_reports')
          .select('name, location, symptoms, status, created_at')
          .eq('user_id', uid)
          .order('created_at', ascending: false)
          .limit(5);
      setState(() {
        _reports = List<Map<String, dynamic>>.from(data);
        _loading = false;
      });
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Smart Aqua Health',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.signOut();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (r) => false);
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Colors.teal,
        onRefresh: _loadReports,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.teal, Color(0xFF00ACC1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.teal.withOpacity(0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 6)),
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Welcome!',
                              style: TextStyle(color: Colors.white70, fontSize: 13)),
                          Text(
                            user?.email ?? 'User',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          const Text('Stay healthy, drink clean water 💧',
                              style: TextStyle(color: Colors.white60, fontSize: 11)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Send Report Button
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SendReportScreen()),
                  );
                  _loadReports();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.teal.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4)),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.send_rounded, color: Colors.white, size: 28),
                      SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Send Health Report',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Text('Name, symptoms, water details & more',
                              style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text('My Recent Reports',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              if (_loading)
                const Center(child: CircularProgressIndicator(color: Colors.teal))
              else if (_reports.isEmpty)
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14)),
                  child: const Center(
                    child: Column(
                      children: [
                        Icon(Icons.description_outlined, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('No reports yet. Tap above to send one!',
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                )
              else
                ..._reports.map((r) {
                  final status = r['status'] ?? 'pending';
                  Color sc = status == 'verified'
                      ? Colors.green
                      : status == 'rejected'
                          ? Colors.red
                          : Colors.orange;
                  IconData si = status == 'verified'
                      ? Icons.check_circle
                      : status == 'rejected'
                          ? Icons.cancel
                          : Icons.access_time;
                  final date = DateTime.tryParse(r['created_at'] ?? '');
                  final ds = date != null
                      ? '${date.day}/${date.month}/${date.year}'
                      : '';
                  final symptoms = List<String>.from(r['symptoms'] ?? []);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(
                              child: Text(r['name'] ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15))),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: sc.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: sc)),
                            child: Row(children: [
                              Icon(si, size: 12, color: sc),
                              const SizedBox(width: 4),
                              Text(status.toUpperCase(),
                                  style: TextStyle(
                                      color: sc,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                            ]),
                          ),
                        ]),
                        const SizedBox(height: 6),
                        Row(children: [
                          const Icon(Icons.location_on, size: 13, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(r['location'] ?? '',
                              style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          const Spacer(),
                          Text(ds,
                              style:
                                  const TextStyle(color: Colors.grey, fontSize: 11)),
                        ]),
                        if (symptoms.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: symptoms
                                .take(3)
                                .map((s) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: Colors.teal.withOpacity(0.08),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Text(s,
                                          style: const TextStyle(
                                              fontSize: 11, color: Colors.teal)),
                                    ))
                                .toList(),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// TAB 2 — PROFILE
// ═══════════════════════════════════════════
class _ProfileTab extends StatefulWidget {
  const _ProfileTab();
  @override
  State<_ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<_ProfileTab> {
  final _supabase = Supabase.instance.client;
  Map<String, dynamic>? _latest;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    try {
      final data = await _supabase
          .from('patient_reports')
          .select()
          .eq('user_id', uid)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();
      setState(() { _latest = data; _loading = false; });
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.teal.withOpacity(0.1),
                  child: const Icon(Icons.person, size: 55, color: Colors.teal),
                ),
                const SizedBox(height: 12),
                Text(_latest?['name'] ?? user?.email ?? 'User',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(user?.email ?? '',
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 20),
                _infoCard(children: [
                  _row(Icons.cake_rounded, 'Age', _latest?['age']?.toString() ?? '—'),
                  _row(Icons.phone_rounded, 'Phone', _latest?['phone'] ?? '—'),
                  _row(Icons.location_on_rounded, 'Location', _latest?['location'] ?? '—'),
                  _row(Icons.water_drop_rounded, 'Water Use', _latest?['water_use'] ?? '—'),
                ]),
                const SizedBox(height: 14),
                if ((_latest?['symptoms'] as List?)?.isNotEmpty == true)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('Reported Symptoms',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const Divider(height: 18),
                      Wrap(
                        spacing: 8, runSpacing: 8,
                        children: List<String>.from(_latest?['symptoms'] ?? [])
                            .map((s) => Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: Colors.teal.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.teal)),
                                  child: Text(s, style: const TextStyle(color: Colors.teal, fontSize: 13)),
                                ))
                            .toList(),
                      ),
                    ]),
                  ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await AuthService.signOut();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false);
                      }
                    },
                    icon: const Icon(Icons.logout, color: Colors.red),
                    label: const Text('Logout', style: TextStyle(color: Colors.red)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ]),
            ),
    );
  }

  Widget _infoCard({required List<Widget> children}) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Personal Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const Divider(height: 18),
          ...children,
        ]),
      );

  Widget _row(IconData icon, String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(children: [
          Icon(icon, color: Colors.teal, size: 18),
          const SizedBox(width: 10),
          Text('$label: ', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ]),
      );
}

// ═══════════════════════════════════════════
// TAB 3 — ALERTS
// ═══════════════════════════════════════════
class _AlertsTab extends StatefulWidget {
  const _AlertsTab();
  @override
  State<_AlertsTab> createState() => _AlertsTabState();
}

class _AlertsTabState extends State<_AlertsTab> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _alerts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    try {
      final data = await _supabase
          .from('patient_reports')
          .select('name, status, location, created_at')
          .eq('user_id', uid)
          .order('created_at', ascending: false);
      setState(() { _alerts = List<Map<String, dynamic>>.from(data); _loading = false; });
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text('Alerts & Notifications',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _load)],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : _alerts.isEmpty
              ? const Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.notifications_none, size: 70, color: Colors.grey),
                    SizedBox(height: 14),
                    Text('No notifications yet',
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                  ]))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _alerts.length,
                  itemBuilder: (_, i) {
                    final a = _alerts[i];
                    final status = a['status'] ?? 'pending';
                    final date = DateTime.tryParse(a['created_at'] ?? '');
                    final ds = date != null
                        ? '${date.day}/${date.month}/${date.year}  ${date.hour}:${date.minute.toString().padLeft(2, '0')}'
                        : '';
                    Color color;
                    IconData icon;
                    String message;
                    if (status == 'verified') {
                      color = Colors.green;
                      icon = Icons.check_circle_rounded;
                      message = 'Your report has been verified by admin ✅';
                    } else if (status == 'rejected') {
                      color = Colors.red;
                      icon = Icons.cancel_rounded;
                      message = 'Your report was rejected. Please resubmit ❌';
                    } else {
                      color = Colors.orange;
                      icon = Icons.access_time_rounded;
                      message = 'Your report is under admin review ⏳';
                    }
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: color.withOpacity(0.3)),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
                      ),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Icon(icon, color: color, size: 30),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(a['name'] ?? '',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(height: 4),
                          Text(message, style: TextStyle(color: color, fontSize: 13)),
                          const SizedBox(height: 6),
                          Text('📍 ${a['location'] ?? ''}   🕐 $ds',
                              style: const TextStyle(color: Colors.grey, fontSize: 11)),
                        ])),
                      ]),
                    );
                  },
                ),
    );
  }
}

// ═══════════════════════════════════════════
// TAB 4 — WATER QUALITY
// ═══════════════════════════════════════════
class _WaterQualityTab extends StatefulWidget {
  const _WaterQualityTab();
  @override
  State<_WaterQualityTab> createState() => _WaterQualityTabState();
}

class _WaterQualityTabState extends State<_WaterQualityTab> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _data = [];
  bool _loading = true;
  String _selected = 'All';
  List<String> _locations = ['All'];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final data = await _supabase.from('water_quality').select().order('created_at', ascending: false);
      final list = List<Map<String, dynamic>>.from(data);
      final locs = list.map((e) => e['location']?.toString() ?? '').where((e) => e.isNotEmpty).toSet().toList();
      setState(() { _data = list; _locations = ['All', ...locs]; _loading = false; });
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  List<Map<String, dynamic>> get _filtered =>
      _selected == 'All' ? _data : _data.where((e) => e['location'] == _selected).toList();

  Color _qColor(String? q) {
    switch (q?.toLowerCase()) {
      case 'good': return Colors.green;
      case 'moderate': return Colors.orange;
      case 'poor': return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text('Water Quality', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _load)],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : Column(children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Filter by Location:',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _locations.map((loc) => GestureDetector(
                        onTap: () => setState(() => _selected = loc),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: _selected == loc ? Colors.teal : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.teal),
                          ),
                          child: Text(loc,
                              style: TextStyle(
                                  color: _selected == loc ? Colors.white : Colors.teal,
                                  fontWeight: FontWeight.w600, fontSize: 13)),
                        ),
                      )).toList(),
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: _filtered.isEmpty
                    ? const Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(Icons.water_drop_outlined, size: 64, color: Colors.grey),
                          SizedBox(height: 12),
                          Text('No data available', style: TextStyle(color: Colors.grey, fontSize: 15)),
                        ]))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filtered.length,
                        itemBuilder: (_, i) {
                          final w = _filtered[i];
                          final quality = w['quality']?.toString();
                          final color = _qColor(quality);
                          final date = DateTime.tryParse(w['created_at'] ?? '');
                          final ds = date != null ? '${date.day}/${date.month}/${date.year}' : '';
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: color.withOpacity(0.3)),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
                            ),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(children: [
                                const Icon(Icons.location_on, color: Colors.teal, size: 16),
                                const SizedBox(width: 6),
                                Expanded(child: Text(w['location'] ?? 'Unknown',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: color.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: color)),
                                  child: Text(quality?.toUpperCase() ?? 'N/A',
                                      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11)),
                                ),
                              ]),
                              const SizedBox(height: 12),
                              Wrap(spacing: 8, runSpacing: 6, children: [
                                if (w['ph'] != null) _chip('pH', '${w['ph']}'),
                                if (w['turbidity'] != null) _chip('Turbidity', '${w['turbidity']} NTU'),
                                if (w['tds'] != null) _chip('TDS', '${w['tds']} ppm'),
                                if (w['temperature'] != null) _chip('Temp', '${w['temperature']}°C'),
                              ]),
                              if (w['notes'] != null) ...[
                                const SizedBox(height: 8),
                                Text(w['notes'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                              const SizedBox(height: 6),
                              Text('📅 $ds', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                            ]),
                          );
                        },
                      ),
              ),
            ]),
    );
  }

  Widget _chip(String label, String value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.07),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.withOpacity(0.3))),
        child: Text('$label: $value',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.teal)),
      );
}
