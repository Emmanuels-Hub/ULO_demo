import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> getStoragePermission() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo android = await deviceInfo.androidInfo;

  if (android.version.sdkInt < 33) {
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied || status.isDenied) {
      return false;
    } else {
      return false;
    }
  } else {
    return true;
  }
}
