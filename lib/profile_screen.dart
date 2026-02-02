import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildProfileInfo(),
            _buildHealthStats(),
            _buildMedicalHistory(),
            _buildFamilyHistory(),
            _buildEmergencyContacts(),
            _buildNotesSection(),
            _buildSettingsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          color: Colors.redAccent,
        ),
        Positioned(
          top: 50,
          left: 20,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/profile_pic.png'),
            ),
          ),
        ),
        Positioned(
          top: 65,
          left: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ayush Kumar",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "01 April, 2004",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 160,
          left: 20,
          right: 20,
          child: Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHeaderStat("75 kg", "Weight"),
                  _buildHeaderStat("182 cm", "Height"),
                  _buildHeaderStat("0+", "Blood Type"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderStat(String value, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildInfoRow("Full Name", "Ayush Kumar"),
              _buildInfoRow("Date of Birth", "01 April, 2004"),
              _buildInfoRow("Gender", "Male"),
              _buildInfoRow("Marital Status", "Single"),
              _buildInfoRow("Nationality", "Indian"),
              _buildInfoRow("Address", "123, Street Name, City, State"),
              _buildInfoRow("Phone Number", "+91 9876543210"),
              _buildInfoRow("Email", "ayush@example.com"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthStats() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Health Statistics",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildInfoRow("Weight", "75 kg"),
              _buildInfoRow("Height", "182 cm"),
              _buildInfoRow("Blood Type", "0+"),
              _buildInfoRow("BMI", "22.6"),
              _buildInfoRow("Allergies", "Grape, Apple, Strawberry"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedicalHistory() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Medical History",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildMedicalHistoryRow("Asthma", "Since 2010"),
              _buildMedicalHistoryRow("Diabetes", "Diagnosed 2015"),
              _buildMedicalHistoryRow("Hypertension", "Diagnosed 2018"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedicalHistoryRow(String condition, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            condition,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Text(
            details,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyHistory() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Family History",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildFamilyHistoryRow("Father", "Hypertension"),
              _buildFamilyHistoryRow("Mother", "Diabetes"),
              _buildFamilyHistoryRow("Siblings", "Asthma"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFamilyHistoryRow(String relative, String condition) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            relative,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Text(
            condition,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContacts() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Emergency Contacts",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildEmergencyContactRow("Father", "+91 9876543211"),
              _buildEmergencyContactRow("Mother", "+91 9876543212"),
              _buildEmergencyContactRow("Sister", "+91 9876543213"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyContactRow(String name, String phoneNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Text(
            phoneNumber,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notes",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "This section can be used to add any additional notes or information about the patient's health or medical conditions.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter notes here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Settings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildSettingsRow("Receive Notifications", true),
              _buildSettingsRow("Share Health Data", false),
              _buildSettingsRow("Enable Dark Mode", false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsRow(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Switch(
            value: value,
            onChanged: (bool newValue) {
              // Handle switch state change
            },
          ),
        ],
      ),
    );
  }
}
