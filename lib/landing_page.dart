import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Color & style constants (mirrors the :root CSS variables)
// ---------------------------------------------------------------------------
class AppColors {
  static const green = Color(0xFF7ED321);
  static const greenDark = Color(0xFF6AB818);
  static const greenLight = Color(0xFFF0FADA);
  static const greenGlow = Color(0x2E7ED321); // rgba(126,211,33,0.18)
  static const greenShadow = Color(0x477ED321); // rgba(126,211,33,0.28)
  static const textDark = Color(0xFF0F1A00);
  static const textMid = Color(0xFF3A3A3A);
  static const textSoft = Color(0xFF6B7280);
  static const white = Color(0xFFFFFFFF);
  static const bg = Color(0xFFF7FAF2);
  static const cardBg = Color(0xFFFFFFFF);
  static const border = Color(0x1F7ED321); // rgba(126,211,33,0.12)
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Background decorative blobs (fixed, behind everything)
          const _BackgroundBlobs(),

          // Scrollable foreground content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: const _PageContent(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Background blobs (.bg-blob-1/2/3)
// ---------------------------------------------------------------------------
class _BackgroundBlobs extends StatelessWidget {
  const _BackgroundBlobs();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          // bg-blob-1 : top-left
          Positioned(
            top: -120,
            left: -120,
            child: _RingBlob(
              size: 420,
              borderWidth: 48,
              color: AppColors.green.withOpacity(0.07),
            ),
          ),
          // bg-blob-2 : bottom-right
          Positioned(
            bottom: -80,
            right: -80,
            child: _RingBlob(
              size: 320,
              borderWidth: 36,
              color: AppColors.green.withOpacity(0.07),
            ),
          ),
          // bg-blob-3 : mid-right
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            right: 0,
            child: _RingBlob(
              size: 200,
              borderWidth: 22,
              color: AppColors.green.withOpacity(0.05),
            ),
          ),
        ],
      ),
    );
  }
}

class _RingBlob extends StatelessWidget {
  final double size;
  final double borderWidth;
  final Color color;

  const _RingBlob({
    required this.size,
    required this.borderWidth,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: borderWidth),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page content
// ---------------------------------------------------------------------------
class _PageContent extends StatelessWidget {
  const _PageContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          SizedBox(height: 22),
          _NavBar(),
          SizedBox(height: 38),
          _HeroSection(),
          SizedBox(height: 32),
          _StatsStrip(),
          SizedBox(height: 28),
          _FeaturesSection(),
          SizedBox(height: 24),
          _BottomCta(),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Navbar
// ---------------------------------------------------------------------------
class _NavBar extends StatelessWidget {
  const _NavBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PRIDE',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: AppColors.green,
                letterSpacing: 4,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'PAKISTAN RIDE',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                letterSpacing: 3,
                color: AppColors.textSoft,
                height: 1.0,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.greenLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Text(
            '🇵🇰 Available Now',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.greenDark,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Hero section
// ---------------------------------------------------------------------------
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 560;
        final logo = const _LogoCard();
        final left = const _HeroLeft();

        if (isNarrow) {
          // Stack vertically on very small screens, logo first like flex layout would wrap
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              left,
              const SizedBox(height: 24),
              Center(child: logo),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 3, child: left),
            const SizedBox(width: 20),
            logo,
          ],
        );
      },
    );
  }
}

