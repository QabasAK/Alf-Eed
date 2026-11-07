import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'liu_logo.dart';

/// Stone panel holding the logo lockup, echoing the brand board's offset
/// grey blocks.
class LogoPanel extends StatelessWidget {
  final double logoWidth;
  final LiuLogoVariant variant;
  final Color accent;

  /// Fills the offset block. Defaults to solid brand blue.
  final Widget? offsetBlock;

  const LogoPanel({
    super.key,
    required this.logoWidth,
    this.variant = LiuLogoVariant.full,
    this.accent = AppColors.blue,
    this.offsetBlock,
  });

  @override
  Widget build(BuildContext context) {
    final pad = logoWidth * 0.28;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Decorative offset block
        Positioned(
          right: -pad * 0.35,
          bottom: -pad * 0.35,
          width: pad * 1.6,
          height: pad * 1.6,
          child: offsetBlock ?? Container(color: AppColors.blue),
        ),
        Container(
          padding: EdgeInsets.all(pad),
          color: AppColors.stone,
          child: LiuLogo(width: logoWidth, variant: variant, accent: accent),
        ),
      ],
    );
  }
}
