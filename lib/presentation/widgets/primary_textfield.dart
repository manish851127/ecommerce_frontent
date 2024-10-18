import 'package:flutter/material.dart';

class PrimaryTextfield extends StatelessWidget {
  final String labelText;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  const PrimaryTextfield({super.key,
   this.textEditingController, 
   required this.labelText,
    required this.validator,
    this.obscureText=false
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
            obscureText: obscureText! ,
            validator: validator,
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )
        )
    );
  }
}