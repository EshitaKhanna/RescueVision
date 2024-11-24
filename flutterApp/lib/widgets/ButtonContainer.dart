import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  final bool isVisible;

  // Corrected the constructor definition
  const ButtonContainer({Key? key, required this.isVisible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16), // Add margin all around
        decoration: BoxDecoration(
          color: Colors.blueGrey, // Optional background color
          borderRadius: BorderRadius.circular(16), // Rounded corners
          border: Border.all(
            color: Colors.white54, // Border color
            width: 2,
          ),
          boxShadow: [
             BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
              offset: const Offset(0, 5), // Shadow offset
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), // Ensure the image also has rounded corners
          child: Image(
            image: AssetImage("assets/images/dehazedImg.jpg"),
            fit: BoxFit.cover, // Fill the box with the image
          ),
        ),
      ),
    );
  }
}

