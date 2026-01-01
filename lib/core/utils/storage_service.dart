import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Simple abstraction over SharedPreferences and FlutterSecureStorage.
/// Call [StorageService.init] once during app startup (e.g. in main)
/// and then access the singleton via [StorageService.instance].
class StorageService {
  StorageService._(this._prefs, this._secureStorage);

  static StorageService? _instance;

  final SharedPreferences _prefs;
  final FlutterSecureStorage _secureStorage;

  /// Initialize the storage service. Must be called before [instance].
  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    // Use a non-const constructor to avoid const initialization issues.
    final secure = FlutterSecureStorage();
    _instance = StorageService._(prefs, secure);
    return _instance!;
  }

  /// Global singleton instance. Ensure [init] has been called first.
  static StorageService get instance {
    final inst = _instance;
    if (inst == null) {
      throw StateError(
        'StorageService not initialized. Call StorageService.init() in main().',
      );
    }
    return inst;
  }

  // ---------------------------------------------------------------------------
  // SharedPreferences helpers (non-sensitive data)
  // ---------------------------------------------------------------------------

  String? getString(String key) => _prefs.getString(key);

  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  bool? getBool(String key) => _prefs.getBool(key);

  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  Future<bool> remove(String key) => _prefs.remove(key);

  // ---------------------------------------------------------------------------
  // Secure storage helpers (sensitive data)
  // ---------------------------------------------------------------------------

  Future<void> setSecureString(String key, String value) =>
      _secureStorage.write(key: key, value: value);

  Future<String?> getSecureString(String key) =>
      _secureStorage.read(key: key);

  Future<void> deleteSecure(String key) =>
      _secureStorage.delete(key: key);
}
