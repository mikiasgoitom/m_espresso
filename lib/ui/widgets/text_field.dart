import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m_espresso_v1/ui/theme/app_theme.dart';

class TextFeildInput extends StatelessWidget {
  const TextFeildInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    this.icon,
    this.validator,
    this.onChanged,
  });

  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData? icon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: textEditingController,
        obscureText: isPass,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),
          prefixIcon: Icon(
            icon,
            color: Apptheme.orange1Color,
          ),
          border: InputBorder.none,
          filled: true,
          fillColor: const Color.fromARGB(255, 244, 245, 250),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Apptheme.orange2Color),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
