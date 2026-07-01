import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/constants.dart';
import '../utils/responsive.dart';
import '../widgets/animated_widgets.dart';

// Sections components imported using correct relative paths
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/education_section.dart';
import '../widgets/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  
  // Keys to reference the sections for smooth scrolling
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  double _scrollProgress = 0.0;
  String _activeSection = "Home";

  final List<Map<String, dynamic>> _navigationItems = [];

  @override
  void initState() {
    super.initState();
    
    _navigationItems.addAll([
      {"title": "Home", "key": _heroKey},
      {"title": "About", "key": _aboutKey},
      {"title": "Skills", "key": _skillsKey},
      {"title": "Experience", "key": _experienceKey},
      {"title": "Projects", "key": _projectsKey},
      {"title": "Education", "key": _educationKey},
      {"title": "Contact", "key": _contactKey},
    ]);

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // 1. Progress Bar Update
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      setState(() {
        _scrollProgress = maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 0.0;
      });
    }

    // 2. Active Section Highlight Tracking
    double minDistance = double.infinity;
    String closestSection = "Home";

    for (var item in _navigationItems) {
      final key = item["key"] as GlobalKey;
      final title = item["title"] as String;
      
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          // Offset relative to viewport top
          final yOffset = position.dy.abs();
          if (yOffset < minDistance) {
            minDistance = yOffset;
            closestSection = title;
          }
        }
      }
    }

    if (closestSection != _activeSection) {
      setState(() {
        _activeSection = closestSection;
      });
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      // Find position
      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        // Since ScrollController animateTo is absolute offset on the Scrollable view:
        final offset = box.localToGlobal(Offset.zero);
        final currentScrollOffset = _scrollController.offset;
        // Scroll offset relative to navbar height
        final targetOffset = currentScrollOffset + offset.dy - 80.0;
        
        _scrollController.animateTo(
          targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    }
  }

  Future<void> _launchResume() async {
    // Standard mock redirect for CV download, can be changed to actual link
    final String mailto = "mailto:${AppStrings.email}?subject=Request for CV - Ranbir Saini";
    final uri = Uri.parse(mailto);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: _buildNavbar(isMobile),
      ),
      drawer: isMobile ? _buildMobileDrawer() : null,
      body: Stack(
        children: [
          // Single Page Scroll Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // 1. Hero
                Container(key: _heroKey, child: HeroSection(
                  onViewWork: () => _scrollToSection(_projectsKey),
                  onContactMe: () => _scrollToSection(_contactKey),
                )),
                
                // Divider glow decoration
                _buildSectionSeparator(),

                // 2. About
                Container(key: _aboutKey, child: const AboutSection()),

                _buildSectionSeparator(),

                // 3. Skills
                Container(key: _skillsKey, child: const SkillsSection()),

                _buildSectionSeparator(),

                // 4. Experience
                Container(key: _experienceKey, child: const ExperienceSection()),

                _buildSectionSeparator(),

                // 5. Projects
                Container(key: _projectsKey, child: const ProjectsSection()),

                _buildSectionSeparator(),

                // 6. Education
                Container(key: _educationKey, child: const EducationSection()),

                _buildSectionSeparator(),

                // 7. Contact
                Container(key: _contactKey, child: const ContactSection()),

                // 8. Footer
                _buildFooter(isMobile),
              ],
            ),
          ),

          // Scroll Progress Bar on top edge of body
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 3,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _scrollProgress,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Center(
        child: Container(
          width: 80,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, AppColors.primary.withOpacity(0.5), Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavbar(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.85),
        border: const Border(
          bottom: BorderSide(color: AppColors.cardBorder, width: 0.8),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Brand Logo
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1),
                ),
                child: Text(
                  "RS",
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                AppStrings.name,
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),

          // Desktop Navigation Tabs
          if (!isMobile)
            Row(
              children: [
                ..._navigationItems.map((item) {
                  final title = item["title"] as String;
                  final key = item["key"] as GlobalKey;
                  final isActive = _activeSection == title;

                  return _NavbarItem(
                    title: title,
                    isActive: isActive,
                    onTap: () => _scrollToSection(key),
                  );
                }).toList(),
                const SizedBox(width: 16),
                
                // Contact / Resume Call to action
                HoverScaleWidget(
                  showGlow: false,
                  onTap: _launchResume,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary, width: 1.2),
                    ),
                    child: Text(
                      "Resume Request",
                      style: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            // Hamburger menu for mobile drawer
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu_rounded, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              }
            ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header Logo
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                    ),
                    child: Text(
                      "RS",
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    AppStrings.name,
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.cardBorder, height: 1),
            const SizedBox(height: 16),

            // Navigation Links
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: _navigationItems.map((item) {
                  final title = item["title"] as String;
                  final key = item["key"] as GlobalKey;
                  final isActive = _activeSection == title;

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    tileColor: isActive ? AppColors.surface : Colors.transparent,
                    leading: Icon(
                      _getIconForSection(title),
                      color: isActive ? AppColors.primary : AppColors.textSecondary,
                      size: 18,
                    ),
                    title: Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: isActive ? Colors.white : AppColors.textSecondary,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context); // Close Drawer
                      _scrollToSection(key);
                    },
                  );
                }).toList(),
              ),
            ),
            
            // Drawer Footer / Resume request
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: HoverScaleWidget(
                showGlow: false,
                onTap: () {
                  Navigator.pop(context);
                  _launchResume();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primary, width: 1.2),
                  ),
                  child: Center(
                    child: Text(
                      "Request CV (Email)",
                      style: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForSection(String sectionName) {
    switch (sectionName) {
      case "Home":
        return Icons.home_rounded;
      case "About":
        return Icons.person_rounded;
      case "Skills":
        return Icons.code_rounded;
      case "Experience":
        return Icons.work_rounded;
      case "Projects":
        return Icons.folder_shared_rounded;
      case "Education":
        return Icons.school_rounded;
      case "Contact":
        return Icons.email_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  Widget _buildFooter(bool isMobile) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF0B0F19), // Darker slate
        border: Border(
          top: BorderSide(color: AppColors.cardBorder, width: 0.8),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Built with ",
                style: GoogleFonts.poppins(color: AppColors.textSecondary, fontSize: 13),
              ),
              const Icon(Icons.favorite_rounded, color: Colors.redAccent, size: 14),
              Text(
                " using Flutter Web",
                style: GoogleFonts.poppins(color: AppColors.textSecondary, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "© 2026 Ranbir Saini. All Rights Reserved.",
            style: GoogleFonts.poppins(color: AppColors.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _NavbarItem extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavbarItem({
    Key? key,
    required this.title,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<_NavbarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  color: widget.isActive
                      ? AppColors.primary
                      : (_isHovered ? Colors.white : AppColors.textSecondary),
                  fontWeight: widget.isActive ? FontWeight.bold : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              // Floating animated underline indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive ? 20 : (_isHovered ? 12 : 0),
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}