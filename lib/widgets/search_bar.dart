import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// Bilingual search bar — searches both English and Arabic simultaneously.
class LexiconSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String initialValue;

  const LexiconSearchBar({
    super.key,
    required this.onChanged,
    this.initialValue = '',
  });

  @override
  State<LexiconSearchBar> createState() => _LexiconSearchBarState();
}

class _LexiconSearchBarState extends State<LexiconSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      style: GoogleFonts.inter(fontSize: 15, color: AppColors.textPrimary),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.blue, size: 22),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear_rounded, color: AppColors.textSecondary, size: 18),
                onPressed: () {
                  _controller.clear();
                  widget.onChanged('');
                },
              )
            : null,
        hintText: 'Search English or Arabic  •  ابحث بالإنجليزية أو العربية',
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
