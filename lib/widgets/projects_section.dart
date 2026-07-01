import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';
import '../utils/responsive.dart';
import 'animated_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    
    double sectionPadding = isMobile ? 24.0 : 48.0;
    int crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

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
                  "Key Projects",
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
              "Here are some of the major Android & iOS apps I designed and developed",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: isMobile ? 12 : 14,
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Responsive grid layout using Column/Row flow to prevent layout constraints issues
          _buildResponsiveGrid(context, crossAxisCount),
        ],
      ),
    );
  }

  Widget _buildResponsiveGrid(BuildContext context, int columns) {
    List<Widget> rows = [];
    List<Widget> currentRow = [];

    for (int i = 0; i < projectsList.length; i++) {
      currentRow.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _ProjectCard(project: projectsList[i]),
          ),
        ),
      );

      if ((i + 1) % columns == 0 || i == projectsList.length - 1) {
        // If row is not full, pad it with empty Expanded widgets
        if (currentRow.length < columns) {
          int missing = columns - currentRow.length;
          for (int k = 0; k < missing; k++) {
            currentRow.add(const Expanded(child: SizedBox()));
          }
        }
        rows.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.from(currentRow),
          ),
        );
        currentRow.clear();
      }
    }

    return Column(
      children: rows,
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectData project;

  const _ProjectCard({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: HoverScaleWidget(
        showGlow: true,
        scaleFactor: 1.03,
        child: Container(
          height: 380, // Fixed height to keep grids aligned
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? AppColors.primary : AppColors.cardBorder,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & Folder Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.folder_open_rounded,
                    color: AppColors.primary,
                    size: 32,
                  ),
                  Row(
                    children: [
                      if (widget.project.playStoreUrl != null)
                         Padding(
                          padding: EdgeInsets.only(left: 6.0),
                          child: Icon(Icons.android, color: Colors.amber, size: 18),
                        ),
                      if (widget.project.appStoreUrl != null)
                        const Padding(
                          padding: EdgeInsets.only(left: 6.0),
                          child: Icon(Icons.apple, color: Colors.white70, size: 18),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                widget.project.title,
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Description (takes maximum remaining space)
              Expanded(
                child: Text(
                  widget.project.description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondary,
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Tech stack tags
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.project.techStack.take(3).map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.cardBorder, width: 0.8),
                    ),
                    child: Text(
                      tech,
                      style: GoogleFonts.poppins(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Divider(color: AppColors.cardBorder, height: 1),
              const SizedBox(height: 16),

              // App Store / Google Play links
              Row(
                children: [
                  if (widget.project.playStoreUrl != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: StoreBadgeButton(
                          url: widget.project.playStoreUrl!,
                          isPlayStore: true,
                        ),
                      ),
                    ),
                  if (widget.project.appStoreUrl != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: StoreBadgeButton(
                          url: widget.project.appStoreUrl!,
                          isPlayStore: false,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
