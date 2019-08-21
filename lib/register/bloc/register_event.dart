import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class UserNameChanged extends RegisterEvent {
  final String userName;

  UserNameChanged({@required this.userName}) : super([userName]);

  @override
  String toString() => 'User Name Changed { userName :$userName }';
}

class FullNameChanged extends RegisterEvent {
  final String fullName;

  FullNameChanged({@required this.fullName}) : super([fullName]);

  @override
  String toString() => 'govnerment name Changed { fullName :$fullName }';
}

class CellyChanged extends RegisterEvent {
  final String celly;

  CellyChanged({@required this.celly}) : super([celly]);

  @override
  String toString() => 'Burner Changed { celly :$celly }';
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends RegisterEvent {
  final String userName;
  final String fullName;
  final String celly;
  final String email;
  final String password;

  Submitted({@required this.userName, @required this.fullName, @required this.email, @required this.password, @required this.celly})
      : super([userName, fullName, celly, email, password]);

  @override
  String toString() {
    return 'Submitted { userName: $userName, fullName $fullName, celly: $celly, email: $email, password: $password }';
  }
}