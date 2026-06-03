import 'package:flutter/material.dart';

/// A reusable interactive surface that bundles gesture detection, semantics,
/// and a unified keyboard focus indicator.
///
/// Use this in place of `GestureDetector` / `InkWell` whenever a custom-styled
/// region needs to behave as a button. It activates on tap and on
/// Space/Enter when focused, and draws a 2px outline (black on light
/// surfaces, white on dark surfaces) while keyboard focus is on it.
///
/// When [semanticLabel] is non-null and non-empty, it overrides any label
/// computed from descendant semantics — the descendants are excluded so a
/// single, explicit label is announced.
class SemanticButton extends StatefulWidget {
  const SemanticButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.semanticLabel,
    this.semanticHint,
    this.focusNode,
    this.borderRadius,
  });

  final VoidCallback onPressed;
  final Widget child;
  final String? semanticLabel;
  final String? semanticHint;
  final FocusNode? focusNode;
  final BorderRadius? borderRadius;

  @override
  State<SemanticButton> createState() => _SemanticButtonState();
}

class _SemanticButtonState extends State<SemanticButton> {
  bool _focused = false;

  void _activate() => widget.onPressed();

  @override
  Widget build(BuildContext context) {
    final hasLabel = widget.semanticLabel != null &&
        widget.semanticLabel!.isNotEmpty;
    final outlineColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Semantics(
      button: true,
      label: hasLabel ? widget.semanticLabel : null,
      hint: widget.semanticHint,
      excludeSemantics: hasLabel,
      child: FocusableActionDetector(
        focusNode: widget.focusNode,
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              _activate();
              return null;
            },
          ),
        },
        onShowFocusHighlight: (value) {
          if (_focused != value) setState(() => _focused = value);
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _activate,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              border: Border.all(
                color: _focused ? outlineColor : Colors.transparent,
                width: 2,
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
