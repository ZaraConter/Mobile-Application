import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _loadPersonalInfo();

    // Listen for changes and auto-save
    _nameController.addListener(_savePersonalInfo);
    _emailController.addListener(_savePersonalInfo);
    _phoneController.addListener(_savePersonalInfo);
    _addressController.addListener(_savePersonalInfo);
  }

  @override
  void dispose() {
    // Remove listeners to prevent memory leaks
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Load stored personal info from SharedPreferences
  Future<void> _loadPersonalInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? 'Zara Conter';
      _emailController.text = prefs.getString('email') ?? 'zaraconter1@gmail.com';
      _phoneController.text = prefs.getString('phone') ?? '';
      _addressController.text = prefs.getString('address') ?? '';
      String? dateString = prefs.getString('dob');
      if (dateString != null) {
        _selectedDate = DateTime.parse(dateString);
      }
    });
  }

  // Save personal info automatically
  Future<void> _savePersonalInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('address', _addressController.text);
    if (_selectedDate != null) {
      await prefs.setString('dob', _selectedDate!.toIso8601String());
    }
  }

  // Select Date of Birth and auto-save
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      _savePersonalInfo(); // Auto-save when date is selected
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Go back to ProfilePage
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Full Name', _nameController),
            _buildTextField('Email', _emailController, keyboardType: TextInputType.emailAddress),
            _buildTextField('Phone Number', _phoneController, keyboardType: TextInputType.phone),
            _buildTextField('Address', _addressController),
            
            // Date of Birth Picker
            ListTile(
              title: Text('Date of Birth'),
              subtitle: Text(
                _selectedDate == null
                    ? 'Select your date of birth'
                    : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              ),
              trailing:const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), // Go back to ProfilePage
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
