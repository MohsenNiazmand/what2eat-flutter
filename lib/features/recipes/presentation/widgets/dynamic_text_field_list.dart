import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/core/utils/persian_digits.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_text_field.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';

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
    this.inputFormatters = const [],
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
  final List<TextInputFormatter> inputFormatters;

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
                child: AppTextField(
                  key: ValueKey('${itemHint}_$index'),
                  initialValue: values[index],
                  enabled: enabled,
                  textInputAction: TextInputAction.next,
                  inputFormatters: inputFormatters,
                  labelText: PersianDigits.toPersian(itemLabel(index)),
                  hintText: itemHint,
                  onChanged: (value) => onChanged(index, value),
                ),
              ),
              if (index > 0) ...[
                Gap.h8(),
                IconButton(
                  onPressed: enabled ? () => onRemove(index) : null,
                  icon: const Icon(Icons.remove_circle_outline_rounded),
                  tooltip: context.tr.removeItem,
                ),
              ],
            ],
          ),
          Gap.v12(),
        ],
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton.icon(
            onPressed: enabled ? onAdd : null,
            icon: const Icon(Icons.add_rounded),
            label: Text(addButtonLabel),
          ),
        ),
      ],
    );
  }
}
