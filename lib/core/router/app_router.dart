import 'package:festival_rumour/ui/views/homeview/post_model.dart';
import 'package:flutter/material.dart';
import '../../ui/views/Splash/SplashView.dart';
import '../../ui/views/eventscreen/event_view.dart';
import '../../ui/views/firstname/first_name_view.dart';
import '../../ui/views/homeview/home_view.dart';
import '../../ui/views/interestview/interests_view.dart';
import '../../ui/views/otp/otp_view.dart';
import '../../ui/views/uploadphotos/upload_photos_view.dart';
import '../../ui/views/welcome/welcome_view.dart';
import '../../ui/views/signup/signup_view.dart';
import '../../ui/views/signup/signup_viewemail.dart';
import '../../ui/views/main/nav_view.dart';
import '../../ui/views/chat/chat_list_view.dart';
import '../../ui/views/tickets/tickets_view.dart';
import '../../ui/views/map/map_view.dart';
import '../../ui/views/gallery/gallery_view.dart';
import '../../ui/views/news/news_view.dart';
import '../../ui/views/eventdetail/event_detail_view.dart';
import '../../ui/views/wallet/wallet_view.dart';
import '../../ui/views/menu/menu_view.dart';
import '../../ui/views/compose/compose_view.dart';
import '../../ui/views/subscription/subscription_view.dart';
import '../../ui/views/settings/settings_view.dart';
import '../../ui/views/leaderboard/leaderboard_view.dart';
import '../utils/transition.dart'; // Import the helper we made

class AppRoutes {
  static const String welcome = '/welcome';
  static const String signup = '/signup';
  static const String signupEmail = '/signup_email';
  static const String uploadphotos = '/uploadphotos';
  static const String firstname = '/firstname';
  static const String otp = '/otp';
  static const String splash = '/splash';
  static const String interest = '/interest';
  static const String home = '/home';
  static const String main = '/main';
  static const String event = '/event';
  static const String subscription = '/subscription';
  static const String chatList = '/chat_list';
  static const String tickets = '/tickets';
  static const String map = '/map';
  static const String gallery = '/gallery';
  static const String news = '/news';
  static const String eventDetail = '/event_detail';
  static const String wallet = '/wallet';
  static const String menu = '/menu';
  static const String compose = '/compose';
  static const String settings = '/settings';
  static const String leaderboard = '/leaderboard';
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

    case AppRoutes.firstname:
      return SmoothPageRoute(page: const FirstNameView());

      case AppRoutes.event:
       // final args = settings.arguments as List<dynamic>;
        return SmoothPageRoute(page: const EventView());


    case AppRoutes.otp:
      return SmoothPageRoute(page: const OtpView());
    case AppRoutes.interest:
      return SmoothPageRoute(page: const InterestsView());

    case AppRoutes.home:
      return SmoothPageRoute(page: const HomeView());

    case AppRoutes.main:
      return SmoothPageRoute(page: const NavView());

    case AppRoutes.subscription:
      return SmoothPageRoute(page: const SubscriptionView());

    case AppRoutes.chatList:
      return SmoothPageRoute(page: const ChatListView());

    case AppRoutes.tickets:
      return SmoothPageRoute(page: const TicketsView());


    case AppRoutes.map:
      return SmoothPageRoute(page: const MapView());

    case AppRoutes.gallery:
      return SmoothPageRoute(page: const GalleryView());

    case AppRoutes.news:
      return SmoothPageRoute(page: const NewsView());

    case AppRoutes.eventDetail:
      return SmoothPageRoute(page: const EventDetailView());

    case AppRoutes.wallet:
      return SmoothPageRoute(page: const WalletView());

    case AppRoutes.menu:
      return SmoothPageRoute(page: const MenuView());

    case AppRoutes.compose:
      return SmoothPageRoute(page: const ComposeView());

    case AppRoutes.settings:
      return SmoothPageRoute(page: const SettingsView());

    case AppRoutes.leaderboard:
      return SmoothPageRoute(page: const LeaderboardView());

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text("Page not found")),
        ),
      );
  }
}
