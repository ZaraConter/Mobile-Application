import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicalRecordsPage extends StatefulWidget {
  @override
  _MedicalRecordsPageState createState() => _MedicalRecordsPageState();
}

class _MedicalRecordsPageState extends State<MedicalRecordsPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _conditionController = TextEditingController();
  TextEditingController _medicationController = TextEditingController();
  TextEditingController _doctorController = TextEditingController();
  TextEditingController _otherConditionController = TextEditingController();
  TextEditingController _otherMedicationController = TextEditingController();
  TextEditingController _otherDoctorController = TextEditingController();
  TextEditingController _handicapDetailsController = TextEditingController();

  String? _selectedCondition;
  String? _selectedMedication;
  String? _selectedDoctor;
  String? _selectedHandicap;

  final List<String> _conditions = ['Diabetes', 'Hypertension', 'Asthma', 'Other'];
  final List<String> _medications = ['Insulin', 'Aspirin', 'Ventolin', 'Other'];
  final List<String> _doctors = ['Dr. John Doe', 'Dr. Jane Smith', 'Dr. Alan Brown', 'Other'];
  final List<String> _handicaps = ['None', 'Wheelchair-bound', 'Visually Impaired', 'Hearing Impaired', 'Other'];

  bool _isEditing = false;

  Future<void> _loadMedicalRecords() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _selectedCondition = prefs.getString('condition') ?? '';
      _selectedMedication = prefs.getString('medication') ?? '';
      _selectedDoctor = prefs.getString('doctor') ?? '';
      _selectedHandicap = prefs.getString('handicap') ?? 'None';  // Default value to 'None'
      _otherConditionController.text = prefs.getString('otherCondition') ?? '';
      _otherMedicationController.text = prefs.getString('otherMedication') ?? '';
      _otherDoctorController.text = prefs.getString('otherDoctor') ?? '';
      _doctorController.text = prefs.getString('doctorContact') ?? '';  // Load doctor's contact
      _handicapDetailsController.text = prefs.getString('handicapDetails') ?? '';
    });
  }

  Future<void> _saveMedicalRecords() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('condition', _selectedCondition ?? '');
    prefs.setString('medication', _selectedMedication ?? '');
    prefs.setString('doctor', _selectedDoctor ?? '');
    prefs.setString('handicap', _selectedHandicap ?? '');
    prefs.setString('otherCondition', _otherConditionController.text);
    prefs.setString('otherMedication', _otherMedicationController.text);
    prefs.setString('otherDoctor', _otherDoctorController.text);
    prefs.setString('doctorContact', _doctorController.text);  // Save doctor's contact
    prefs.setString('handicapDetails', _handicapDetailsController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Medical records saved successfully')),
    );

    setState(() {
      _isEditing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMedicalRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Records', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          !_isEditing
              ? IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                    });
                  },
                )
              : Container(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Medical Condition Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedCondition,
                  hint: const Text('Select a Condition'),
                  items: _conditions.map((String condition) {
                    return DropdownMenuItem<String>(
                      value: condition,
                      child: Text(condition),
                    );
                  }).toList(),
                  onChanged: _isEditing
                      ? (value) {
                          setState(() {
                            _selectedCondition = value;
                          });
                        }
                      : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a condition';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
                if (_selectedCondition == 'Other')
                  TextFormField(
                    controller: _otherConditionController,
                    decoration: const InputDecoration(
                      labelText: 'Please specify condition',
                      border: OutlineInputBorder(),
                      hintText: 'Enter condition details',
                    ),
                    enabled: _isEditing,
                  ),
                const SizedBox(height: 20),
                
                const Text(
                  'Medication Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedMedication,
                  hint: const Text('Select Medication'),
                  items: _medications.map((String medication) {
                    return DropdownMenuItem<String>(
                      value: medication,
                      child: Text(medication),
                    );
                  }).toList(),
                  onChanged: _isEditing
                      ? (value) {
                          setState(() {
                            _selectedMedication = value;
                          });
                        }
                      : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a medication';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
                if (_selectedMedication == 'Other')
                  TextFormField(
                    controller: _otherMedicationController,
                    decoration: const InputDecoration(
                      labelText: 'Please specify medication',
                      border: OutlineInputBorder(),
                      hintText: 'Enter medication details',
                    ),
                    enabled: _isEditing,
                  ),
                const SizedBox(height: 20),
                
                const Text(
                  'Doctor Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedDoctor,
                  hint: const Text('Select Your Doctor'),
                  items: _doctors.map((String doctor) {
                    return DropdownMenuItem<String>(
                      value: doctor,
                      child: Text(doctor),
                    );
                  }).toList(),
                  onChanged: _isEditing
                      ? (value) {
                          setState(() {
                            _selectedDoctor = value;
                          });
                        }
                      : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a doctor';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
                if (_selectedDoctor == 'Other')
                  TextFormField(
                    controller: _otherDoctorController,
                    decoration: const InputDecoration(
                      labelText: 'Please specify doctor',
                      border: OutlineInputBorder(),
                      hintText: 'Enter doctor details',
                    ),
                    enabled: _isEditing,
                  ),
                const SizedBox(height: 20),
                
                // Doctor's contact
                TextFormField(
                  controller: _doctorController,
                  decoration: const InputDecoration(
                    labelText: 'Doctor\'s Contact',
                    border: OutlineInputBorder(),
                    hintText: 'Enter doctor\'s contact information',
                  ),
                  enabled: _isEditing,
                ),
                const SizedBox(height: 20),
                
                // Handicap section
                const Text(
                  'Handicap Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedHandicap,
                  hint: const Text('Select Handicap Type'),
                  items: _handicaps.map((String handicap) {
                    return DropdownMenuItem<String>(
                      value: handicap,
                      child: Text(handicap),
                    );
                  }).toList(),
                  onChanged: _isEditing
                      ? (value) {
                          setState(() {
                            _selectedHandicap = value;
                          });
                        }
                      : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a handicap';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
                if (_selectedHandicap == 'Other')
                  TextFormField(
                    controller: _handicapDetailsController,
                    decoration: const InputDecoration(
                      labelText: 'Please specify handicap details',
                      border: OutlineInputBorder(),
                      hintText: 'Enter handicap details',
                    ),
                    enabled: _isEditing,
                  ),
                const SizedBox(height: 20),
                
                // Save button
                if (_isEditing)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _saveMedicalRecords();
                          Navigator.pop(context);  // Go back to the Profile Page after saving
                        }
                      },
                      child: const Text('Save Medical Record'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
