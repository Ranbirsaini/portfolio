import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';
import '../utils/responsive.dart';
import 'animated_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({Key? key}) : super(key: key);

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
                  "Work Experience",
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
              "My professional journey as a Flutter Developer",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: isMobile ? 12 : 14,
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Timeline layout
          isMobile
              ? _buildMobileTimeline()
              : _buildDesktopTimeline(context),
        ],
      ),
    );
  }

  Widget _buildMobileTimeline() {
    return Column(
      children: experienceList.map((exp) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: _ExperienceCard(experience: exp),
        );
      }).toList(),
    );
  }

  Widget _buildDesktopTimeline(BuildContext context) {
    return Stack(
      children: [
        // Center Line of Timeline
        Positioned(
          top: 30,
          bottom: 30,
          left: 50,
          child: Container(
            width: 2,
            color: AppColors.cardBorder,
          ),
        ),

        // List of entries
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: experienceList.length,
          itemBuilder: (context, index) {
            final exp = experienceList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline Node (Dot)
                  SizedBox(
                    width: 102,
                    child: Center(
                      child: _TimelineNode(index: index),
                    ),
                  ),
                  
                  // Experience Details Card
                  Expanded(
                    child: _ExperienceCard(experience: exp),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _TimelineNode extends StatefulWidget {
  final int index;

  const _TimelineNode({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<_TimelineNode> createState() => _TimelineNodeState();
}

class _TimelineNodeState extends State<_TimelineNode> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _isHovered ? 24 : 16,
        height: _isHovered ? 24 : 16,
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.primary : AppColors.background,
          shape: BoxShape.circle,
          border: Border.all(
            color: _isHovered ? Colors.white : AppColors.primary,
            width: _isHovered ? 4 : 3,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.5),
                    blurRadius: 12,
                    spreadRadius: 3,
                  )
                ]
              : [],
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final ExperienceData experience;

  const _ExperienceCard({
    Key? key,
    required this.experience,
  }) : super(key: key);

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: HoverScaleWidget(
        showGlow: true,
        scaleFactor: 1.015,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? AppColors.primary.withOpacity(0.7) : AppColors.cardBorder,
              width: 1.2,
            ),
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
              // Company & Duration row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.experience.role,
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.experience.company,
                          style: GoogleFonts.poppins(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.experience.location,
                          style: GoogleFonts.poppins(
                            color: AppColors.textMuted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Duration Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 1),
                    ),
                    child: Text(
                      widget.experience.duration,
                      style: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: AppColors.cardBorder, height: 1),
              const SizedBox(height: 16),

              // Highlights List
              Column(
                children: widget.experience.highlights.map((bullet) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Icon(
                            Icons.arrow_right_rounded,
                            color: AppColors.primary,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            bullet,
                            style: GoogleFonts.poppins(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
