import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  const Dropdown(
      {super.key,
      this.label = '',
      this.itemList = const [],
      required this.onChanged,
      required this.value});

  final String label;
  final List itemList;
  final dynamic value;
  final Function(Object) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton(
            itemHeight: 56,
            // menuMaxHeight: 52,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            elevation: 0,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.8)),
            isExpanded: true,
            items: [
              ...itemList.map(
                (item) =>
                    DropdownMenuItem(value: item, child: Text(item)),
              )
            ],
            onChanged: (value) => onChanged.call(value!),
            value: value),
      ],
    );
  }
}
