import 'package:bloc/bloc.dart';
import 'package:loginwithjwt/bloc/todo_event.dart';
import 'package:loginwithjwt/bloc/todo_state.dart';
import 'package:loginwithjwt/services/auth_service.dart';



class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState()) {
    on<SignUpEvent>(_signUp);
    on<LoginEvent>(_login);
  }
  Future<void> _signUp(SignUpEvent event, Emitter<TodoState> emit) async {
    try {
      final response = await AuthService.signup(event.account, event.password);
      if(response.data != null){
        print("Signup success");
        emit(state.copyWith(signupSuccess: true));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(error: e.toString()));
    }
  }
  Future<void> _login(LoginEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await AuthService.login(event.account, event.password);
      emit(state.copyWith(isLoading: false, isLoggedIn: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isLoggedIn: false, error: e.toString()));
    }
  }
}
