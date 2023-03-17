// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:my_daily_tasks/features/presentation/widgets/common.dart';

// class SelectTaskType extends StatefulWidget {
//   const SelectTaskType({super.key, this.name, this.color, this.index});
//   final String? name;
//   final Color? color;
//   final int? index;

//   @override
//   State<SelectTaskType> createState() => _SelectTaskTypeState();
// }

// class _SelectTaskTypeState extends State<SelectTaskType> {
//   bool isSelectType = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: const EdgeInsets.only(left: 10),
//         child: GestureDetector(
//           onTap: () {
//             log("index:: ${widget.index}");
//             setState(() {
//               isSelectType = !isSelectType;
//             });
//             log('TTT: $isSelectType');
//           },
//           child: Container(
//               // color: taskTypeListColor[index!],
//               padding: const EdgeInsets.only(left: 10),
//               child: isSelectType == true
//                   ? Container(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(10)),
//                           color: taskTypeListColor[widget.index!],
//                         ),
//                         child: Text(
//                           widget.name.toString(),
//                           style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     )
//                   : Container(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 10,
//                             width: 10,
//                             decoration: BoxDecoration(
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(10)),
//                               color: taskTypeListColor[widget.index!],
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 4,
//                           ),
//                           Text(
//                             widget.name.toString(),
//                             style: const TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     )),
//         ));
//   }
// }
