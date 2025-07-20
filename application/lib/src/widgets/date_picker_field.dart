import 'package:application/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final void Function(String)? onChanged;

  const DatePickerField({
    super.key,
    required this.controller,
    required this.labelText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.datetime,
      inputFormatters: [dateFormatter],
      decoration: InputDecoration(
        labelText: labelText,
        errorStyle: const TextStyle(color: Colors.red),
        suffixIcon: IconButton(
          icon: const Icon(Icons.date_range),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            ).then((selectedDate) {
              if (selectedDate != null) {
                controller.text =
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
              }
            });
          },
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return null;
        try {
          DateFormat('dd/MM/yyyy').parseStrict(value);
          return null;
        } catch (_) {
          return 'Data inválida';
        }
      },
    );
  }
}
