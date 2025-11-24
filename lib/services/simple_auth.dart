class AuthService {
  // Demo: terima semua email/password yang tidak kosong.
  // Ganti dengan logika nyata / panggilan API jika perlu.
  static bool login(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }
}
