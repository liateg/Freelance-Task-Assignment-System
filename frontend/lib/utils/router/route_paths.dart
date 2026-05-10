class RoutePaths {
  // Auth
  static const login = '/auth/login';
  static const register = '/auth/register';

  // Items
  static const items = '/items';
  static const itemDetail = '/items/:id';
  static const createItem = '/items/create';
  static const editItem = '/items/edit/:id';
  static const filters = '/filters';

  // Claims
  static const claims = '/claims';
  static const createClaim = '/claims/create/:itemId';
  static const claimDetail = '/claims/:id';

  // Reports
  static const reports = '/reports';
  static const createReport = '/reports/create';
  static const reportDetail = '/reports/:id';

  // Admin
  static const adminItems = '/admin/items';
  static const adminClaims = '/admin/claims';
  static const adminClaimDetail = '/admin/claims/:id';
  static const adminReports = '/admin/reports';

  // Categories
  static const adminCategories = '/admin/categories';
}