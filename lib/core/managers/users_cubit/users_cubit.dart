import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/auth/logic/repos/auth_repo.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this.authRepo) : super(UsersInitial());
  final AuthRepo authRepo;

  String? _fullName;
  String? _phoneNumber;
  String? _profilePicture;
  String? _gender;
  String? _dateOfBirth;

  UserModel? user;

  Future<void> getUser() async {
    emit(UsersLoading());
    try {
      user = await authRepo.getUser(authRepo.getCurrentUser()!.id);
      emit(UsersSuccess());
    } catch (e) {
      emit(UsersFailed(errorMsg: e.toString()));
    }
  }

  Future<void> addUser() async {
    emit(UsersLoading());
    var user = UserModel(
      userId: authRepo.getCurrentUser()!.id,
      createdAt: DateTime.now().toString(),
      fullName: _fullName,
      phoneNumber: _phoneNumber,
      profilePicture: _profilePicture ?? Assets.imagesProfilePic,
      dateOfBirth: _dateOfBirth,
      gender: _gender ?? 'Male',
    );
    try {
      await authRepo.addUser(user);
      emit(UsersSuccess());
    } catch (e) {
      emit(UsersFailed(errorMsg: e.toString()));
    }
  }

  Future<void> addGoogleUser(GoogleSignInAccount googleUser) async {
    emit(UsersLoading());
    var user = UserModel(
      userId: authRepo.getCurrentUser()!.id,
      createdAt: DateTime.now().toString(),
      fullName: googleUser.displayName,
      phoneNumber: '',
      profilePicture: googleUser.photoUrl,
    );
    try {
      await authRepo.addUser(user);
      emit(UsersSuccess());
    } catch (e) {
      emit(UsersFailed(errorMsg: e.toString()));
    }
  }

  Future<void> updateUserDate(UserModel user) async {
    emit(UsersLoading());
    try {
      await authRepo.updateUserDate(user);
      emit(UsersSuccess());
    } catch (e) {
      emit(UsersFailed(errorMsg: e.toString()));
    }
  }

  Future<void> deleteUser() async {
    emit(UsersLoading());
    try {
      await authRepo.deleteUser(authRepo.getCurrentUser()!.id);
      emit(UsersSuccess());
    } catch (e) {
      emit(UsersFailed(errorMsg: e.toString()));
    }
  }

  String? get fullName => _fullName;

  String? get phoneNumber => _phoneNumber;

  String? get profilePicture => _profilePicture;

  String? get gender => _gender;

  String? get dateOfBirth => _dateOfBirth;

  set fullName(String? value) => _fullName = value;

  set phoneNumber(String? value) => _phoneNumber = value;

  set profilePicture(String? value) => _profilePicture = value;

  set gender(String? value) => _gender = value;

  set dateOfBirth(String? value) => _dateOfBirth = value;
}
