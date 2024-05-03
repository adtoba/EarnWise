import 'package:earnwise/src/core/domain/dto/create_call_request.dart';
import 'package:earnwise/src/core/domain/response/call_response.dart';
import 'package:earnwise/src/core/repository/call_repository.dart';
import 'package:earnwise/src/features/home/screens/request_call_success_page.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final callViewModel = ChangeNotifierProvider<CallViewModel>((ref) {
  return CallViewModel(CallRepositoryImpl());
});


class CallViewModel extends ChangeNotifier {
  late CallRepository callRepository;

  CallViewModel(this.callRepository);

  bool isLoading = false;

  List<CallResponse> calls = [];

  String? callReason;
  int? totalMinutes;
  List<String> suggestedTimes = [];

  void addTime(String time) {
    suggestedTimes.add(time);
    notifyListeners();
  }

  void removeTime(String time) {
    suggestedTimes.remove(time);
    notifyListeners();
  }


  Future<void> createCall(CreateCallRequest request) async {
    isLoading = true;
    notifyListeners();

    final result = await callRepository.createCall(request: request);

    result.fold(
      (success) async {
        isLoading = false;
        notifyListeners();

        await getUserCalls();

        pushAndRemoveUntil(const RequestCallSuccessPage());

      },
      (failure) {
        isLoading = false;
        notifyListeners();
      }
    );
  }

  Future<void> getUserCalls() async {
    isLoading = true;
    notifyListeners();

    final result = await callRepository.getUserCalls();
    result.fold(
      (success) {
        isLoading = false;
        notifyListeners();

        calls = List.from(success.map((e) => CallResponse.fromJson(e)).toList());
        notifyListeners();
      },
      (failure) {
        isLoading = false;
        notifyListeners();
      }
    );
  }
}