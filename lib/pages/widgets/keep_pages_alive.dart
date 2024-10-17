import 'package:flutter/material.dart';

class KeepPagesAlive extends StatefulWidget {
  final Widget child;
  const KeepPagesAlive({
    super.key,
    required this.child,
  });

  @override
  State<KeepPagesAlive> createState() => _KeepPageAliveState();
}

class _KeepPageAliveState extends State<KeepPagesAlive>
    with AutomaticKeepAliveClientMixin<KeepPagesAlive> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
