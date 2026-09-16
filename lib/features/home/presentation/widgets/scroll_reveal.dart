import 'package:flutter/material.dart';

class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    required this.controller,
    required this.child,
    this.duration = const Duration(milliseconds: 560),
    this.offset = const Offset(0, 0.045),
    super.key,
  });

  final ScrollController controller;
  final Widget child;
  final Duration duration;
  final Offset offset;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _revealed = false;
  bool _checkScheduled = false;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_scheduleVisibilityCheck);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  @override
  void didUpdateWidget(covariant ScrollReveal oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller == widget.controller) {
      return;
    }

    oldWidget.controller.removeListener(_scheduleVisibilityCheck);
    widget.controller.addListener(_scheduleVisibilityCheck);

    _scheduleVisibilityCheck();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _scheduleVisibilityCheck() {
    if (_revealed || _checkScheduled || !mounted) {
      return;
    }

    _checkScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScheduled = false;
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (_revealed || !mounted) {
      return;
    }

    final mediaQuery = MediaQuery.maybeOf(context);

    if (mediaQuery?.disableAnimations ?? false) {
      _reveal();
      return;
    }

    final renderObject = context.findRenderObject();

    if (renderObject is! RenderBox ||
        !renderObject.attached ||
        !renderObject.hasSize) {
      return;
    }

    final viewportHeight =
        mediaQuery?.size.height ??
        View.of(context).physicalSize.height /
            View.of(context).devicePixelRatio;

    final top = renderObject.localToGlobal(Offset.zero).dy;
    final bottom = top + renderObject.size.height;

    final revealLine = viewportHeight * 0.90;

    if (top <= revealLine && bottom >= 0) {
      _reveal();
    }
  }

  void _reveal() {
    if (_revealed || !mounted) {
      return;
    }

    widget.controller.removeListener(_scheduleVisibilityCheck);

    setState(() {
      _revealed = true;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scheduleVisibilityCheck);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    if (disableAnimations) {
      return widget.child;
    }

    return AnimatedOpacity(
      opacity: _revealed ? 1 : 0,
      duration: widget.duration,
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: _revealed ? Offset.zero : widget.offset,
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: RepaintBoundary(child: widget.child),
      ),
    );
  }
}
