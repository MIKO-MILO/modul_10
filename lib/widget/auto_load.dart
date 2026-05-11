import 'package:flutter/material.dart';

class AutoLoad extends StatefulWidget {
  final Function? onInit;
  final Widget? child;
  const AutoLoad({super.key, required this.onInit, required this.child});
  @override
  State<AutoLoad> createState() => _AutoLoadState();
}

class _AutoLoadState extends State<AutoLoad> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onInit != null) {
        widget.onInit!();
      }
    });
  }

  void runFunction() {
    if (widget.onInit != null) {
      widget.onInit!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: widget.child!,
    );
  }
}
