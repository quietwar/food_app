import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isUserNameValid;
  final bool isFullNameValid; 
  final bool isCellyValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isUserNameValid && isFullNameValid && isEmailValid && isPasswordValid && isCellyValid;

  RegisterState({
    @required this.isUserNameValid,
    @required this.isFullNameValid, 
    @required this.isCellyValid,
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isUserNameValid: true,
      isFullNameValid: true,
      isCellyValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isUserNameValid: true,
      isFullNameValid: true,
      isCellyValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isUserNameValid: true,
      isFullNameValid: true,
      isCellyValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isUserNameValid: true,
      isFullNameValid: true,
      isCellyValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool isUserNameValid,
    bool isFullNameValid,
    bool isCellyValid,
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isUserNameValid: isUserNameValid,
      isFullNameValid: isFullNameValid,
      isCellyValid: isCellyValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isUserNameValid,
    bool isFullNameValid,
    bool isCellyValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isUserNameValid: isUserNameValid ?? this.isUserNameValid,
      isFullNameValid: isFullNameValid ?? this.isFullNameValid,
      isCellyValid: isCellyValid ?? this.isCellyValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isUserName: $isUserNameValid,
      isFullName: $isFullNameValid,
      isCelly: $isCellyValid,
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
