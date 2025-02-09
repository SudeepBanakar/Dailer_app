import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';

class DialPadScreen extends StatefulWidget {
  @override
  _DialPadScreenState createState() => _DialPadScreenState();
}

class _DialPadScreenState extends State<DialPadScreen> {
  String phoneNumber = '';

  void _addDigit(String digit) {
    setState(() {
      if (phoneNumber.length < 15) {
        phoneNumber += digit;
      }
    });
  }

  void _deleteDigit() {
    setState(() {
      if (phoneNumber.isNotEmpty) {
        phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
      }
    });
  }

  void _callNumber() async {
    if (phoneNumber.isNotEmpty) {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    }
  }

  Widget _buildDialButton(String digit, {String? subText}) {
    return GestureDetector(
      onTap: () => _addDigit(digit),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[850],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              digit,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (subText != null)
              Text(
                subText,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Dial Pad"),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display entered number
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                phoneNumber,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Scrollable Dial Pad
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        children: [
                          _buildDialButton("1"),
                          _buildDialButton("2", subText: "ABC"),
                          _buildDialButton("3", subText: "DEF"),
                          _buildDialButton("4", subText: "GHI"),
                          _buildDialButton("5", subText: "JKL"),
                          _buildDialButton("6", subText: "MNO"),
                          _buildDialButton("7", subText: "PQRS"),
                          _buildDialButton("8", subText: "TUV"),
                          _buildDialButton("9", subText: "WXYZ"),
                          _buildDialButton("*"),
                          _buildDialButton("0", subText: "+"),
                          _buildDialButton("#"),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            // Call and Delete Button (Fixed at Bottom)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Delete button
                  IconButton(
                    icon: Icon(Icons.backspace, color: Colors.white, size: 30),
                    onPressed: _deleteDigit,
                  ),
                  SizedBox(width: 60),
                  // Call button
                  ElevatedButton(
                    onPressed: _callNumber,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                    child: Icon(Icons.call, color: Colors.white, size: 35),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
