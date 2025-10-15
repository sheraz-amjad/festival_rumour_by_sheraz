import 'package:festival_rumour/ui/views/username/username_view.dart';
import 'package:flutter/material.dart';
import '../../ui/views/signup/signupphone/signup_view.dart';
import '../constants/app_strings.dart';
import '../../ui/views/Profile/profile_view.dart';
import '../../ui/views/Profile/profilelist/profile_list_view.dart';
import '../../ui/views/Splash/SplashView.dart';
import '../../ui/views/chat/chat_view.dart';
import '../../ui/views/comment/comment_view.dart';
import '../../ui/views/detail/detail_view.dart';
import '../../ui/views/discover/discover_view.dart';
import '../../ui/views/event/event_view.dart';
import '../../ui/views/festival/festival_view.dart';
import '../../ui/views/homeview/home_view.dart';
import '../../ui/views/interest/interests_view.dart';
import '../../ui/views/job/festivals_job_view.dart';
import '../../ui/views/name/name_view.dart';
import '../../ui/views/navbar/navbaar.dart';
import '../../ui/views/news/news_view.dart';
import '../../ui/views/notification/notification_view.dart';
import '../../ui/views/otp/otp_view.dart';
import '../../ui/views/performance/performance_view.dart';
import '../../ui/views/toilet/toilet_view.dart';
import '../../ui/views/uploadphotos/upload_photos_view.dart';
import '../../ui/views/welcome/welcome_view.dart';
import '../../ui/views/signup/signupemail/signup_viewemail.dart';
import '../../ui/views/map/map_view.dart';
import '../../ui/views/subscription/subscription_view.dart';
import '../../ui/views/settings/settings_view.dart';
import '../../ui/views/leaderboard/leaderboard_view.dart';
import '../../ui/views/posts/posts_view.dart';
import '../../ui/views/chat/chat_room_view.dart';
import '../../ui/views/chat/create_chat_room_view.dart';
import '../utils/transition.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String signup = '/signup';
  static const String signupEmail = '/signup_email';
  static const String uploadphotos = '/uploadphotos';
  static const String name = '/name';
  static const String otp = '/otp';
  static const String splash = '/splash';
  static const String interest = '/interest';
  static const String home = '/home';
  static const String navbaar = '/navbaar';
  static const String festivals = '/festivals';
  static const String subscription = '/subscription';
  static const String chat = '/chat';
  static const String map = '/map';
  static const String notification = '/notification';
  static const String settings = '/settings';
  static const String leaderboard = '/leaderboard';
  static const String comments = '/comments';
  static const String profileList = '/profileList';
  static const String username = '/username';
  static const String profile = '/profile';
  static const String festivalsJob = '/festivals_job';
  static const String discover = '/discover';
  static const String posts = '/posts';
  static const String detail = '/detail';
  static const String chatRoom = '/chat_room';
  static const String createChatRoom = '/create_chat_room';
  static const String toilets = '/toilets';
  static const String performance = '/performance';
  static const String event = '/event';
  static const String news = '/news';
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.welcome:
      return SmoothPageRoute(page: const WelcomeView());

    case AppRoutes.splash:
      return SmoothPageRoute(page: const SplashView());


    case AppRoutes.signup:
      return SmoothPageRoute(page: const SignupView());

    case AppRoutes.signupEmail:
      return SmoothPageRoute(page: const SignupViewEmail());

    case AppRoutes.uploadphotos:
      return SmoothPageRoute(page: const UploadPhotosViews());

    case AppRoutes.name:
      return SmoothPageRoute(page: const NameView());

      case AppRoutes.festivals:
       // final args = settings.arguments as List<dynamic>;
        return SmoothPageRoute(page: const FestivalView());


    case AppRoutes.otp:
      return SmoothPageRoute(page: const OtpView());

    case AppRoutes.interest:
      return SmoothPageRoute(page: const InterestsView());

    case AppRoutes.home:
      return SmoothPageRoute(page: const HomeView());

    case AppRoutes.navbaar:
      return SmoothPageRoute(page: const NavBaar());

    case AppRoutes.subscription:
      return SmoothPageRoute(page: const SubscriptionView());

    case AppRoutes.chat:
      return SmoothPageRoute(page: const ChatView());


    case AppRoutes.map:
      return SmoothPageRoute(page: const MapView());

    case AppRoutes.notification:
      return SmoothPageRoute(page: const NotificationView());

    case AppRoutes.settings:
      return SmoothPageRoute(page: const SettingsView());

    case AppRoutes.leaderboard:
      return SmoothPageRoute(page: const LeaderboardView());

      case AppRoutes.comments:
      return SmoothPageRoute(page: const CommentView());

    case AppRoutes.discover:
      return SmoothPageRoute(page: const DiscoverView());
      case AppRoutes.username:
        return SmoothPageRoute(page: const UsernameView());
        case AppRoutes.festivalsJob:
      return SmoothPageRoute(page: const FestivalsJobView());

    case AppRoutes.profile:
      return SmoothPageRoute(page: ProfileView());

      case AppRoutes.profileList:
        final args = settings.arguments as int? ?? 0;
            return SmoothPageRoute(page: ProfileListView(initialTab: args,username: 'username',));

    case AppRoutes.posts:
      return SmoothPageRoute(page: const PostsView());

      case AppRoutes.detail:
      return SmoothPageRoute(page: const DetailView());

    case AppRoutes.chatRoom:
      return SmoothPageRoute(page: const ChatRoomView());

    case AppRoutes.createChatRoom:
      return SmoothPageRoute(page: const CreateChatRoomView());

      case AppRoutes.toilets:
      return SmoothPageRoute(page: const ToiletView());

      case AppRoutes.performance:
      return SmoothPageRoute(page: const PerformanceView());

      case AppRoutes.event:
      return SmoothPageRoute(page: const EventView());

      case AppRoutes.news:
      return SmoothPageRoute(page: const NewsView());

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text(AppStrings.pageNotFound)),
        ),
      );
  }
}
