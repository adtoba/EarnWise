import 'package:earnwise/src/core/constants/prefs.dart';
import 'package:earnwise/src/core/domain/dto/create_expert_profile_request.dart';
import 'package:earnwise/src/core/domain/response/expert_profile.dart';
import 'package:earnwise/src/core/repository/expert_repository.dart';
import 'package:earnwise/src/core/services/storage_service.dart';
import 'package:earnwise/src/features/profile/view_model/profile_vm.dart';
import 'package:earnwise/src/utils/toast_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expertViewModel = ChangeNotifierProvider<ExpertViewModel>((ref) {
  return ExpertViewModel(ExpertRepositoryImpl(), ref);
});

class ExpertViewModel extends ChangeNotifier {
  late ExpertRepository expertRepository;
  late ChangeNotifierProviderRef ref;

  ExpertViewModel(this.expertRepository, this.ref);

  bool isLoading = false;

  List<String> selectedTopics = [];
  void addTopic(String topic) {
    selectedTopics.add(topic);
    notifyListeners();
  }

  void removeTopic(String topic) {
    selectedTopics.remove(topic);
    notifyListeners();
  }

  void clearTopics() {
    selectedTopics.clear();
    notifyListeners();
  }

  ExpertProfile? expertProfile;
  String? expertProfileMessage;

  List<ExpertProfile> suggestedExperts = [];

  Future<void> createExpertProfile(CreateExpertProfileRequest request) async {
    String? userId = await LocalStorage.get(SharedPrefs.userId);
    request.userId = userId;
    
    isLoading = true;
    notifyListeners();

    final result = await expertRepository.createExpertProfile(request);
    result.fold(
      (success) async {
        isLoading = false;
        notifyListeners();

        await ref.read(profileViewModel).getProfile();
      },
      (failure) {
        isLoading = false;
        notifyListeners();

        ToastUtil.showError(message: failure.message);
      }
    );
  }

  Future<void> getExpertProfile() async {
    isLoading = true;
    notifyListeners();

    String? userId = await LocalStorage.get(SharedPrefs.userId);

    final result = await expertRepository.getExpertProfile(userId: userId);
    result.fold(
      (success) {
        expertProfile = ExpertProfile.fromJson(success);
        isLoading = false;
        expertProfileMessage = null;
        notifyListeners();
        
      },
      (failure) {
        isLoading = false;
        expertProfileMessage = null;
        notifyListeners();
      }
    );
  }

  Future<void> getSuggestedExperts() async {
    isLoading = true;
    notifyListeners();

    final result = await expertRepository.getSuggestedExpertProfiles();
    result.fold(
      (success) {
        suggestedExperts = List.from(success.map((e) => ExpertProfile.fromJson(e)).toList());
        isLoading = false;
        expertProfileMessage = null;
        notifyListeners();
        
      },
      (failure) {
        isLoading = false;
        expertProfileMessage = null;
        notifyListeners();
      }
    );
  }
}