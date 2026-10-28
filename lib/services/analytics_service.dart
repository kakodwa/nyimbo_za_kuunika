import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AnalyticsService {
  // Replace with your live Django server domain or IP address
  static const String serverUrl = "https://kuunika.malatrade.com/api/track-activity/";

  /// Returns a persistent unique UUID for this installation
  static Future<String> _getOrCreateDeviceId(SharedPreferences prefs) async {
    String? deviceId = prefs.getString('app_device_id');
    if (deviceId == null) {
      final random = Random();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      deviceId = "dev_${timestamp}_${random.nextInt(999999)}";
      await prefs.setString('app_device_id', deviceId);
    }
    return deviceId;
  }

  /// Records an app launch locally and attempts an immediate sync if online
  static Future<void> logAppLaunch() async {
    final prefs = await SharedPreferences.getInstance();

    // Increment pending unsynced launch count
    int unsyncedLaunches = prefs.getInt('unsynced_launch_count') ?? 0;
    unsyncedLaunches += 1;
    await prefs.setInt('unsynced_launch_count', unsyncedLaunches);

    // Try to send to Django
    await syncPendingTelemetry();
  }

  /// Attempts to upload cached offline telemetry to Django
  static Future<void> syncPendingTelemetry() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final int pendingCount = prefs.getInt('unsynced_launch_count') ?? 0;

      if (pendingCount <= 0) return;

      final String deviceId = await _getOrCreateDeviceId(prefs);

      final response = await http
          .post(
            Uri.parse(serverUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "device_id": deviceId,
              "session_count": pendingCount,
              "app_version": "1.0.0",
            }),
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        // Reset unsynced count back to 0 upon successful confirmation
        await prefs.setInt('unsynced_launch_count', 0);
      }
    } catch (_) {
      // Failed (offline / no network) — keep the local count and try on next launch
    }
  }
}