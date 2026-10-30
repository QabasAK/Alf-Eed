import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../theme/app_colors.dart';

/// Shows a Manim animation video when [animationPath] is provided,
/// or a branded coming-soon placeholder when it is null.
class AnimationPlaceholder extends StatefulWidget {
  final String? animationPath;

  const AnimationPlaceholder({super.key, this.animationPath});

  @override
  State<AnimationPlaceholder> createState() => _AnimationPlaceholderState();
}

class _AnimationPlaceholderState extends State<AnimationPlaceholder> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.animationPath != null) {
      _initVideo(widget.animationPath!);
    }
  }

  Future<void> _initVideo(String path) async {
    final controller = VideoPlayerController.asset(path);
    _videoController = controller;
    await controller.initialize();
    _chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: false,
      looping: false,
      aspectRatio: controller.value.aspectRatio,
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors.blue,
        handleColor: AppColors.blue,
        bufferedColor: AppColors.blue.withValues(alpha: 0.3),
        backgroundColor: AppColors.border,
      ),
      placeholder: Container(color: AppColors.blue.withValues(alpha: 0.06)),
    );
    if (mounted) setState(() => _initialized = true);
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animationPath == null) return const _AnimationPlaceholderStatic();

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.blue.withValues(alpha: 0.25), width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: _initialized && _chewieController != null
          ? Chewie(controller: _chewieController!)
          : Center(
              child: CircularProgressIndicator(
                color: AppColors.blue,
                strokeWidth: 2,
              ),
            ),
    );
  }
}

// ── Static placeholder (no asset yet) ────────────────────────────────────────

class _AnimationPlaceholderStatic extends StatelessWidget {
  const _AnimationPlaceholderStatic();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.blue.withValues(alpha: 0.25), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blue.withValues(alpha: 0.12),
              border: Border.all(color: AppColors.blue.withValues(alpha: 0.35), width: 1.5),
            ),
            child: const Icon(Icons.play_circle_outline_rounded,
                color: AppColors.blue, size: 36),
          ),
          const SizedBox(height: 16),
          Text(
            'Concept Animation',
            style: GoogleFonts.inter(
                fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.blue),
          ),
          const SizedBox(height: 4),
          Text(
            'رسوم توضيحية',
            textDirection: TextDirection.rtl,
            style: GoogleFonts.tajawal(
                fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.blue),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.blue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.blue.withValues(alpha: 0.4)),
            ),
            child: Text(
              'Manim animation coming soon',
              style: GoogleFonts.inter(
                  fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
