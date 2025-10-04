import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';


class AppFestivals {
  static final List<Map<String, String>> festivals = [
    {
      'image': AppAssets.festivalLive,
      'title': AppStrings.eventTitle,
      'date': AppStrings.eventdate,
      'status': AppStrings.live,
    },
    {
      'image': AppAssets.festivalUpcoming,
      'title': AppStrings.eventTitle,
      'date': AppStrings.eventdate,
      'status': "Upcoming",
    },
    {
      'image': AppAssets.festivalPast,
      'title': AppStrings.eventTitle,
      'date': AppStrings.eventdate,
      'status': "Past",
    },
  ];
}
