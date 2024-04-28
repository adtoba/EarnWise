import 'package:earnwise/src/core/repository/auth_repository.dart';
import 'package:earnwise/src/core/repository/profile_repository.dart';
import 'package:earnwise/src/features/dashboard/screens/dashboard.dart';
import 'package:earnwise/src/features/onboarding/screens/onboarding_screen.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/toast_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModel = ChangeNotifierProvider((ref) {
  return AuthViewModel(AuthRepositoryImpl(), ProfileRepositoryImpl());
});

class AuthViewModel extends ChangeNotifier {
  late AuthRepository authRepository;
  late ProfileRepository profileRepository;

  AuthViewModel(this.authRepository, this.profileRepository);

  bool isLoading = false;

  void login(Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();

    final res = await authRepository.login(data: data);

    res.fold(
      (success) {
        isLoading = false;
        notifyListeners();

        pushAndRemoveUntil(const DashboardScreen());
      }, 
      (failure) {
        isLoading = false;
        notifyListeners();

        ToastUtil.showError(message: failure.message);
      }
    );
  }

  void register(Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();

    final res = await authRepository.register(data: data);

    res.fold(
      (success) {
        isLoading = false;
        notifyListeners();

        pushAndRemoveUntil(const OnboardingScreen());
      }, 
      (failure) {
        isLoading = false;
        notifyListeners();
        
        ToastUtil.showError(message: failure.message);
      }
    );
  }
}