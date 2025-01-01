abstract class AuthRepository {
  Future<void> signin(String email, String password);
  Future<void> signup(String email, String password);
  Future<void> forgetPassword(String email);
  Future<void> signout();
}
