class AppConstants {
  static const String baseUrl = "https://example.com";

  static const String defaultLanguage = 'ar';

// WOOCOMMERCE credentials
  static const String consumerKey = '';
  static const String consumerSecret = '';

  // --------------------------------------------------------------------------

  static const String wcUrl = "/wp-json/wc/v3";

  static const String authorizationToken = '$consumerKey:$consumerSecret';

  static const String jwtAuth = "$baseUrl/wp-json/jwt-auth/v1/";

  static const String userUrl = "$wcUrl/customers";
  static const String loginUrl = "/wp-json/jwt-auth/v1/token";
  static const String productUrl = "$wcUrl/products";
  static String variationUrl(int productID) =>
      "$wcUrl/products/$productID/variations";
  static const String categoryUrl = "$wcUrl/products/categories";
  static const String orderUrl = "$wcUrl/orders";
  static const String validateTokenUrl =
      "$baseUrl/wp-json/jwt-auth/v1/token/validate";
}
