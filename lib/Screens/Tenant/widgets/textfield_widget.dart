// import 'package:flutter/material.dart';

// class TextFieldWidget extends StatefulWidget {
//   final int maxLines;
//   final String label;
//   final String text;
//   final ValueChanged<String> onChanged;
//   final TextEditingController? controller;

//   const TextFieldWidget({
//     Key? key,
//     this.maxLines = 1,
//     required this.label,
//     required this.text,
//     required this.onChanged,
//     this.controller,
//   }) : super(key: key);

//   @override
//   _TextFieldWidgetState createState() => _TextFieldWidgetState();
// }

// class _TextFieldWidgetState extends State<TextFieldWidget> {
//   late final TextEditingController _controller;

//   @override
//   void initState() {
//     super.initState();

//     _controller = widget.controller ?? TextEditingController(text: widget.text);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.label,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             controller: _controller,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             maxLines: widget.maxLines,
//           ),
//         ],
//       );
// }