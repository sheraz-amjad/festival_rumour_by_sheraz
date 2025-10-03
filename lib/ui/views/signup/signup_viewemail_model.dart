import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';

class SignupViewEmailModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void goToOtp() {
    _navigationService.navigateTo(AppRoutes.signup);
  }
}
