import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/semantic_button.dart';
import 'bullet_list.dart';

class TipsSection extends StatefulWidget {
  const TipsSection({
    super.key,
    required this.color,
    required this.tips,
    this.focusNode,
  });
  final Color color;
  final List<String> tips;
  final FocusNode? focusNode;

  @override
  State<TipsSection> createState() => TipsSectionState();
}

class TipsSectionState extends State<TipsSection> {
  bool _expanded = false;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SemanticButton(
          focusNode: widget.focusNode,
          onPressed: _toggle,
          borderRadius: BorderRadius.circular(6),
          semanticLabel:
              _expanded ? 'Collapse tips for home' : 'Expand tips for home',
          child: Row(
            children: [
              Icon(CupertinoIcons.lightbulb,
                  size: 15, color: widget.color),
              const SizedBox(width: 6),
              Text(
                'Tips for home',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: widget.color,
                    ),
              ),
              const SizedBox(width: 4),
              Icon(
                _expanded
                    ? CupertinoIcons.chevron_up
                    : CupertinoIcons.chevron_down,
                size: 12,
                color: widget.color,
              ),
            ],
          ),
        ),
        if (_expanded) ...[
          const SizedBox(height: 10),
          BulletList(items: widget.tips),
        ],
      ],
    );
  }
}
