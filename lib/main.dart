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
//       showPerformanceOverlay: true,
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

// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, avoid_print

//   @override
//   void dispose() {
//     super.dispose();
//     _leftLoopController.dispose();
//     _rightLoopController.dispose();
//     _leftController.dispose();
//     _rightController.dispose();
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:typed_data';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Uint8List? currentGif;
//   Uint8List? yodaGif;
//   Uint8List? vaderGif;
//   Uint8List? yodaWaitingGif;
//   Uint8List? vaderWaitingGif;
//   bool showGif = false;
//   Timer? _timer;
//   String lastSideClicked = '';

//   @override
//   void initState() {
//     super.initState();
//     loadGifs();
//   }

//   Future<void> loadGifs() async {
//     yodaGif =
//         (await rootBundle.load('assets/yodapress.gif')).buffer.asUint8List();
//     vaderGif =
//         (await rootBundle.load('assets/vaderpress.gif')).buffer.asUint8List();
//     yodaWaitingGif =
//         (await rootBundle.load('assets/yodawaiting.gif')).buffer.asUint8List();
//     vaderWaitingGif =
//         (await rootBundle.load('assets/vaderwaiting.gif')).buffer.asUint8List();
//     setState(() {});
//   }

//   void resetAndPlayGif(Uint8List initialGif, Uint8List waitingGif, int delay) {
//     loadGifs();
//     _timer?.cancel();

//     setState(() {
//       currentGif = initialGif;
//       showGif = true;
//     });

//     _timer = Timer(Duration(milliseconds: delay), () {
//       if (mounted) {
//         setState(() {
//           currentGif = waitingGif;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 0, 0, 0),
//       body: Center(
//         child: GestureDetector(
//           onTapDown: (TapDownDetails details) {
//             final RenderBox box = context.findRenderObject() as RenderBox;
//             final Offset localPosition =
//                 box.globalToLocal(details.globalPosition);
//             final double screenWidth = MediaQuery.of(context).size.width;

//             if (localPosition.dx > screenWidth / 2) {
//               if (lastSideClicked == 'right') return;
//               print('right');
//               lastSideClicked = 'right';
//               resetAndPlayGif(yodaGif ?? Uint8List(0),
//                   yodaWaitingGif ?? Uint8List(0), 2300);
//             } else {
//               if (lastSideClicked == 'left') return;
//               print('left');
//               lastSideClicked = 'left';
//               resetAndPlayGif(vaderGif ?? Uint8List(0),
//                   vaderWaitingGif ?? Uint8List(0), 3000);
//             }
//           },
//           child: Container(
//             color: Colors.black,
//             child: showGif && currentGif != null
//                 ? Image.memory(
//                     currentGif!,
//                     gaplessPlayback: true,
//                   )
//                 : Image.asset('assets/YodaVader.png'), // Default static image
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:typed_data';
// import 'dart:async';
// import 'package:audioplayers/audioplayers.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Uint8List? currentGif;
//   Uint8List? yodaGif;
//   Uint8List? vaderGif;
//   Uint8List? yodaWaitingGif;
//   Uint8List? vaderWaitingGif;
//   bool showGif = false;
//   Timer? _timer;
//   String lastSideClicked = '';
//   AudioPlayer audioPlayer = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     loadGifs();
//   }

//   Future<void> loadGifs() async {
//     yodaGif =
//         (await rootBundle.load('assets/yodapress.gif')).buffer.asUint8List();
//     vaderGif =
//         (await rootBundle.load('assets/vaderpress.gif')).buffer.asUint8List();
//     yodaWaitingGif =
//         (await rootBundle.load('assets/yodawaiting.gif')).buffer.asUint8List();
//     vaderWaitingGif =
//         (await rootBundle.load('assets/vaderwaiting.gif')).buffer.asUint8List();
//     setState(() {});
//   }

//   Future<void> playAudio(String filePath) async {
//     await audioPlayer.play(AssetSource(filePath));
//   }

//   void resetAndPlayGif(Uint8List initialGif, Uint8List waitingGif,
//       String initialAudio, int delay) {
//     loadGifs(); // Consider optimizing to avoid unnecessary reloads
//     _timer?.cancel();
//     playAudio(initialAudio);

//     setState(() {
//       currentGif = initialGif;
//       showGif = true;
//     });

//     _timer = Timer(Duration(milliseconds: delay), () {
//       if (mounted) {
//         setState(() {
//           currentGif = waitingGif;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 0, 0, 0),
//       body: Center(
//         child: GestureDetector(
//           onTapDown: (TapDownDetails details) {
//             final RenderBox box = context.findRenderObject() as RenderBox;
//             final Offset localPosition =
//                 box.globalToLocal(details.globalPosition);
//             final double screenWidth = MediaQuery.of(context).size.width;

