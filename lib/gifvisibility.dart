// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class GifState with ChangeNotifier {
//   Key gifKey = UniqueKey();
//   Uint8List? gifBytes;
//   Uint8List? vaderGifBytes;
//   Uint8List? yodaGifBytes;
//   Uint8List? yodaWaitingGifBytes;
//   Uint8List? vaderWaitingGifBytes;
//   bool showGif = false;
//   bool leftSideClickable = true;
//   bool rightSideClickable = true;

//   GifState() {
//     loadGifs();
//   }

//   Future<void> loadGifs() async {
//     final ByteData yodaByteData = await rootBundle.load('assets/yodapress.gif');
//     final ByteData vaderByteData =
//         await rootBundle.load('assets/vaderpress.gif');
//     final ByteData yodaWaitingByteData =
//         await rootBundle.load('assets/yodawaiting.gif');
//     final ByteData vaderWaitingByteData =
//         await rootBundle.load('assets/vaderwaiting.gif');

//     gifBytes = yodaByteData.buffer.asUint8List();
//     vaderGifBytes = vaderByteData.buffer.asUint8List();
//     yodaGifBytes = yodaByteData.buffer.asUint8List();
//     yodaWaitingGifBytes = yodaWaitingByteData.buffer.asUint8List();
//     vaderWaitingGifBytes = vaderWaitingByteData.buffer.asUint8List();
//     notifyListeners();
//   }

//   void restartGif() {
//     gifKey = UniqueKey();
//     notifyListeners();
//     loadGifs(); // Reload all GIFs
//   }

//   void showVaderWaiting() {
//     Future.delayed(const Duration(milliseconds: 2870), () {
//       if (showGif) {
//         // Ensure the flag is still set
//         gifBytes = vaderWaitingGifBytes;
//         notifyListeners();
//       }
//     });
//   }

//   void showYodaWaiting() {
//     Future.delayed(const Duration(milliseconds: 2490), () {
//       if (showGif) {
//         // Ensure the flag is still set
//         gifBytes = yodaWaitingGifBytes;
//         notifyListeners();
//       }
//     });
//   }

//   void updateTapDetails(BuildContext context, TapDownDetails details) {
//     final RenderBox box = context.findRenderObject() as RenderBox;
//     final Offset localPosition = box.globalToLocal(details.globalPosition);
//     final double x = localPosition.dx;
//     final double screenWidth = MediaQuery.of(context).size.width;

//     if (x > screenWidth / 2 && rightSideClickable) {
//       gifBytes = yodaGifBytes;
//       showGif = true;
//       leftSideClickable = true;
//       rightSideClickable = false;
//       showYodaWaiting();
//       // showVaderWaiting();
//     } else if (x <= screenWidth / 2 && leftSideClickable) {
//       gifBytes =
//           vaderGifBytes; // Assuming you have a Yoda GIF similar to Vader's
//       showGif = true;
//       rightSideClickable = true;
//       leftSideClickable = false;
//       showVaderWaiting();
//       // showYodaWaiting();
//     }
//     notifyListeners();
//   }
// }

// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class GifController extends GetxController {
//   var gifKey = UniqueKey().obs;
//   Rx<Uint8List?> gifBytes = Rx<Uint8List?>(null);
//   Uint8List? vaderGifBytes;
//   Uint8List? yodaWaitingGifBytes;
//   Uint8List? vaderWaitingGifBytes;
//   var showGif = false.obs;
//   var leftSideClickable = true.obs;
//   var rightSideClickable = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadGifs();
//   }

//   Future<void> loadGifs() async {
//     final ByteData yodaByteData = await rootBundle.load('assets/yodapress.gif');
//     final ByteData vaderByteData =
//         await rootBundle.load('assets/vaderpress.gif');
//     final ByteData yodaWaitingByteData =
//         await rootBundle.load('assets/yodawaiting.gif');
//     final ByteData vaderWaitingByteData =
//         await rootBundle.load('assets/vaderwaiting.gif');

//     gifBytes.value = yodaByteData.buffer.asUint8List();
//     vaderGifBytes = vaderByteData.buffer.asUint8List();
//     yodaWaitingGifBytes = yodaWaitingByteData.buffer.asUint8List();
//     vaderWaitingGifBytes = vaderWaitingByteData.buffer.asUint8List();
//   }

//   void restartGif() {
//     gifKey.value = UniqueKey();
//     loadGifs(); // Reload all GIFs
//   }

//   void showVaderWaiting() {
//     Future.delayed(const Duration(milliseconds: 2870), () {
//       if (showGif.value) {
//         // Ensure the flag is still set
//         gifBytes.value = vaderWaitingGifBytes;
//       }
//     });
//   }

//   void showYodaWaiting() {
//     Future.delayed(const Duration(milliseconds: 2490), () {
//       if (showGif.value) {
//         // Ensure the flag is still set
//         gifBytes.value = yodaWaitingGifBytes;
//       }
//     });
//   }

//   void updateTapDetails(BuildContext context, TapDownDetails details) {
//     final RenderBox box = context.findRenderObject() as RenderBox;
//     final Offset localPosition = box.globalToLocal(details.globalPosition);
//     final double x = localPosition.dx;
//     final double screenWidth = MediaQuery.of(context).size.width;

//     if (x > screenWidth / 2 && rightSideClickable.value) {
//       gifBytes.value = vaderGifBytes;
//       showGif.value = true;
//       leftSideClickable.value = true;
//       rightSideClickable.value = false;
//       // showYodaWaiting();
//       showVaderWaiting();
//     } else if (x <= screenWidth / 2 && leftSideClickable.value) {
//       gifBytes.value = gifBytes.value;

//       // Update this line based on your logic, originally it might be yodaGifBytes which seems undefined.
//       showGif.value = true;
//       rightSideClickable.value = true;
//       leftSideClickable.value = false;
//       // showVaderWaiting();
//     }
//   }
// }
