import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../theme/app_colors.dart';

/// Styled placeholder for the JSL sign video recorded with HLID.
/// Shows the sign video when [videoPath] is provided.
class SignVideoPlaceholder extends StatefulWidget {
  final String? videoPath;

  const SignVideoPlaceholder({
    super.key,
    this.videoPath,
  });

  @override
  State<SignVideoPlaceholder> createState() => _SignVideoPlaceholderState();
}

class _SignVideoPlaceholderState extends State<SignVideoPlaceholder> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.videoPath != null) {
      _initVideo(widget.videoPath!);
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
        playedColor: AppColors.ink,
        handleColor: AppColors.ink,
        bufferedColor: AppColors.ink.withValues(alpha: 0.3),
        backgroundColor: AppColors.border,
      ),
      placeholder: Container(
        color: AppColors.ink.withValues(alpha: 0.05),
      ),
    );

    if (mounted) {
      setState(() => _initialized = true);
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videoPath == null) {
      return const _SignVideoPlaceholderStatic();
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.ink.withValues(alpha: 0.25),
          width: 1.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: _initialized && _chewieController != null
          ? Chewie(controller: _chewieController!)
          : Center(
        child: CircularProgressIndicator(
          color: AppColors.ink,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

// ── Static placeholder (no asset yet) ────────────────────────────────────────

class _SignVideoPlaceholderStatic extends StatelessWidget {
  const _SignVideoPlaceholderStatic();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.ink.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.ink.withValues(alpha: 0.25),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ink.withValues(alpha: 0.10),
              border: Border.all(
                color: AppColors.ink.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.sign_language_rounded,
              color: AppColors.ink,
              size: 34,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'JSL Sign Video',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'فيديو الإشارة',
            textDirection: TextDirection.rtl,
            style: GoogleFonts.tajawal(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.ink.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.ink.withValues(alpha: 0.25),
              ),
            ),
            child: Text(
              'Recorded with HLID',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}