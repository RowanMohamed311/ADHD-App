// import 'package:adhd_app/widgets/tag_button.dart';
// import 'package:flutter/material.dart';

// class FormWidget extends StatefulWidget {
//   String caption;
//   String tag;
//   final ValueChanged<String> onChangedCaption;
//   final ValueChanged<String> onChangedTag;
//   final VoidCallback? AddPost;

//   FormWidget({
//     Key? key,
//     this.caption = '',
//     this.tag = '',
//     required this.onChangedCaption,
//     required this.onChangedTag,
//     required this.AddPost,
//   });

//   @override
//   State<FormWidget> createState() => _FormWidgetState();
// }

// class _FormWidgetState extends State<FormWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.only(top: 20, left: 1),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(Icons.arrow_back_ios,
//                       color: Theme.of(context).buttonColor),
//                   onPressed: () {
//                     Navigator.of(context).pushReplacementNamed('wrapper');
//                   },
//                   // color: Colors.black54,
//                 ),
//                 const SizedBox(
//                   width: 260,
//                 ),
//                 SizedBox(
//                   height: 30,
//                   width: 60,
//                   child: FloatingActionButton.extended(
//                     heroTag: 'expand_post',
//                     elevation: 2,
//                     onPressed: widget.AddPost,
//                     backgroundColor: Theme.of(context).backgroundColor,
//                     foregroundColor: Theme.of(context).buttonColor,
//                     label: Text('Post'),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Caption(),
//             const SizedBox(
//               height: 10,
//             ),
//             Tag(),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 TagButton(
//                   tag: 'Health',
//                   writtentag: 'Health',
//                   setTag: widget.onChangedTag,
//                   changeTag: (tag) => setState(() {
//                     widget.tag = tag;
//                   }),
//                 ),
//                 TagButton(
//                   tag: 'Advice',
//                   writtentag: 'Advice',
//                   setTag: widget.onChangedTag,
//                   changeTag: (tag) => setState(() {
//                     widget.tag = tag;
//                   }),
//                 ),
//                 TagButton(
//                   tag: 'ADHD',
//                   writtentag: 'ADHD',
//                   setTag: widget.onChangedTag,
//                   changeTag: (tag) => setState(() {
//                     widget.tag = tag;
//                   }),
//                 ),
//                 TagButton(
//                   tag: 'Question',
//                   writtentag: 'Question',
//                   setTag: widget.onChangedTag,
//                   changeTag: (tag) => setState(() {
//                     widget.tag = tag;
//                   }),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget Caption() => TextFormField(
//         maxLines: 15,
//         initialValue: null,
//         decoration: const InputDecoration(
//           hintText: 'Caption',
//           border: InputBorder.none,
//           filled: true,
//           fillColor: Color.fromARGB(255, 255, 250, 236),
//           focusColor: Colors.white,
//           hoverColor: Colors.white,
//         ),
//         onChanged: widget.onChangedCaption,
//         validator: (caption) => caption != null && caption.isEmpty
//             ? 'The caption cannot be empty'
//             : null,
//       );

//   Widget Tag() => TextFormField(
//         maxLines: 1,
//         key: Key(widget.tag), // <- Magic!
//         initialValue: widget.tag,
//         decoration: const InputDecoration(
//           hintText: 'Tag',
//           border: InputBorder.none,
//           filled: true,
//           fillColor: Color.fromARGB(255, 255, 250, 236),
//           focusColor: Colors.white,
//           hoverColor: Colors.white,
//         ),
//         onChanged: widget.onChangedTag,
//         validator: (Tag) =>
//             Tag != null && Tag.isEmpty ? 'The Tag cannot be empty' : null,
//       );
// }
