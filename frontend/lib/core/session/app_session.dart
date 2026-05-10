enum AppUserRole { user, admin }

class AppSession {
  AppSession._();

  static AppUserRole role = AppUserRole.user;
  static String email = '';
  static String displayName = '';

  static String institutionName = 'Addis Ababa University';
  static String institutionDepartment =
      'Founders Guild & Assets Management';

  static bool get isAdmin => role == AppUserRole.admin;

  static void signIn({
    required AppUserRole role,
    required String email,
    required String displayName,
  }) {
    AppSession.role = role;
    AppSession.email = email;
    AppSession.displayName = displayName;
  }

  static void signOut() {
    role = AppUserRole.user;
    email = '';
    displayName = '';
  }
}
