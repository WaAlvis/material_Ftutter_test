import 'package:localdaily/view_model.dart';

class ChangePasswordStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final bool isPasswordFieldEmpty;
  final bool hasMore8Chars;
  final bool hasUpperLetter;
  final bool hasSpecialChar;
  final bool hasLowerLetter;
  final bool hasNumberChar;
  final bool hidePass;


  ChangePasswordStatus({
    required this.isLoading,
    required this.isError,
    required this.isPasswordFieldEmpty,
    required this.hasSpecialChar,
    required this.hasMore8Chars,
    required this.hasUpperLetter,
    required this.hasLowerLetter,
    required this.hasNumberChar,
    required this.hidePass,

  });

  ChangePasswordStatus copyWith({
    bool? isLoading,
    bool? isError,
    bool? isPasswordFieldEmpty,
    bool? hasSpecialChar,
    bool? hasUpperLetter,
    bool? hasMore8Chars,
    bool? hasLowerLetter,
    bool? hasNumberChar,
    bool? hidePass,

  }) {
    return ChangePasswordStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isPasswordFieldEmpty: isPasswordFieldEmpty ?? this.isPasswordFieldEmpty,
      hasMore8Chars: hasMore8Chars ?? this.hasMore8Chars,
      hasUpperLetter: hasUpperLetter ?? this.hasUpperLetter,
      hasSpecialChar: hasSpecialChar ?? this.hasSpecialChar,
      hasLowerLetter: hasLowerLetter ?? this.hasLowerLetter,
      hasNumberChar: hasNumberChar ?? this.hasNumberChar,
      hidePass: hidePass ?? this.hidePass,

    );
  }
}
