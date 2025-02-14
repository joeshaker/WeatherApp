import 'package:weatherapp/Features/Auth/Data/remote/remote_data.dart';
import 'package:weatherapp/Features/Auth/Data/user_model/user_model.dart';

class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource = AuthRemoteDataSource();

  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    final user = await _remoteDataSource.signInWithEmailAndPassword(email, password);
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  Future<UserModel?> signUpWithEmailAndPassword(String email, String password) async {
    final user = await _remoteDataSource.signUpWithEmailAndPassword(email, password);
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }
}