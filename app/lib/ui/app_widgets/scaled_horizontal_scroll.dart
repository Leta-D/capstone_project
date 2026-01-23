// import 'package:flutter/cupertino.dart';

// Widget _buildItem(int index) {
//     final double scrollOffset = _controller.hasClients ? _controller.offset : 0;

//     final double itemPosition = index * itemWidth;
//     final double viewportCenter =
//         scrollOffset + MediaQuery.of(context).size.width / 2;

//     final double distance = (itemPosition + itemWidth / 2 - viewportCenter)
//         .abs();

//     final double scale =
//         (maxScale - (distance / MediaQuery.of(context).size.width)).clamp(
//           minScale,
//           maxScale,
//         );

//     return SizedBox(
//       width: itemWidth,
//       child: Center(
//         child: Transform.scale(
//           scale: scale,
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             elevation: 4,
//             child: SizedBox(
//               width: itemWidth - 20,
//               height: 160,
//               child: Center(
//                 child: Text(
//                   'Item $index',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
