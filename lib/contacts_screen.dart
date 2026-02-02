import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height, // Ensure it fills the entire height
            decoration: const BoxDecoration(color: Color(0xFFFAFAFA)),
            child: Stack(
              children: [
                const Positioned(
                  left: 50,
                  top: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 139),
                      Text(
                        'Contact',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2B2828),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 45,
                  top: 101,
                  child: Column(
                    children: [
                      _buildContactCard('Father', '143-321-6543', 'Safe', const Color(0xFF3BC273), const Color(0xFFF1FFF6)),
                      const SizedBox(height: 16),
                      _buildContactCard('Mother', '652-345-6543', 'Safe', const Color(0xFF3BC273), const Color(0xFFF1FFF6)),
                      const SizedBox(height: 16),
                      _buildContactCard('Anirudh', '654-321-5678', 'Safe', const Color(0xFF3BC273), const Color(0xFFF1FFF6)),
                      const SizedBox(height: 16),
                      _buildContactCard('Varshith', '987-543-321', 'Need Help', const Color(0xFFEC6461), const Color(0xFFFDF9F9)),
                      const SizedBox(height: 16),
                      _buildContactCard('Rishitha', '456-678-1234', 'Safe', const Color(0xFF3BC273), const Color(0xFFF1FFF6)),
                      const SizedBox(height: 16),
                      _buildContactCard('Uday Sai', '321-654-9876', 'Safe', const Color(0xFF3BC273), const Color(0xFFF1FFF6)),
                      const SizedBox(height: 16),
                      _buildAddNewCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(String name, String phone, String status, Color statusColor, Color backgroundColor) {
    return Container(
      width: 386,
      height: 84,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 48,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Container(
            width: 44,
            height: 44,
            decoration: ShapeDecoration(
              color: status.isNotEmpty ? statusColor : const Color(0xFFEC6461),
              shape: const OvalBorder(),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Color(0xFF2B2828),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                phone,
                style: const TextStyle(
                  color: Color(0xFFA39D9D),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (status.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ),
          const SizedBox(width: 14),
        ],
      ),
    );
  }

  Widget _buildAddNewCard() {
    return Container(
      width: 386,
      height: 84,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 48,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Container(
            width: 44,
            height: 44,
            decoration: const ShapeDecoration(
              color: Color(0xFFEC6461),
              shape: OvalBorder(),
            ),
            child: const Center(
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New',
                style: TextStyle(
                  color: Color(0xFF2B2828),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Max 4 Contacts',
                style: TextStyle(
                  color: Color(0xFFA39D9D),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const Spacer(),
          const SizedBox(width: 14),
        ],
      ),
    );
  }
}
