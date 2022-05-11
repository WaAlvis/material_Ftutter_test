import 'package:localdaily/view_model.dart';

class ChangePswStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final bool isCurrentPswFieldEmpty;
  final bool isNewPswFieldEmpty;
  final bool isAgainNewPswFieldEmpty;
  final bool hasMore8Chars;
  final bool hasUpperLetter;
  final bool hasSpecialChar;
  final bool hasLowerLetter;
  final bool hasNumberChar;
  final bool hidePass;


  ChangePswStatus({
    required this.isLoading,
    required this.isError,
    required this.isCurrentPswFieldEmpty,
    required this.isNewPswFieldEmpty,
    required this.isAgainNewPswFieldEmpty,
    required this.hasSpecialChar,
    required this.hasMore8Chars,
    required this.hasUpperLetter,
    required this.hasLowerLetter,
    required this.hasNumberChar,
    required this.hidePass,

  });

  ChangePswStatus copyWith({
    bool? isLoading,
    bool? isError,
    bool? isCurrentPswFieldEmpty,
    bool? isNewPswFieldEmpty,
    bool? isAgainNewPswFieldEmpty,
    bool? hasSpecialChar,
    bool? hasUpperLetter,
    bool? hasMore8Chars,
    bool? hasLowerLetter,
    bool? hasNumberChar,
    bool? hidePass,

  }) {
    return ChangePswStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isCurrentPswFieldEmpty: isCurrentPswFieldEmpty ?? this.isCurrentPswFieldEmpty,
      isNewPswFieldEmpty: isNewPswFieldEmpty ?? this.isNewPswFieldEmpty,
      isAgainNewPswFieldEmpty: isAgainNewPswFieldEmpty ?? this.isAgainNewPswFieldEmpty,
      hasMore8Chars: hasMore8Chars ?? this.hasMore8Chars,
      hasUpperLetter: hasUpperLetter ?? this.hasUpperLetter,
      hasSpecialChar: hasSpecialChar ?? this.hasSpecialChar,
      hasLowerLetter: hasLowerLetter ?? this.hasLowerLetter,
      hasNumberChar: hasNumberChar ?? this.hasNumberChar,
      hidePass: hidePass ?? this.hidePass,

    );
  }
}
