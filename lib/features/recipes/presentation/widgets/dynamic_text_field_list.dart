import 'package:flutter/material.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';

class DynamicTextFieldList extends StatelessWidget {
  const DynamicTextFieldList({
    required this.values,
    required this.onChanged,
    required this.onAdd,
    required this.onRemove,
    required this.itemLabel,
    required this.itemHint,
    required this.addButtonLabel,
    required this.enabled,
    this.minItems = 1,
    super.key,
  });

  final List<String> values;
  final void Function(int index, String value) onChanged;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final String Function(int index) itemLabel;
  final String itemHint;
  final String addButtonLabel;
  final bool enabled;
  final int minItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < values.length; index++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  key: ValueKey('${itemHint}_$index'),
                  initialValue: values[index],
                  enabled: enabled,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: itemLabel(index),
                    hintText: itemHint,
                  ),
                  onChanged: (value) => onChanged(index, value),
                ),
              ),
              if (values.length > minItems) ...[
                const SizedBox(width: 8),
                IconButton(
                  onPressed: enabled ? () => onRemove(index) : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  tooltip: context.tr.removeItem,
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
        ],
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton.icon(
            onPressed: enabled ? onAdd : null,
            icon: const Icon(Icons.add),
            label: Text(addButtonLabel),
          ),
        ),
      ],
    );
  }
}
