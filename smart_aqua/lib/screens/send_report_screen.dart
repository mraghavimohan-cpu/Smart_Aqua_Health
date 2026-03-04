import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SendReportScreen extends StatefulWidget {
  const SendReportScreen({super.key});

  @override
  State<SendReportScreen> createState() => _SendReportScreenState();
}

class _SendReportScreenState extends State<SendReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _supabase = Supabase.instance.client;

  // Controllers
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _waterSourceController = TextEditingController();
  final _waterDetailsController = TextEditingController();
  final _customSymptomController = TextEditingController();

  String _waterUse = 'Drinking';
  String _waterSource = 'Tap Water';
  List<String> _selectedSymptoms = [];
  bool _isLoading = false;

  final List<String> _symptomsList = [
    'Fever', 'Nausea', 'Fatigue', 'Diarrhea', 'Vomiting',
    'Skin Rash', 'Joint Pain', 'Stiffness in Joints', 'Bone Pain',
    'Back Pain', 'Difficulty Walking', 'Dental Stains',
    'Headache', 'Stomach Pain', 'Dizziness',
  ];

  final List<String> _waterSources = [
    'Tap Water', 'Borewell', 'River', 'Lake', 'Rainwater', 'Tanker', 'Other'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _waterSourceController.dispose();
    _waterDetailsController.dispose();
    _customSymptomController.dispose();
    super.dispose();
  }

  void _addCustomSymptom() {
    final s = _customSymptomController.text.trim();
    if (s.isEmpty) return;
    if (!_selectedSymptoms.contains(s)) {
      setState(() => _selectedSymptoms.add(s));
    }
    _customSymptomController.clear();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedSymptoms.isEmpty) {
      _snack('Please select at least one symptom');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      await _supabase.from('patient_reports').insert({
        'user_id': user?.uid,
        'user_email': user?.email,
        'name': _nameController.text.trim(),
        'age': int.tryParse(_ageController.text.trim()),
        'phone': _phoneController.text.trim(),
        'location': _locationController.text.trim(),
        'water_use': _waterUse,
        'water_source': _waterSource,
        'water_details': _waterDetailsController.text.trim(),
        'symptoms': _selectedSymptoms,
        'status': 'pending',
        'created_at': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;
      _showSuccess();
    } catch (e) {
      _snack('Error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _snack(String msg, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: success ? Colors.green : Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  void _showSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.check_circle_rounded,
                color: Colors.green, size: 60),
          ),
          const SizedBox(height: 16),
          const Text('Report Submitted!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'Your health report has been sent.\nAdmin will review and verify it shortly.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // go back to home
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text('Back to Home',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text('Send Health Report',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Section 1: Personal Details ──
              _sectionTitle('👤 Personal Details'),
              const SizedBox(height: 12),
              _card(child: Column(children: [
                _field(
                  controller: _nameController,
                  label: 'Full Name *',
                  icon: Icons.person_rounded,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                ),
                const SizedBox(height: 14),
                Row(children: [
                  Expanded(child: _field(
                    controller: _ageController,
                    label: 'Age *',
                    icon: Icons.cake_rounded,
                    isNumber: true,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Required';
                      if (int.tryParse(v) == null) return 'Invalid';
                      return null;
                    },
                  )),
                  const SizedBox(width: 12),
                  Expanded(child: _field(
                    controller: _phoneController,
                    label: 'Phone *',
                    icon: Icons.phone_rounded,
                    isNumber: true,
                    maxLength: 10,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      if (v.length != 10) return '10 digits';
                      return null;
                    },
                  )),
                ]),
                const SizedBox(height: 14),
                _field(
                  controller: _locationController,
                  label: 'Location / Area *',
                  icon: Icons.location_on_rounded,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Location is required' : null,
                ),
              ])),

              const SizedBox(height: 20),

              // ── Section 2: Drinking Water Details ──
              _sectionTitle('💧 Drinking Water Details'),
              const SizedBox(height: 12),
              _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Water Use dropdown
                DropdownButtonFormField<String>(
                  value: _waterUse,
                  decoration: _inputDecoration('Water Usage', Icons.opacity_rounded),
                  items: ['Drinking', 'Cooking', 'Bathing', 'All']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => _waterUse = v!),
                ),
                const SizedBox(height: 14),
                // Water Source
                DropdownButtonFormField<String>(
                  value: _waterSource,
                  decoration: _inputDecoration('Water Source', Icons.water_rounded),
                  items: _waterSources
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => _waterSource = v!),
                ),
                const SizedBox(height: 14),
                // Describe water
                TextFormField(
                  controller: _waterDetailsController,
                  maxLines: 3,
                  decoration: _inputDecoration(
                    'Describe your water (color, smell, taste, etc.)',
                    Icons.edit_note_rounded,
                  ).copyWith(alignLabelWithHint: true),
                ),
              ])),

              const SizedBox(height: 20),

              // ── Section 3: Symptoms ──
              _sectionTitle('🤒 Symptoms'),
              const SizedBox(height: 12),
              _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Tap to select your symptoms:',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _symptomsList.map((s) {
                    final selected = _selectedSymptoms.contains(s);
                    return GestureDetector(
                      onTap: () => setState(() {
                        selected ? _selectedSymptoms.remove(s) : _selectedSymptoms.add(s);
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: selected ? Colors.teal : Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: Colors.teal, width: 1.5),
                        ),
                        child: Text(s,
                            style: TextStyle(
                                color: selected ? Colors.white : Colors.teal,
                                fontWeight: FontWeight.w500,
                                fontSize: 13)),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),
                const Divider(),
                const SizedBox(height: 10),
                // Custom symptom
                Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: _customSymptomController,
                      decoration: _inputDecoration('Add other symptom', Icons.add_circle_outline),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addCustomSymptom,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: const Icon(Icons.add),
                  ),
                ]),
                // Selected symptoms chips
                if (_selectedSymptoms.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const Text('Selected:',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6, runSpacing: 6,
                    children: _selectedSymptoms.map((s) => Chip(
                      label: Text(s),
                      backgroundColor: Colors.teal.withOpacity(0.1),
                      labelStyle: const TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
                      deleteIcon: const Icon(Icons.close, size: 16),
                      deleteIconColor: Colors.red,
                      onDeleted: () => setState(() => _selectedSymptoms.remove(s)),
                    )).toList(),
                  ),
                ],
              ])),

              const SizedBox(height: 28),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _submit,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20, height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.send_rounded),
                  label: Text(_isLoading ? 'Sending...' : 'Send Report',
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 4,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Text(title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal));

  Widget _card({required Widget child}) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: child,
      );

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isNumber = false,
    int? maxLength,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLength: maxLength,
        inputFormatters: isNumber
            ? [FilteringTextInputFormatter.digitsOnly, if (maxLength != null) LengthLimitingTextInputFormatter(maxLength)]
            : [],
        validator: validator,
        decoration: _inputDecoration(label, icon).copyWith(counterText: ''),
      );

  InputDecoration _inputDecoration(String label, IconData icon) => InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      );
}
