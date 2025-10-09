import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../profile_list_view_model.dart';

class FestivalsTab extends StatefulWidget {
  final ProfileListViewModel viewModel;
  const FestivalsTab({super.key, required this.viewModel});

  @override
  State<FestivalsTab> createState() => _FestivalsTabState();
}

class _FestivalsTabState extends State<FestivalsTab> {
  final Set<int> _favoriteFestivals = {};

  void _toggleFavorite(int index) {
    setState(() {
      if (_favoriteFestivals.contains(index)) {
        _favoriteFestivals.remove(index);
      } else {
        _favoriteFestivals.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: TextField(
            style: const TextStyle(color: AppColors.primary),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              hintText: "Search festivals...",
              hintStyle: const TextStyle(color: AppColors.primary),
              prefixIcon: const Icon(Icons.search, color: AppColors.primary),
              filled: true,
              fillColor: AppColors.onPrimary.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onChanged: widget.viewModel.searchFestivals,
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: widget.viewModel.festivals.length,
            itemBuilder: (context, index) {
              final festival = widget.viewModel.festivals[index];
              final isFavorite = _favoriteFestivals.contains(index);
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.white,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.military_tech,
                        color: AppColors.accent,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            festival['title'] ?? 'Unknown Festival',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            festival['location'] ?? 'Unknown Location',
                            style: const TextStyle(
                              color: AppColors.grey600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 32,
                      width: 32,
                      margin: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () => _toggleFavorite(index),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: isFavorite ? Colors.red : AppColors.grey600,
                              width: 1,
                            ),
                          ),
                        ),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : AppColors.grey600,
                          size: 18,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.more_vert,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        // Handle more options
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
