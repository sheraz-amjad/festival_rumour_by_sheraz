import '../../../core/viewmodels/base_view_model.dart';
import 'event_view.dart';

class EventViewModel extends BaseViewModel {
  List<EventCategory> _eventCategories = [];
  bool _showEventPreview = false;

  List<EventCategory> get eventCategories => _eventCategories;
  bool get showEventPreview => _showEventPreview;

  @override
  void init() {
    super.init();
    _loadEventCategories();
  }

  void _loadEventCategories() {
    _eventCategories = [
      EventCategory(
        name: 'Workshops & Talks',
        description: 'Educational workshops and speaker sessions',
      ),
      EventCategory(
        name: 'Film Screenings',
        description: 'Movie and documentary screenings',
      ),
      EventCategory(
        name: 'Art Installations',
        description: 'Interactive art displays and exhibitions',
      ),
      EventCategory(
        name: 'Charity & Community Events',
        description: 'Community service and charity activities',
      ),
      EventCategory(
        name: 'Music Performances',
        description: 'Live music and entertainment shows',
      ),
    ];
    notifyListeners();
  }

  void addEventCategory(EventCategory category) {
    _eventCategories.add(category);
    notifyListeners();
  }

  void removeEventCategory(int index) {
    if (index >= 0 && index < _eventCategories.length) {
      _eventCategories.removeAt(index);
      notifyListeners();
    }
  }

  void set showEventPreview(bool value) {
    _showEventPreview = value;
    notifyListeners();
  }
}
