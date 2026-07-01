import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';
import '../utils/responsive.dart';
import 'animated_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({Key? key}) : super(key: key);

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
                  "Skills & Expertise",
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.textPrimary,
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.bold,
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
          const SizedBox(height: 16),
          FadeInUp(
            delay: const Duration(milliseconds: 100),
            child: Text(
              "Tools and technologies I use to build premium mobile & web applications",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: isMobile ? 12 : 14,
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Skills Category Layout: Grid-like layout
          Responsive(
            desktop: _buildDesktopGrid(context),
            tablet: _buildTabletLayout(context),
            mobile: _buildMobileLayout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCategoryCard(skillsCategoriesList[0])),
            const SizedBox(width: 24),
            Expanded(child: _buildCategoryCard(skillsCategoriesList[1])),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCategoryCard(skillsCategoriesList[2])),
            const SizedBox(width: 24),
            Expanded(child: _buildCategoryCard(skillsCategoriesList[3])),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCategoryCard(skillsCategoriesList[4])),
            const SizedBox(width: 24),
            const Expanded(child: SizedBox()), // Empty spacing spacer
          ],
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCategoryCard(skillsCategoriesList[0])),
            const SizedBox(width: 20),
            Expanded(child: _buildCategoryCard(skillsCategoriesList[1])),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCategoryCard(skillsCategoriesList[2])),
            const SizedBox(width: 20),
            Expanded(child: _buildCategoryCard(skillsCategoriesList[3])),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCategoryCard(skillsCategoriesList[4])),
            const SizedBox(width: 20),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: skillsCategoriesList.map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: _buildCategoryCard(category),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryCard(SkillCategory category) {
    return FadeInUp(
      delay: const Duration(milliseconds: 150),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Title
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    category.name,
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: AppColors.cardBorder, height: 1),
            const SizedBox(height: 20),

            // Chips Grid
            Wrap(
              spacing: 10,
              runSpacing: 12,
              children: category.skills.map((skill) {
                return _SkillChip(name: skill);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String name;

  const _SkillChip({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.primary.withOpacity(0.08) : AppColors.background.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? AppColors.primary : AppColors.cardBorder,
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.15),
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ]
              : [],
        ),
        child: Text(
          widget.name,
          style: GoogleFonts.poppins(
            color: _isHovered ? AppColors.primary : AppColors.textPrimary.withOpacity(0.9),
            fontSize: 12,
            fontWeight: _isHovered ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