//             if (localPosition.dx > screenWidth / 2) {
//               if (lastSideClicked == 'right') return;
//               lastSideClicked = 'right';
//               resetAndPlayGif(yodaGif ?? Uint8List(0),
//                   yodaWaitingGif ?? Uint8List(0), 'sound/yodapress.mp3', 2300);
//             } else {
//               if (lastSideClicked == 'left') return;
//               lastSideClicked = 'left';
//               resetAndPlayGif(
//                   vaderGif ?? Uint8List(0),
//                   vaderWaitingGif ?? Uint8List(0),
//                   'sound/vaderpress.mp3',
//                   3000);
//             }
//           },
//           child: Container(
//             color: Colors.black,
//             child: showGif && currentGif != null
//                 ? Image.memory(
//                     currentGif!,
//                     gaplessPlayback: true,
//                   )
//                 : Image.asset('assets/YodaVader.png'), // Default static image
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     audioPlayer.dispose();
//     super.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:typed_data';
// import 'dart:async';
// import 'package:audioplayers/audioplayers.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Uint8List? currentGif;
//   Uint8List? yodaGif;
//   Uint8List? vaderGif;
//   Uint8List? yodaWaitingGif;
//   Uint8List? vaderWaitingGif;
//   bool showGif = false;
//   Timer? _timer;
//   String lastSideClicked = '';
//   AudioPlayer audioPlayer = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     loadGifs();
//   }

//   Future<void> loadGifs() async {
//     yodaGif =
//         (await rootBundle.load('assets/yodapress.gif')).buffer.asUint8List();
//     vaderGif =
//         (await rootBundle.load('assets/vaderpress.gif')).buffer.asUint8List();
//     yodaWaitingGif =
//         (await rootBundle.load('assets/yodawaiting.gif')).buffer.asUint8List();
//     vaderWaitingGif =
//         (await rootBundle.load('assets/vaderwaiting.gif')).buffer.asUint8List();
//     setState(() {});
//   }

//   Future<void> playAudio(String filePath, {bool loop = false}) async {
//     await audioPlayer
//         .setReleaseMode(loop ? ReleaseMode.loop : ReleaseMode.release);
//     await audioPlayer.play(AssetSource(filePath));
//   }

//   void resetAndPlayGif(Uint8List initialGif, Uint8List waitingGif,
//       String initialAudio, int delay,
//       {String loopAudio = ''}) {
//     loadGifs(); // Consider optimizing to avoid unnecessary reloads
//     _timer?.cancel();
//     playAudio(initialAudio);

//     setState(() {
//       currentGif = initialGif;
//       showGif = true;
//     });

//     _timer = Timer(Duration(milliseconds: delay), () {
//       if (mounted) {
//         setState(() {
//           currentGif = waitingGif;
//         });
//         if (loopAudio.isNotEmpty) {
//           playAudio(loopAudio, loop: true);
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 0, 0, 0),
//       body: Center(
//         child: GestureDetector(
//           onTapDown: (TapDownDetails details) {
//             final RenderBox box = context.findRenderObject() as RenderBox;
//             final Offset localPosition =
//                 box.globalToLocal(details.globalPosition);
//             final double screenWidth = MediaQuery.of(context).size.width;

