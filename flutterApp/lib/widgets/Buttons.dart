import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomButtons extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onDehazeImage;

  const CustomButtons({
    Key? key,
    required this.isVisible,
    required this.onDehazeImage,
  }) : super(key: key);

  @override
  State<CustomButtons> createState() => _CustomButtonsState();
}

class _CustomButtonsState extends State<CustomButtons> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust duration as needed
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _hideOverlay();
        _animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    _hideOverlay();
    _animationController.dispose();
    super.dispose();
  }

  void _showOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black54,
        child: Center(
          child: Lottie.asset(
            'assets/animation/tick2.json', // Replace with your Lottie animation file path
            controller: _animationController,
            width: MediaQuery.of(context).size.width * 0.5, // 50% of screen width
            height: MediaQuery.of(context).size.height * 0.5, // 50% of screen height
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _handleDehazeImage(BuildContext context) {
    _showOverlay(context);
    widget.onDehazeImage();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => _handleDehazeImage(context),
          icon: const Icon(Icons.image),
          label: const Text("Dehaze Image"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 32.0,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(10)),
        ElevatedButton.icon(
          onPressed: () {
            // Handle dehaze video logic here
          },
          icon: const Icon(Icons.video_camera_back_outlined),
          label: const Text("Dehaze Video"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 32.0,
            ),
          ),
        ),
      ],
    );
  }
}

