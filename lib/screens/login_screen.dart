import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/google_service.dart' as gs;
import '../widgets/google_service_1.dart' as gs1;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final gs.GoogleService _googleService = gs.GoogleService();
  GoogleSignInAccount? _currentUser;
  gs.GoogleContacts? _contacts; // Use gs prefix
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _googleService.googleSignIn.onCurrentUserChanged.listen((user) {
      setState(() => _currentUser = user);
      if (user != null) _fetchContacts();
    });

    _googleService.googleSignIn.signInSilently();
  }

  Future<void> _fetchContacts() async {
    if (_currentUser == null) return;

    setState(() => isLoading = true);

    final contacts = await _googleService.getUserContacts(_currentUser!);

    setState(() {
      _contacts = contacts;
      isLoading = false;
    });
  }

  Widget _buildLoginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("See contacts saved in your Gmail",
            style: TextStyle(fontSize: 24)),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            try {
              await _googleService.googleSignIn.signIn();
            } catch (e) {
              print("Google Sign-In Error: $e");
            }
          },
          child: Text("Google Sign In"),
        ),
      ],
    );
  }

  Widget _buildContactsWidget() {
    return ListView.separated(
      itemCount: _contacts?.connections.length ?? 0,
      itemBuilder: (context, index) {
        final contact = _contacts!.connections[index];
        return ListTile(
          title: Text(contact.names.isNotEmpty
              ? contact.names.first.displayName
              : "No Name"),
          subtitle: Text(contact.phoneNumbers.isNotEmpty
              ? contact.phoneNumbers.first.value
              : "No Number"),
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _currentUser == null
          ? null
          : FloatingActionButton(
              onPressed: () async {
                await _googleService.googleSignIn.signOut();
                setState(() {
                  _currentUser = null;
                  _contacts = null;
                });
              },
              child: Icon(Icons.logout),
            ),
      appBar: AppBar(title: Text("Contacts App")),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : _contacts != null && _currentUser != null
                ? _buildContactsWidget()
                : _buildLoginWidget(),
      ),
    );
  }
}