//             if (localPosition.dx > screenWidth / 2) {
//               if (lastSideClicked == 'right') return;
//               lastSideClicked = 'right';
//               resetAndPlayGif(yodaGif ?? Uint8List(0),
//                   yodaWaitingGif ?? Uint8List(0), 'sound/yodapress.mp3', 2300);
//             } else {
//               if (lastSideClicked == 'left') return;
//               lastSideClicked = 'left';
//               resetAndPlayGif(vaderGif ?? Uint8List(0),
//                   vaderWaitingGif ?? Uint8List(0), 'sound/vaderpress.mp3', 3000,
//                   loopAudio: 'sound/vaderloop.mp3'); // Specify loop audio here
//             }
//           },
//           child: Container(
//             color: Colors.black,
//             child: showGif && currentGif != null
//                 ? Image.memory(
//                     currentGif!,
//                     gaplessPlayback: true,
//                   )
//                 : Image.asset('assets/YodaVader.png'), // Default static image
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     audioPlayer.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List? currentGif3;
  Uint8List? currentGif2;
  Uint8List? yodaGif;
  Uint8List? vaderGif;
  Uint8List? yodaWaitingGif;
  Uint8List? vaderWaitingGif;

  Uint8List? lightup;
  Uint8List? nonlight;
  Uint8List? lightupwaitinggif;
  Uint8List? nonlightupwaitinggif;
  bool showGif3 = false;
  bool showGif2 = false;
  Timer? _timer;
  String lastSideClicked = '';
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer audioPlayer2 = AudioPlayer();

  @override
  void initState() {
    super.initState();
    loadGifs();
  }

  Future<void> loadGifs() async {
    yodaGif =
        (await rootBundle.load('assets/yodapress.gif')).buffer.asUint8List();
    vaderGif =
        (await rootBundle.load('assets/vaderpress.gif')).buffer.asUint8List();
    yodaWaitingGif =
        (await rootBundle.load('assets/yodawaiting.gif')).buffer.asUint8List();
    vaderWaitingGif =
        (await rootBundle.load('assets/vaderwaiting.gif')).buffer.asUint8List();

    lightup =
        (await rootBundle.load('assets/lightuppress.gif')).buffer.asUint8List();
    nonlight = (await rootBundle.load('assets/nonlightpress.gif'))
        .buffer
        .asUint8List();

    lightupwaitinggif = (await rootBundle.load('assets/ligthupwaiting.gif'))
        .buffer
        .asUint8List();
    nonlightupwaitinggif = (await rootBundle.load('assets/nonlightwaiting.gif'))
        .buffer
        .asUint8List();
    setState(() {});
  }

  Future<void> playAudio(String filePath, {bool loop = false}) async {
    await audioPlayer
        .setReleaseMode(loop ? ReleaseMode.loop : ReleaseMode.release);
    await audioPlayer.play(AssetSource(filePath));
  }

  void resetAndPlayGif3(Uint8List initialGif, Uint8List waitingGif,
      String initialAudio, int delay,
      {String loopAudio = ''}) {
    loadGifs();
    _timer?.cancel();
    playAudio(initialAudio);

    setState(() {
      currentGif3 = initialGif;
      showGif3 = true;
    });

    _timer = Timer(Duration(milliseconds: delay), () {
      if (mounted) {
        setState(() {
          currentGif3 = waitingGif;
        });
        if (loopAudio.isNotEmpty) {
          playAudio(loopAudio, loop: true);
        }
      }
    });
  }

  void resetAndPlayGif2(Uint8List initialGif, Uint8List waitingGif,
      String initialAudio, int delay,
      {String loopAudio = ''}) {
    loadGifs(); // Consider optimizing to avoid unnecessary reloads
    _timer?.cancel();
    playAudio(initialAudio);

    setState(() {
      currentGif2 = initialGif;
      showGif2 = true;
    });

    _timer = Timer(Duration(milliseconds: delay), () {
      if (mounted) {
        setState(() {
          currentGif2 = waitingGif;
        });
        if (loopAudio.isNotEmpty) {
          playAudio(loopAudio, loop: true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: Center(
          child: SizedBox(
            width: 600,
            height: 600,
            child: Row(
              children: [
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    if (lastSideClicked != 'left') {
                      // Check if the last side clicked was not left
                      resetAndPlayGif3(
                          nonlight ?? Uint8List(0),
                          nonlightupwaitinggif ?? Uint8List(0),
                          'sound/lightup.mp3',
                          2300);
                      lastSideClicked =
                          'left'; // Update the last side clicked to left
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        color: Colors.black,
                        child: showGif3 && currentGif3 != null
                            ? Image.memory(
                                currentGif3!,
                                gaplessPlayback: true,
                              )
                            : Image.asset('assets/nonlight.png'),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    if (lastSideClicked != 'right') {
                      // Check if the last side clicked was not right
                      resetAndPlayGif2(
                          lightup ?? Uint8List(0),
                          lightupwaitinggif ?? Uint8List(0),
                          'sound/nonlightup.mp3',
                          2300);
                      lastSideClicked =
                          'right'; // Update the last side clicked to right
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        color: Colors.black,
                        child: showGif2 && currentGif2 != null
                            ? Image.memory(
                                currentGif2!,
                                gaplessPlayback: true,
                              )
                            : Image.asset('assets/lightup.png'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _timer?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }
}
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         // Remove the debug banner
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const HomePage());
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// // don't forget "with SingleTickerProviderStateMixin"
// class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation _animation;
//   AnimationStatus _status = AnimationStatus.dismissed;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 800));
//     _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         _status = status;
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 230,
//             ),
//             Transform(
//               alignment: FractionalOffset.center,
//               transform: Matrix4.identity()
//                 ..setEntry(3, 2, 0.0015)
//                 ..rotateY(pi * _animation.value),
//               child: Card(
//                 child: _animation.value <= 0.5
//                     ? Container(
//                         color: Colors.blue,
//                         width: 240,
//                         height: 300,
//                         child: const Center(
//                             child: Text(
//                           '?',
//                           style: TextStyle(fontSize: 100, color: Colors.white),
//                         )))
//                     : Container(
//                         width: 240,
//                         height: 300,
//                         color: Colors.grey,
//                         child: Image.network(
//                           'https://www.dbestech.com/img/mobile.png',
//                           fit: BoxFit.cover,
//                         )),
//               ),
//             ),
//             // Vertical Flipping
//             const SizedBox(
//               height: 30,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   if (_status == AnimationStatus.dismissed) {
//                     _controller.forward();
//                   } else {
//                     _controller.reverse();
//                   }
//                 },
//                 child: const Text('See inside'))
//           ],
//         ),
//       ),
//     );
//   }
// }
