import 'package:earnwise/src/core/domain/dto/update_profile_request.dart';
import 'package:earnwise/src/core/domain/response/get_profile_response.dart';
import 'package:earnwise/src/core/repository/profile_repository.dart';
import 'package:earnwise/src/features/dashboard/screens/dashboard.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/toast_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileViewModel = ChangeNotifierProvider((ref) {
  return ProfileViewModel(ProfileRepositoryImpl());
});

class ProfileViewModel extends ChangeNotifier {
  late ProfileRepository profileRepository;

  ProfileViewModel(this.profileRepository);

  bool isLoading = false;

  GetProfileResponse? profileResponse;

  String? professionalTitle;
  String? bio;
  String? phone;
  String? location;
  String? timezone;
  List<String>? interests = [];

  void updateProfile({bool isFromOnboarding = false}) async {
    isLoading = true;
    notifyListeners();

    final res = await profileRepository.updateProfile(request: UpdateProfileRequest(
      professionalTitle: professionalTitle,
      bio: bio,
      phoneNumber: phone,
      location: location,
      timezone: timezone,
      interests: interests,
    ));

    res.fold(
      (success) async {
        await getProfile();
        if(isFromOnboarding) {
          pushAndRemoveUntil(const DashboardScreen());
        }
        
      },
      (failure) {
        isLoading = false;
        notifyListeners();

        ToastUtil.showError(message: failure.message);
      }
    );
  }

  Future<void> getProfile() async {
    isLoading = true;
    notifyListeners();

    final res = await profileRepository.getProfile();

    res.fold(
      (success) {
        isLoading = false;
        notifyListeners();

        profileResponse = success;
        
      },
      (failure) {
        isLoading = false;
        notifyListeners();

        ToastUtil.showError(message: failure.message);
      }
    );
  }
}