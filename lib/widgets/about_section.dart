import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';
import '../utils/responsive.dart';
import 'animated_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    double sectionPadding = isMobile ? 24.0 : 48.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: sectionPadding, vertical: 40.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Heading
          FadeInUp(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 3,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  "About Me",
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.textPrimary,
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 24,
                  height: 3,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Main Layout: Row on Desktop/Tablet, Column on Mobile
          Responsive(
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildAboutText(context, false),
                ),
                const SizedBox(width: 60),
                Expanded(
                  flex: 2,
                  child: _buildMockupDisplay(context),
                ),
              ],
            ),
            mobile: Column(
              children: [
                _buildAboutText(context, true),
                const SizedBox(height: 40),
                _buildMockupDisplay(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutText(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        FadeInUp(
          delay: const Duration(milliseconds: 100),
          child: Text(
            "Hello, I am Ranbir Saini",
            style: GoogleFonts.poppins(
              color: AppColors.primary,
              fontSize: isMobile ? 18 : 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeInUp(
          delay: const Duration(milliseconds: 200),
          child: Text(
            "I am a passionate software developer based in Karnal, Haryana, India. Over the last 4 years, I've worked across multiple product-based and agency companies to deliver robust mobile applications for global clients. My expertise spans complex integrations, from IoT protocols like MQTT and real-time syncing using Socket.io to contactless business solutions using NFC and QR codes.",
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: isMobile ? 13 : 15,
              height: 1.7,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeInUp(
          delay: const Duration(milliseconds: 300),
          child: Text(
            "I enjoy solving critical bugs, optimizing app performances, and deploying stable release builds to the Google Play Store and Apple App Store. I write clean, modular code following MVC, Bloc, or Clean Architecture pattern guidelines according to industry best practices.",
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: isMobile ? 13 : 15,
              height: 1.7,
            ),
          ),
        ),
        const SizedBox(height: 36),

        // Statistics Grid
        FadeInUp(
          delay: const Duration(milliseconds: 400),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: const [
              _StatCard(title: "Years Experience", value: "3.9+"),
              _StatCard(title: "Apps Launched", value: "10+"),
              _StatCard(title: "Happy Clients", value: "100%"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMockupDisplay(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = Responsive.isMobile(context);

    double mockupWidth = isMobile ? size.width * 0.75 : 280;
    if (mockupWidth > 320) mockupWidth = 320;
    double mockupHeight = mockupWidth * 1.8;

    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      child: Center(
        child: Container(
          width: mockupWidth,
          height: mockupHeight,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: AppColors.cardBorder, width: 6),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withOpacity(0.15),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              children: [
                // Simulated App Background
                Container(
                  color: const Color(0xFF0F172A),
                ),
                
                // Simulated Mobile Navbar Status Bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 24,
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "09:41",
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.wifi, color: Colors.white, size: 10),
                            SizedBox(width: 4),
                            Icon(Icons.battery_full_rounded, color: Colors.white, size: 10),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                // Simulated App Screen Contents
                Positioned.fill(
                  top: 24,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          "Live Project Dashboard",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "NFC Card Active Status",
                          style: GoogleFonts.poppins(
                            color: AppColors.textSecondary,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Circular Chart Simulation
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 8),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Glowing Center
                                Container(
                                  width: 84,
                                  height: 84,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary.withOpacity(0.05),
                                  ),
                                ),
                                // Inner text
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "94%",
                                      style: GoogleFonts.spaceGrotesk(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "Success",
                                      style: GoogleFonts.poppins(color: AppColors.textSecondary, fontSize: 8),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Fake Activity Tiles
                        Expanded(
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildFakeTile(Icons.wifi_tethering_rounded, "Socket Connection", "Connected", AppColors.primary),
                              const SizedBox(height: 8),
                              _buildFakeTile(Icons.nfc_rounded, "NFC Card Sync", "Ready", AppColors.secondary),
                              const SizedBox(height: 8),
                              _buildFakeTile(Icons.map_rounded, "Location GPS Tracking", "Active", Colors.amber ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildFakeTile(IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cardBorder.withOpacity(0.5), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 14),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(color: AppColors.textSecondary, fontSize: 8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.primary,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
