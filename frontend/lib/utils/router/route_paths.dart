class RoutePaths {
  // Auth
  static const splash='/auth/splash';
  static const login = '/auth/login';
  static const adminLogin='/auth/admin-login';
  static const register = '/auth/register';

  // Items
  static const items = '/auth';
  static const itemDetail = '/auth/:id';
  static const createItem = '/auth/create';
  static const editItem = '/auth/edit/:id';

  // Claims
  static const claims = '/claims';
  static const createClaim = '/claims/create/:itemId';
  static const claimDetail = '/claims/:id';

  // Reports
  static const reports = '/reports';
  static const createReport = '/reports/create';
  static const reportDetail = '/reports/:id';

  // Admin
  static const adminItems = '/admin/auth';
  static const adminClaims = '/admin/claims';
  static const adminClaimDetail = '/admin/claims/:id';
  static const adminReports = '/admin/reports';
  static const adminDashboard='/admin/dashboard';
  // Categories
  static const adminCategories = '/admin/categories';
}