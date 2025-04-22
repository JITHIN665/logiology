import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final RxList<String> selectedItems;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectDropdown({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ExpansionTile(
          title: Text(
            widget.selectedItems.isEmpty
                ? 'Select options'
                : widget.selectedItems.join(', '),
            style: const TextStyle(fontSize: 14),
          ),
          children: [
            SizedBox(
              height: widget.items.length > 5 ? 200 : null,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  return CheckboxListTile(
                    title: Text(item),
                    value: widget.selectedItems.contains(item),
                    onChanged: (bool? selected) {
                      if (selected == true) {
                        widget.selectedItems.add(item);
                      } else {
                        widget.selectedItems.remove(item);
                      }
                      widget.onSelectionChanged(widget.selectedItems);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}