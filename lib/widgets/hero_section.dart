import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/constants.dart';
import '../utils/responsive.dart';
import 'animated_widgets.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContactMe;

  const HeroSection({
    Key? key,
    required this.onViewWork,
    required this.onContactMe,
  }) : super(key: key);

  Future<void> _launchUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    double titleFontSize = isMobile ? 38 : (isTablet ? 56 : 72);
    double subtitleFontSize = isMobile ? 18 : (isTablet ? 22 : 28);
    double paddingHorizontal = isMobile ? 20 : (isTablet ? 50 : 100);

    return Container(
      height: size.height - 80, // Screen height minus Navbar
      width: double.infinity,
      child: Stack(
        children: [
          // Futuristic connection network nodes background
          const Positioned.fill(
            child: BackgroundParticles(),
          ),
          
          // Radial overlay to dim the particles towards the screen edges
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    Colors.transparent,
                    AppColors.background.withOpacity(0.4),
                    AppColors.background,
                  ],
                ),
              ),
            ),
          ),

          // Main Hero Contents
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Beautiful Glowing Circular Profile Photo
                  FadeInUp(
                    delay: const Duration(milliseconds: 50),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      width: isMobile ? 120 : 150,
                      height: isMobile ? 120 : 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                          BoxShadow(
                            color: AppColors.secondary.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 2,
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.8),
                          width: 3.0,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/profile.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.surface,
                              child: const Icon(
                                Icons.person,
                                size: 60,
                                color: AppColors.textSecondary,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Little Greeting
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1.2),
                      ),
                      child: Text(
                        "👋 Namaste! I am a",
                        style: GoogleFonts.poppins(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: isMobile ? 12 : 14,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Name with neon gradient color
                  FadeInUp(
                    delay: const Duration(milliseconds: 250),
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary, Color(0xFFC084FC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        AppStrings.name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Animated Tagline
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Text(
                      AppStrings.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: subtitleFontSize,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Short intro
                  FadeInUp(
                    delay: const Duration(milliseconds: 550),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 680),
                      child: Text(
                        AppStrings.bio,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 13 : 15,
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // CTA Buttons
                  FadeInUp(
                    delay: const Duration(milliseconds: 700),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        // View Work Button (Gradient Primary)
                        HoverScaleWidget(
                          showGlow: true,
                          onTap: onViewWork,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.primary, AppColors.primaryDark],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "View My Work",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_downward_rounded, color: Colors.white, size: 16),
                              ],
                            ),
                          ),
                        ),

                        // Contact Button (Outlined Secondary)
                        HoverScaleWidget(
                          showGlow: false,
                          onTap: onContactMe,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.cardBorder, width: 1.5),
                            ),
                            child: Text(
                              "Let's Connect",
                              style: GoogleFonts.poppins(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Social Media Links
                  FadeInUp(
                    delay: const Duration(milliseconds: 850),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialIcon(
                          icon: FontAwesomeIcons.linkedinIn,
                          url: AppStrings.linkedinUrl,
                          onTap: () => _launchUrl(AppStrings.linkedinUrl),
                        ),
                        const SizedBox(width: 20),
                        _SocialIcon(
                          icon: FontAwesomeIcons.github,
                          url: AppStrings.githubUrl,
                          onTap: () => _launchUrl(AppStrings.githubUrl),
                        ),
                        const SizedBox(width: 20),
                        _SocialIcon(
                          icon: Icons.email_rounded,
                          url: "mailto:${AppStrings.email}",
                          onTap: () => _launchUrl("mailto:${AppStrings.email}"),
                        ),
                        const SizedBox(width: 20),
                        _SocialIcon(
                          icon: Icons.phone_rounded,
                          url: "tel:${AppStrings.phone}",
                          onTap: () => _launchUrl("tel:${AppStrings.phone}"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final VoidCallback onTap;

  const _SocialIcon({
    Key? key,
    required this.icon,
    required this.url,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered ? AppColors.primary : AppColors.cardBorder,
              width: 1,
            ),
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? AppColors.primary : AppColors.textSecondary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
