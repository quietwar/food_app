import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:food_app/register/bloc/register_event.dart';
import 'package:food_app/register/bloc/register_state.dart';
import 'package:food_app/utils/user_repository.dart';
import 'package:food_app/validators.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transform(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final observableStream = events as Observable<RegisterEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! UserNameChanged && event is! FullNameChanged && event is! CellyChanged && event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is UserNameChanged || event is FullNameChanged || event is CellyChanged || event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is UserNameChanged) {
      yield* _mapUserNameChangedToState(event.userName);
    } else if (event is FullNameChanged) {
      yield* _mapFullNameChangedToState(event.fullName);
    } else if (event is CellyChanged) {
      yield* _mapCellyChangedToState(event.celly);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.userName, event.fullName, event.celly, event.email, event.password);
    }
  }

  Stream<RegisterState> _mapUserNameChangedToState(String userName) async* {
    yield currentState.update(
      isUserNameValid: Validators.isValidUserName(userName),
    );
  }
  
  Stream<RegisterState> _mapFullNameChangedToState(String fullName) async* {
    yield currentState.update(
      isFullNameValid: Validators.isValidFullName(fullName),
    );
  }
  
  Stream<RegisterState> _mapCellyChangedToState(String celly) async* {
    yield currentState.update(
      isCellyValid: Validators.isValidCelly(celly),
    );
  }
  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String userName,
    String fullName,
    String celly,
    String email,
    String password,
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        userName: userName,
        fullName: fullName,
        celly: celly,
        email: email,
        password: password,
      );
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}