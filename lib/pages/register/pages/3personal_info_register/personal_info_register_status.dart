import 'package:localdaily/view_model.dart';

class PersonalInfoRegisterStatus extends ViewStatus{

  final bool isLoading;
  final bool isError;

  PersonalInfoRegisterStatus({required this.isLoading, required this.isError});

  PersonalInfoRegisterStatus copyWith({bool? isLoading, bool? isError}) {
    return PersonalInfoRegisterStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
