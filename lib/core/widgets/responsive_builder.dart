import 'package:flutter/material.dart';

/// Widget that provides responsive sizing utilities to its children
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
