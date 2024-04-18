import 'package:flutter/material.dart';

class customTextFormField extends StatelessWidget {
  final String? hintTextt;
  final String? labelTextt;
  final Icon? prefixIconn;
  final Icon? suffixIconn;
  final Color? iconColors;
  final TextEditingController? controllerr;
  final TextInputType? keyboardType;
  final bool? obscurityy;

  const customTextFormField({
    super.key,
    this.hintTextt,
    this.labelTextt,
    this.prefixIconn,
    this.suffixIconn,
    this.iconColors = const Color.fromARGB(255, 5, 65, 114),
    this.controllerr,
    this.keyboardType = TextInputType.text,
    this.obscurityy = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controllerr,
        obscureText: obscurityy!,
        decoration: InputDecoration(
            prefixIcon: prefixIconn,
            prefixIconColor: iconColors,
            suffixIcon: suffixIconn,
            suffixIconColor: iconColors,
            border: OutlineInputBorder(),
            hintText: hintTextt,
            labelText: labelTextt),
      ),
    );
  }
}
