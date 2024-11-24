import 'package:de_hazer_minor_project/widgets/ButtonContainer.dart';
import 'package:de_hazer_minor_project/widgets/Buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 102, 67, 247),
  background: const Color.fromARGB(255, 56, 46, 66),
  brightness: Brightness.dark,
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
      color: Colors.cyanAccent, // Vibrant color for small titles
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
      color: Colors.yellowAccent, // Vibrant color for medium titles
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
      color: Colors.orangeAccent, // Vibrant color for large titles
    ),
    bodyMedium: TextStyle(
      color: Colors.white70, // Keeping the body text lighter for readability
    ),
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "De-Haze Project",
      theme: theme,
      home: const InsertImage(),
    );
  }
}

class InsertImage extends StatefulWidget {
  const InsertImage({Key? key}) : super(key: key);

  @override
  State<InsertImage> createState() => _InsertImageState();
}

class _InsertImageState extends State<InsertImage> {
  File? _image;
  final picker = ImagePicker();
  bool isImageSelected=false;
  bool isDehazePressed=false;


  Future getImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        isImageSelected = true;
        isDehazePressed = false;// Set isVisible to true when an image is picked
      } else {
        print("No Image is Picked");
      }
    });
  }



  void onDehazePressed() {
    setState(() {
      if (isImageSelected) {
        isDehazePressed = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RescueVision"),
      ),
      body: SingleChildScrollView( // Make the body scrollable
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display image right below the AppBar
            _image == null
                ? const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("No Image / Video is Selected"),
            )
                : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.file(_image!),
            ),
            // Add button below the image and center it
            Center(
              child: CustomButtons(
                isVisible: isImageSelected,
                onDehazeImage: onDehazePressed, // Correctly toggle visibility
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            // Show ButtonContainer only if an image is selected
            if (isImageSelected && isDehazePressed) ButtonContainer(isVisible: true),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}


