// // ignore_for_file: library_private_types_in_public_api
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// void main() => runApp(const VideoApp());

// class VideoApp extends StatefulWidget {
//   const VideoApp({super.key});

//   @override
//   _VideoAppState createState() => _VideoAppState();
// }

// class _VideoAppState extends State<VideoApp> {
//   late VideoPlayerController _leftLoopController;
//   late VideoPlayerController _rightLoopController;
//   late VideoPlayerController _leftController;
//   late VideoPlayerController _rightController;
//   bool _isVideoInitiallyPaused = true;
//   String _lastSideClicked = '';

//   @override
//   void initState() {
//     super.initState();
//     // Initialize video controllers
//     _leftLoopController = VideoPlayerController.asset('assets/leftloop.mov')
//       ..initialize().then((_) {
//         setState(() {});
//         _leftLoopController.setLooping(true);
//       });
//     _rightLoopController = VideoPlayerController.asset('assets/rightloop.mov')
//       ..initialize().then((_) {
//         setState(() {});
//         _rightLoopController.setLooping(true);
//       });
//     _leftController = VideoPlayerController.asset('assets/leftvideo.mov')
//       ..initialize().then((_) {
//         setState(() {});
//         _leftController.addListener(() {
//           if (_leftController.value.position ==
//               _leftController.value.duration) {
//             switchToLoopVideo(isLeft: true);
//           }
//         });
//       });
//     _rightController = VideoPlayerController.asset('assets/rightvideo.mov')
//       ..initialize().then((_) {
//         setState(() {});
//         _rightController.addListener(() {
//           if (_rightController.value.position ==
//               _rightController.value.duration) {
//             switchToLoopVideo(isLeft: false);
//           }
//         });
//       });
//   }

//   void switchToLoopVideo({required bool isLeft}) {
//     setState(() {
//       if (isLeft) {
//         _leftLoopController.play();
//         _rightController.pause();
//         _leftController.seekTo(Duration.zero); // Reset left video
//       } else {
//         _rightLoopController.play();
//         _leftController.pause();
//         _rightController.seekTo(Duration.zero); // Reset right video
//       }
//       _isVideoInitiallyPaused = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Seamless Video Transition'),
//         ),
//         body: Center(
//           child: GestureDetector(
//             onTapUp: (TapUpDetails details) {
//               double width = context.size!.width;
//               setState(() {
//                 // Determine which side of the screen was tapped
//                 if (details.localPosition.dx < width / 2 &&
//                     _lastSideClicked != 'left') {
//                   // Left side tapped
//                   _rightLoopController.pause();
//                   _leftLoopController.pause();
//                   _rightController.pause();
//                   _leftController.play();
//                   _lastSideClicked = 'left'; // Update last side clicked
//                 } else if (details.localPosition.dx >= width / 2 &&
//                     _lastSideClicked != 'right') {
//                   // Right side tapped
//                   _leftLoopController.pause();
//                   _rightLoopController.pause();
//                   _leftController.pause();
//                   _rightController.play();
//                   _lastSideClicked = 'right'; // Update last side clicked
//                 }
//                 _isVideoInitiallyPaused = false;
//               });
//             },
//             child: AspectRatio(
//               aspectRatio: _leftLoopController.value
//                   .aspectRatio, // Assuming all videos have the same aspect ratio
//               child: VideoPlayer(_isVideoInitiallyPaused
//                   ? _rightController // Initially display the right video paused
//                   : _leftController.value.isPlaying
//                       ? _leftController
//                       : _rightController.value.isPlaying
//                           ? _rightController
//                           : _leftLoopController.value.isPlaying
//                               ? _leftLoopController
//                               : _rightLoopController),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// // ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors

//   @override
//   void dispose() {
//     super.dispose();
//     _leftLoopController.dispose();
//     _rightLoopController.dispose();
//     _leftController.dispose();
//     _rightController.dispose();
//   }
// }

// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: true,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Key gifKey = UniqueKey();
  Uint8List? gifBytes;
  Uint8List? vaderGifBytes;
  Uint8List? yodaWaitingGifBytes; // New variable for Yoda waiting GIF
  Uint8List? vaderWaitingGifBytes;
  bool showGif = false;
  bool leftSideClickable = true;
  bool rightSideClickable = true;

  @override
  void initState() {
    super.initState();
    loadGifs();
  }

  Future<void> loadGifs() async {
    final ByteData yodaByteData = await rootBundle.load('assets/yodapress.gif');
    final ByteData vaderByteData =
        await rootBundle.load('assets/vaderpress.gif');
    final ByteData yodaWaitingByteData = await rootBundle
        .load('assets/vaderwaiting.gif'); // Loading Yoda waiting GIF
    final ByteData vaderWaitingByteData = await rootBundle
        .load('assets/yodawaiting.gif'); // Loading Yoda waiting GIF

    gifBytes = yodaByteData.buffer.asUint8List();
    vaderGifBytes = vaderByteData.buffer.asUint8List();
    yodaWaitingGifBytes = yodaWaitingByteData.buffer.asUint8List();
    vaderWaitingGifBytes = vaderWaitingByteData.buffer.asUint8List();
  }

  void restartGif() {
    setState(() {
      gifKey = UniqueKey();
      loadGifs();
    });
  }

  void showvaderWaiting() {
    Future.delayed(const Duration(milliseconds: 2870), () {
      if (mounted) {
        setState(() {
          gifBytes = yodaWaitingGifBytes;
          showGif = true;
        });
      }
    });
  }

  void showYodaWiting() {
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) {
        setState(() {
          gifBytes = vaderWaitingGifBytes;
          showGif = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      body: Center(
        child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final Offset localPosition =
                box.globalToLocal(details.globalPosition);
            final double x = localPosition.dx;
            final double screenWidth = MediaQuery.of(context).size.width;
            if (x > screenWidth / 2 && rightSideClickable) {
              setState(() {
                if (!showGif || gifBytes != gifBytes) {
                  gifBytes = gifBytes;
                  showGif = true;
                } else {
                  restartGif();
                }
                leftSideClickable = true;
                rightSideClickable = false;
                showYodaWiting();
              });
            } else if (x <= screenWidth / 2 && leftSideClickable) {
              setState(() {
                if (!showGif || gifBytes != vaderGifBytes) {
                  gifBytes = vaderGifBytes;
                  showGif = true;
                } else {
                  restartGif();
                }
                rightSideClickable = true;
                leftSideClickable = false;
                showvaderWaiting();
              });
            }
          },
          child: showGif && gifBytes != null
              ? Image.memory(
                  gifBytes!,
                  key: gifKey,
                )
              : Image.asset('assets/YodaVader.png'),
        ),
      ),
    );
  }
}
