import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool readOnly;
  final bool showError;
  final bool isRequired;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final IconButton? suffixIcon;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.readOnly = false,
    this.showError = false,
    this.isRequired = true,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      style: TextStyle(color: readOnly ? Colors.grey.shade500 : Colors.black),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
        errorStyle: const TextStyle(fontSize: 0, color: Colors.red),
        suffixIcon: showError && controller.text.isEmpty
            ? const Icon(Icons.error, color: Colors.red)
            : suffixIcon,
      ),
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return '';
        }
        return null;
      },
    );
  }
}

