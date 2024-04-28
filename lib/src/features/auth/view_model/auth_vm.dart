import 'package:earnwise/src/core/repository/auth_repository.dart';
import 'package:earnwise/src/core/repository/profile_repository.dart';
import 'package:earnwise/src/features/dashboard/screens/dashboard.dart';
import 'package:earnwise/src/features/onboarding/screens/onboarding_screen.dart';
import 'package:earnwise/src/features/profile/view_model/profile_vm.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/toast_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModel = ChangeNotifierProvider<AuthViewModel>((ref) {
  return AuthViewModel(AuthRepositoryImpl(), ProfileRepositoryImpl(), ref);
});

class AuthViewModel extends ChangeNotifier {
  late AuthRepository authRepository;
  late ProfileRepository profileRepository;
  late ChangeNotifierProviderRef ref;

  AuthViewModel(this.authRepository, this.profileRepository, this.ref);

  bool isLoading = false;

  Future<void> login(Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();

    final res = await authRepository.login(data: data);

    res.fold(
      (success) async {
      
        await ref.read(profileViewModel).getProfile();
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
      (success) async {
        await authRepository.login(data: {
          'email': data["email"],
          "password": data["password"]
        });
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