// WARNING: Do not commit real secrets to source control in production.
// Prefer passing values via --dart-define or loading them securely.

class CloudinaryConfig {
  // Your Cloudinary cloud name, e.g., 'demo'
  static const String cloudName = String.fromEnvironment(
    'CLOUDINARY_CLOUD_NAME',
    defaultValue: 'YOUR_CLOUD_NAME',
  );

  // Your Cloudinary API key
  static const String apiKey = String.fromEnvironment(
    'CLOUDINARY_API_KEY',
    defaultValue: 'YOUR_API_KEY',
  );

  // Your Cloudinary API secret (avoid using on client in production)
  static const String apiSecret = String.fromEnvironment(
    'CLOUDINARY_API_SECRET',
    defaultValue: 'YOUR_API_SECRET',
  );
}