class _HeroLeft extends StatelessWidget {
  const _HeroLeft();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // eyebrow
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.greenLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.green.withOpacity(0.25),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "Pakistan's Ride Platform",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greenDark,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // hero title
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
              height: 1.1,
              letterSpacing: -0.5,
            ),
            children: const [
              TextSpan(text: 'Ride With\n'),
              TextSpan(
                text: 'Pride.',
                style: TextStyle(color: AppColors.green),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        // hero desc
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Text(
            'Safe, reliable, and affordable rides across Pakistan. '
            'Choose how you want to continue.',
            style: TextStyle(
              fontSize: 13,
              height: 1.65,
              color: AppColors.textSoft,
            ),
          ),
        ),
        const SizedBox(height: 28),
        // hero actions
        Wrap(
          spacing: 14,
          runSpacing: 14,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _PrimaryButton(
              label: 'Get Started',
              onPressed: () {
                // Equivalent of window.location.href = 'choose.html'
                Navigator.of(context).pushNamed('/choose');
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 7),
                Text(
                  'Verified drivers only',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSoft,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _PrimaryButton({required this.label, required this.onPressed});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? const Color(0x6E7ED321) // 0.38
                  : AppColors.greenShadow,
              blurRadius: _hovered ? 36 : 28,
              offset: Offset(0, _hovered ? 14 : 8),
            ),
          ],
        ),
        child: Material(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: widget.onPressed,
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 28),
              alignment: Alignment.center,
              child: Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoCard extends StatelessWidget {
  const _LogoCard();

  @override
  Widget build(BuildContext context) {
    const double cardSize = 168;
    return SizedBox(
      width: cardSize + 32,
      height: cardSize + 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // logo-glow
          Container(
            width: cardSize + 32,
            height: cardSize + 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.greenGlow,
                  Colors.transparent,
                ],
                stops: [0.0, 0.7],
              ),
            ),
          ),
          // logo-card
          Container(
            width: cardSize,
            height: cardSize,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 40,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: AppColors.green.withOpacity(0.1),
                  blurRadius: 0,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                (cardSize - 20) / 2,
              ), // circular image
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.greenLight,
                  alignment: Alignment.center,
                  child: const Text(
                    'PRIDE',
                    style: TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stats strip
// ---------------------------------------------------------------------------
class _StatsStrip extends StatelessWidget {
  const _StatsStrip();

  @override
  Widget build(BuildContext context) {
    final stats = const [
      ('50K+', 'Rides Done'),
      ('1,200+', 'Drivers'),
      ('20+', 'Cities'),
      ('4.8 ★', 'Avg Rating'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: List.generate(stats.length, (i) {
          final (num, label) = stats[i];
          final isLast = i == stats.length - 1;
          return Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : const Border(
                        right: BorderSide(color: AppColors.border, width: 1),
                      ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    num,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.green,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSoft,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Features section
// ---------------------------------------------------------------------------
class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 12.0;
        final cardWidth = (constraints.maxWidth - gap * 2) / 3;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            SizedBox(
              width: cardWidth,
              child: const _FeatureCard(
                icon: _BoltIcon(),
                title: 'Fast Booking',
                description:
                    'Book your ride in seconds with a smooth experience.',
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: const _FeatureCard(
                icon: _ShieldCheckIcon(),
                title: 'Trusted Drivers',
                description: 'Verified drivers for safer journeys.',
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: const _FeatureCard(
                icon: _PriceTagIcon(),
                title: 'Affordable Rides',
                description: 'Transparent pricing with no surprises.',
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final Widget icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovered ? 0.09 : 0.04),
              blurRadius: _hovered ? 32 : 20,
              offset: Offset(0, _hovered ? 12 : 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // top gradient accent bar, visible on hover
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _hovered ? 1 : 0,
                  child: Container(
                    height: 3,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.green, AppColors.greenDark],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.greenLight,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: widget.icon,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10.5,
                        height: 1.5,
                        color: AppColors.textSoft,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Custom painted icons matching the inline SVGs -------------------------

class _BoltIcon extends StatelessWidget {
  const _BoltIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(22, 22),
      painter: _BoltPainter(),
    );
  }
}

class _BoltPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24;
    final path = Path()
      ..moveTo(13 * scale, 2 * scale)
      ..lineTo(4.5 * scale, 13.5 * scale)
      ..lineTo(11.5 * scale, 13.5 * scale)
      ..lineTo(11 * scale, 22 * scale)
      ..lineTo(19.5 * scale, 10.5 * scale)
      ..lineTo(12.5 * scale, 10.5 * scale)
      ..close();

    final fillPaint = Paint()
      ..color = AppColors.green
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = AppColors.greenDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2 * scale
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ShieldCheckIcon extends StatelessWidget {
  const _ShieldCheckIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(22, 22),
      painter: _ShieldCheckPainter(),
    );
  }
}

class _ShieldCheckPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24;
    final shieldPath = Path()
      ..moveTo(12 * scale, 2 * scale)
      ..lineTo(3 * scale, 6 * scale)
      ..lineTo(3 * scale, 12 * scale)
      ..cubicTo(
        3 * scale,
        16.418 * scale,
        7.03 * scale,
        20.489 * scale,
        12 * scale,
        22 * scale,
      )
      ..cubicTo(
        16.97 * scale,
        20.489 * scale,
        21 * scale,
        16.418 * scale,
        21 * scale,
        12 * scale,
      )
      ..lineTo(21 * scale, 6 * scale)
      ..close();

    final fillPaint = Paint()
      ..color = AppColors.green
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = AppColors.greenDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2 * scale
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(shieldPath, fillPaint);
    canvas.drawPath(shieldPath, strokePaint);

    // checkmark
    final checkPath = Path()
      ..moveTo(8.5 * scale, 12 * scale)
      ..lineTo(10.5 * scale, 14 * scale)
      ..lineTo(15.5 * scale, 9.5 * scale);

    final checkPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8 * scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(checkPath, checkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PriceTagIcon extends StatelessWidget {
  const _PriceTagIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(22, 22),
      painter: _PriceTagPainter(),
    );
  }
}

class _PriceTagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24;

    // Tag outline (rounded approximation of the path)
    final tagPath = Path()
      ..moveTo(3 * scale, 2 * scale)
      ..lineTo(12.5 * scale, 2 * scale)
      ..cubicTo(
        13.296 * scale,
        2 * scale,
        14.059 * scale,
        2.316 * scale,
        14.621 * scale,
        2.879 * scale,
      )
      ..lineTo(21.121 * scale, 9.379 * scale)
      ..cubicTo(
        22.293 * scale,
        10.55 * scale,
        22.293 * scale,
        12.45 * scale,
        21.121 * scale,
        13.621 * scale,
      )
      ..lineTo(14.621 * scale, 20.121 * scale)
      ..cubicTo(
        13.45 * scale,
        21.293 * scale,
        11.55 * scale,
        21.293 * scale,
        10.379 * scale,
        20.121 * scale,
      )
      ..lineTo(3.879 * scale, 13.621 * scale)
      ..cubicTo(
        3.316 * scale,
        13.059 * scale,
        3 * scale,
        12.296 * scale,
        3 * scale,
        11.5 * scale,
      )
      ..lineTo(3 * scale, 6 * scale)
      ..cubicTo(
        3 * scale,
        3.791 * scale,
        4.791 * scale,
        2 * scale,
        7 * scale,
        2 * scale,
      )
      ..close();

    final fillPaint = Paint()
      ..color = AppColors.green.withOpacity(0.15)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = AppColors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5 * scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(tagPath, fillPaint);
    canvas.drawPath(tagPath, strokePaint);

    // small hole/dot
    final dotPaint = Paint()
      ..color = AppColors.green
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(7.5 * scale, 7.5 * scale),
      1.5 * scale,
      dotPaint,
    );

    // dollar/rupee "S" curve
    final sPath = Path()
      ..moveTo(10 * scale, 13.5 * scale)
      ..cubicTo(
        10 * scale,
        13.5 * scale,
        10.5 * scale,
        15 * scale,
        12 * scale,
        15 * scale,
      )
      ..cubicTo(
        13.5 * scale,
        15 * scale,
        14 * scale,
        14 * scale,
        14 * scale,
        13 * scale,
      )
      ..cubicTo(
        14 * scale,
        11.5 * scale,
        12 * scale,
        11 * scale,
        12 * scale,
        11 * scale,
      )
      ..cubicTo(
        12 * scale,
        11 * scale,
        10 * scale,
        10.5 * scale,
        10 * scale,
        9 * scale,
      )
      ..cubicTo(
        10 * scale,
        8 * scale,
        10.5 * scale,
        7 * scale,
        12 * scale,
        7 * scale,
      )
      ..cubicTo(
        13.5 * scale,
        7 * scale,
        14 * scale,
        8.5 * scale,
        14 * scale,
        8.5 * scale,
      );

    final sPaint = Paint()
      ..color = AppColors.greenDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3 * scale
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(sPath, sPaint);

    final linePaint = Paint()
      ..color = AppColors.greenDark
      ..strokeWidth = 1.3 * scale
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(12 * scale, 6 * scale),
      Offset(12 * scale, 7 * scale),
      linePaint,
    );
    canvas.drawLine(
      Offset(12 * scale, 15 * scale),
      Offset(12 * scale, 16 * scale),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Bottom CTA
// ---------------------------------------------------------------------------
class _BottomCta extends StatelessWidget {
  const _BottomCta();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 480;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.green, AppColors.greenDark],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.greenShadow,
                blurRadius: 40,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // decorative rings (::before / ::after)
              Positioned(
                top: -40,
                right: -40,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 28,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                right: 60,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.06),
                      width: 18,
                    ),
                  ),
                ),
              ),
              isNarrow
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const _CtaText(centered: true),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: _WhiteButton(
                            label: 'Choose Your Journey →',
                            onPressed: () {
                              Navigator.of(context).pushNamed('/choose');
                            },
                          ),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(child: _CtaText(centered: false)),
                        const SizedBox(width: 16),
                        _WhiteButton(
                          label: 'Choose Your Journey →',
                          onPressed: () {
                            Navigator.of(context).pushNamed('/choose');
                          },
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}

class _CtaText extends StatelessWidget {
  final bool centered;
  const _CtaText({required this.centered});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Ready to ride?\nJoin PRIDE today.',
          textAlign: centered ? TextAlign.center : TextAlign.left,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Driver or passenger — we've got you covered.",
          textAlign: centered ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

class _WhiteButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _WhiteButton({required this.label, required this.onPressed});

  @override
  State<_WhiteButton> createState() => _WhiteButtonState();
}

class _WhiteButtonState extends State<_WhiteButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovered ? 0.18 : 0.12),
              blurRadius: _hovered ? 24 : 16,
              offset: Offset(0, _hovered ? 8 : 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: widget.onPressed,
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              alignment: Alignment.center,
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.greenDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
