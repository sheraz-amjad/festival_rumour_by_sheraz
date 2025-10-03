import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/viewmodels/base_view_model.dart';
import '../../../core/di/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/router/app_router.dart';

class UploadPhotosViewModel extends BaseViewModel {
  final ImagePicker _picker = ImagePicker();
  final NavigationService _navigationService = locator<NavigationService>();

  File? selectedImage;

  /// Getter to check if image is picked
  bool get hasImage => selectedImage != null;

  /// Pick image from gallery
  Future<void> pickImageFromGallery() async {
    await handleAsync(() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        notifyListeners();
      }
    }, errorMessage: AppStrings.failtouploadimage);
}

  /// Pick image from camera
  Future<void> pickImageFromCamera() async {
    await handleAsync(() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        notifyListeners();
      }
    }, errorMessage: AppStrings.failedtotakephoto);
  }

  /// Reset image
  void clearImage() {
    selectedImage = null;
    notifyListeners();
  }

  /// Continue to next screen
  Future<void> continueToNext() async {
    await handleAsync(() async {
      // Simulate uploading image
      await Future.delayed(const Duration(seconds: 1));

      // Navigate to next screen
      _navigationService.navigateTo(AppRoutes.interest);
    }, errorMessage: AppStrings.faildtocontiue);
  }

  /// Skip photo upload
  Future<void> skipPhotoUpload() async {
    await handleAsync(() async {
      // Navigate to next screen without uploading
      _navigationService.navigateTo(AppRoutes.interest);
    }, errorMessage: AppStrings.faildtocontiue);
  }
}
