import 'package:earnwise/src/core/domain/dto/create_call_request.dart';
import 'package:earnwise/src/core/domain/response/call_response.dart';
import 'package:earnwise/src/core/repository/call_repository.dart';
import 'package:earnwise/src/features/home/screens/request_call_success_page.dart';
import 'package:earnwise/src/features/profile/view_model/profile_vm.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final callViewModel = ChangeNotifierProvider<CallViewModel>((ref) {
  return CallViewModel(CallRepositoryImpl(), ref);
});


class CallViewModel extends ChangeNotifier {
  late CallRepository callRepository;
  late ChangeNotifierProviderRef ref;

  CallViewModel(this.callRepository, this.ref);

  bool isLoading = false;

  List<CallResponse> calls = [];

  String? callReason;
  int? totalMinutes;
  List<String> suggestedTimes = [];

  List<CallResponse> receivedCallRequests = [];
  List<CallResponse> sentCallRequests = [];
  List<CallResponse> pastCallRequests = [];
  List<CallResponse> upcomingCallRequests = [];

  void addTime(String time) {
    suggestedTimes.add(time);
    notifyListeners();
  }

  void removeTime(String time) {
    suggestedTimes.remove(time);
    notifyListeners();
  }

  DateTime joinDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
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

  Future<void> acceptCall(String callId, String acceptedTime) async {
    isLoading = true;
    notifyListeners();

    final result = await callRepository.acceptCall(callId: callId, acceptedTime: acceptedTime);

    result.fold(
      (success) async {
        isLoading = false;
        notifyListeners();

        await getUserCalls();

        pop();

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
        var userProfile = ref.read(profileViewModel).profileResponse;
        calls = List.from(success.map((e) => CallResponse.fromJson(e)).toList());
        receivedCallRequests = calls.where((element) {
          return element.expertId == userProfile?.expertProfile?.id && element.status == 'pending';
        }).toList();

        sentCallRequests = calls.where((element) {
          return element.userId == userProfile?.expertProfile?.userId && element.status == 'pending';
        }).toList();

        upcomingCallRequests = calls.where((element) {
          return (element.expertId == userProfile?.expertProfile?.id || element.userId == userProfile?.expertProfile?.userId) && element.status == 'accepted' && (callStatus(element) == 'ongoing' || callStatus(element) == 'upcoming');
        }).toList();

        pastCallRequests = calls.where((element) {
          return (element.expertId == userProfile?.expertProfile?.id || element.userId == userProfile?.expertProfile?.userId) && element.status == 'accepted' && callStatus(element) == 'passed';
        }).toList();

        print(receivedCallRequests);
        print(sentCallRequests);
        print(upcomingCallRequests);

        notifyListeners();
      },
      (failure) {
        isLoading = false;
        notifyListeners();
      }
    );
  }

  String callStatus(CallResponse call) {
    DateTime now = DateTime.now();
    DateTime startDateTime = DateTime.parse(call.acceptedTime!);
    DateTime endDateTime = DateTime.parse(call.acceptedTime!).add(Duration(minutes: call.totalMinutes!));

    if(now.isBefore(startDateTime)) {
      return 'upcoming';
    } else if(now.isAfter(endDateTime)) {
      return 'passed';
    } else {
      return 'ongoing';
    }
  }
}