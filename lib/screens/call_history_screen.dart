import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import '../core/permission.dart';

class CallHistoryScreen extends StatefulWidget {
  const CallHistoryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CallHistoryScreenState createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  List<CallLogEntry> callLogs = [];

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    bool granted = await Permissions.requestCallLogPermission();
    if (granted) {
      _fetchCallLogs();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Permission Denied! Cannot fetch call logs.")),
      );
    }
  }

  Future<void> _fetchCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    setState(() {
      callLogs = entries.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Call History')),
      body: callLogs.isEmpty
          ? Center(child: Text('No call logs available'))
          : ListView.builder(
              itemCount: callLogs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(callLogs[index].name ??
                      callLogs[index].number ??
                      'Unknown'),
                  subtitle: Text(callLogs[index].callType.toString()),
                );
              },
            ),
    );
  }
}
