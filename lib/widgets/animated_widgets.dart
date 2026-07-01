import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/constants.dart';

/// A widget that scales up and adds a glow effect when hovered.
class HoverScaleWidget extends StatefulWidget {
  final Widget child;
  final double scaleFactor;
  final Duration duration;
  final bool showGlow;
  final VoidCallback? onTap;

  const HoverScaleWidget({
    Key? key,
    required this.child,
    this.scaleFactor = 1.04,
    this.duration = const Duration(milliseconds: 200),
    this.showGlow = true,
    this.onTap,
  }) : super(key: key);

  @override
  State<HoverScaleWidget> createState() => _HoverScaleWidgetState();
}

class _HoverScaleWidgetState extends State<HoverScaleWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? widget.scaleFactor : 1.0,
          duration: widget.duration,
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: widget.duration,
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: _isHovered && widget.showGlow
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.25),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// An animation wrapper that slides up and fades in its child.
class FadeInUp extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double slideOffset;

  const FadeInUp({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.slideOffset = 40.0,
  }) : super(key: key);

  @override
  State<FadeInUp> createState() => _FadeInUpState();
}

class _FadeInUpState extends State<FadeInUp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<double>(begin: widget.slideOffset, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0.0, _slideAnimation.value),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// An animated background with floating nodes and lines, simulating socket/network connections.
class BackgroundParticles extends StatefulWidget {
  const BackgroundParticles({Key? key}) : super(key: key);

  @override
  State<BackgroundParticles> createState() => _BackgroundParticlesState();
}

class _BackgroundParticlesState extends State<BackgroundParticles> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final int _particleCount = 25;
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Initialize particles
    for (int i = 0; i < _particleCount; i++) {
      _particles.add(
        _Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          radius: _random.nextDouble() * 2.5 + 1.0,
          vx: (_random.nextDouble() - 0.5) * 0.015,
          vy: (_random.nextDouble() - 0.5) * 0.015,
          opacity: _random.nextDouble() * 0.4 + 0.1,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        for (var p in _particles) {
          p.update();
        }
        return CustomPaint(
          painter: _ParticlePainter(_particles),
          child: Container(),
        );
      },
    );
  }
}

class _Particle {
  double x;
  double y;
  double radius;
  double vx;
  double vy;
  double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.vx,
    required this.vy,
    required this.opacity,
  });

  void update() {
    x += vx;
    y += vy;

    // Boundary bounce/wrap
    if (x < 0) x = 1.0;
    if (x > 1.0) x = 0.0;
    if (y < 0) y = 1.0;
    if (y > 1.0) y = 0.0;
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;

  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;

    // Draw lines between close particles
    for (int i = 0; i < particles.length; i++) {
      final p1 = particles[i];
      final p1X = p1.x * size.width;
      final p1Y = p1.y * size.height;

      for (int j = i + 1; j < particles.length; j++) {
        final p2 = particles[j];
        final p2X = p2.x * size.width;
        final p2Y = p2.y * size.height;

        final dist = math.sqrt(math.pow(p1X - p2X, 2) + math.pow(p1Y - p2Y, 2));
        final maxDist = size.width * 0.15;

        if (dist < maxDist) {
          final alpha = (1.0 - (dist / maxDist)) * 0.08;
          linePaint.color = AppColors.primary.withOpacity(alpha);
          canvas.drawLine(Offset(p1X, p1Y), Offset(p2X, p2Y), linePaint);
        }
      }
    }

    // Draw particles
    for (var p in particles) {
      paint.color = AppColors.primary.withOpacity(p.opacity);
      canvas.drawCircle(Offset(p.x * size.width, p.y * size.height), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// A standard Play Store / App Store Badge Button with animation and click handler.
class StoreBadgeButton extends StatefulWidget {
  final String url;
  final bool isPlayStore;

  const StoreBadgeButton({
    Key? key,
    required this.url,
    required this.isPlayStore,
  }) : super(key: key);

  @override
  State<StoreBadgeButton> createState() => _StoreBadgeButtonState();
}

class _StoreBadgeButtonState extends State<StoreBadgeButton> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered ? AppColors.primary : AppColors.cardBorder,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.isPlayStore ? FontAwesomeIcons.googlePlay : FontAwesomeIcons.apple,
                color: _isHovered ? AppColors.primary : AppColors.textSecondary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                widget.isPlayStore ? "Play Store" : "App Store",
                style: TextStyle(
                  color: _isHovered ? AppColors.primary : AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
