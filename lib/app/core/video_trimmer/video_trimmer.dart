// import 'package:video_trimmer/video_trimmer.dart';
//
// import '../../export.dart';
//
// class TrimmerView extends StatefulWidget {
//   final File file;
//
//   const TrimmerView(this.file, {super.key});
//
//   @override
//   _TrimmerViewState createState() => _TrimmerViewState();
// }
//
// class _TrimmerViewState extends State<TrimmerView> {
//   TextEditingController textEditingController = TextEditingController();
//   FocusNode focusNode = FocusNode();
//   final Trimmer _trimmer = Trimmer();
//
//   double _startValue = 0.0;
//   double _endValue = 0.0;
//
//   bool _isPlaying = false;
//   bool _progressVisibility = false;
//
//   Future<String?> _saveVideo() async {
//     setState(() {
//       _progressVisibility = true;
//     });
//
//     final completer = Completer<String?>();
//
//     await _trimmer.saveTrimmedVideo(
//       startValue: _startValue,
//       endValue: _endValue,
//       ffmpegCommand:
//           '-vf "fps=10,scale=480:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0',
//       customVideoFormat: '.mp4',
//       onSave: (String? outputPath) {
//         completer.complete(outputPath);
//       },
//     );
//
//     final outputPath = await completer.future;
//
//     setState(() {
//       _progressVisibility = false;
//     });
//
//     return outputPath;
//   }
//
//   void _loadVideo() {
//     _trimmer.loadVideo(videoFile: widget.file);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _loadVideo();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextView(
//           text: "strVideoTrimmerEditor".tr,
//           textStyle: textStyleHeadlineMedium().copyWith(
//               fontWeight: FontWeight.w700, color: AppColors.appGreenColor),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.appGreenColor),
//           onPressed: () {
//             Navigator.of(context).pop(); // Navigate back
//           },
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.edit,
//                 color: AppColors.appGreenColor,
//               )),
//           IconButton(
//             icon: TextView(
//               text: "strSave".tr,
//               textAlign: TextAlign.center,
//               textStyle: textStyleHeadlineMedium().copyWith(
//                   fontWeight: FontWeight.w700, color: AppColors.appGreenColor),
//             ).paddingOnly(right: margin_15),
//             onPressed: () async {
//               if (!_progressVisibility) {
//                 final outputPath = await _saveVideo();
//                 if (outputPath != null) {
//                   debugPrint('OUTPUT PATH: $outputPath');
//                   Navigator.of(Get.context!).pop({
//                     'videoPath': outputPath,
//                     'message': textEditingController.text,
//                   });
//                   showToast(message: 'Video Trim Successfully.');
//                 }
//               }
//             },
//           ),
//         ],
//       ),
//       body: Builder(
//         builder: (context) => Center(
//           child: Container(
//             padding: EdgeInsets.only(bottom: margin_5),
//             color: AppColors.greyColor,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Visibility(
//                   visible: _progressVisibility,
//                   child: const LinearProgressIndicator(
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//                 SizedBox(
//                   height: height_12,
//                 ),
//                 Expanded(
//                   child: VideoViewer(
//                     trimmer: _trimmer,
//                   ),
//                 ),
//                 Center(
//                   child: TrimViewer(
//                     trimmer: _trimmer,
//                     viewerHeight: height_50,
//                     viewerWidth: MediaQuery.of(context).size.width,
//                     onChangeStart: (value) => _startValue = value,
//                     onChangeEnd: (value) => _endValue = value,
//                     onChangePlaybackState: (value) =>
//                         setState(() => _isPlaying = value),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(margin_16),
//                   child: Row(
//                     children: [
//                       TextButton(
//                         child: _isPlaying
//                             ? const Icon(
//                                 Icons.pause,
//                                 size: 60.0,
//                                 color: Colors.white,
//                               )
//                             : const Icon(
//                                 Icons.play_arrow,
//                                 size: 60.0,
//                                 color: Colors.white,
//                               ),
//                         onPressed: () async {
//                           bool playbackState =
//                               await _trimmer.videoPlaybackControl(
//                             startValue: _startValue,
//                             endValue: _endValue,
//                           );
//                           setState(() {
//                             _isPlaying = playbackState;
//                           });
//                         },
//                       ),
//                       Expanded(
//                         child: TextFieldWidget(
//                           textController: textEditingController,
//                           focusNode: focusNode,
//                           formatter: const [],
//                           hint: "strTypeMessage".tr,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
