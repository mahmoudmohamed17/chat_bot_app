import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/auth/logic/repos/auth_repo.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  Future<void> logIn({required String email, required String password}) async {
    var result = await authRepo.logIn(email: email, password: password);
    result.fold((failed) => emit(AuthFailed()), (user) => emit(AuthSuccess()));
  }
}
