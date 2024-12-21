// import 'package:flutter/material.dart';

// class ReponsiveLayout extends StatelessWidget {
//   final Widget mobileScaffold;
//   final Widget tabletScaffold;
//   final Widget desktopScaffold;

//   const ReponsiveLayout(
//       {super.key,
//       required this.mobileScaffold,
//       required this.tabletScaffold,
//       required this.desktopScaffold});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constants) {
//       if (constants.maxWidth < 500)
//         return mobileScaffold;
//       else if (constants.maxWidth < 1100)
//         return tabletScaffold;
//       else
//         return desktopScaffold;
//     });
//   }
// }
