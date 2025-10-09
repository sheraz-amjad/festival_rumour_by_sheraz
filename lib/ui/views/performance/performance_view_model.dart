import 'package:flutter/material.dart';
import '../../../core/viewmodels/base_view_model.dart';
import 'performance_view.dart';

class PerformanceViewModel extends BaseViewModel {
  List<PerformanceCategory> _performanceCategories = [];
  bool _showPerformancePreview = false;

  List<PerformanceCategory> get performanceCategories => _performanceCategories;
  bool get showPerformancePreview => _showPerformancePreview;

  @override
  void init() {
    super.init();
    _loadPerformanceCategories();
  }

  void _loadPerformanceCategories() {
    _performanceCategories = [
      PerformanceCategory(
        name: 'Music Concerts',
        description: 'Live music performances',
        icon: Icons.music_note,
      ),
      PerformanceCategory(
        name: 'Sports And Games',
        description: 'Sports activities and games',
        icon: Icons.sports_soccer,
      ),
      PerformanceCategory(
        name: 'Exhibitions And Art Displays',
        description: 'Art exhibitions and displays',
        icon: Icons.palette,
      ),
      PerformanceCategory(
        name: 'Cultural Performances',
        description: 'Traditional cultural performances',
        icon: Icons.theater_comedy,
      ),
    ];
    notifyListeners();
  }

  void addPerformanceCategory(PerformanceCategory category) {
    _performanceCategories.add(category);
    notifyListeners();
  }

  void removePerformanceCategory(int index) {
    if (index >= 0 && index < _performanceCategories.length) {
      _performanceCategories.removeAt(index);
      notifyListeners();
    }
  }

  void set showPerformancePreview(bool value) {
    _showPerformancePreview = value;
    notifyListeners();
  }
}
