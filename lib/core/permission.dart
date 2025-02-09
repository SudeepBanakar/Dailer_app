import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static Future<bool> requestCallLogPermission() async {
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }
    return status.isGranted;
  }

  static Future<bool> requestContactsPermission() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      status = await Permission.contacts.request();
    }
    return status.isGranted;
  }
}
