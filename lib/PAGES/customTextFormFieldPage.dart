import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class customTextFormField extends StatelessWidget {
  final String? hintTextt;
  final String? labelTextt;
  final Icon? prefixIconn;
  final Widget? suffixIconn;
  final Color? iconColors;
  final TextEditingController? controllerr;
  final TextInputType? keyboardType;
  final bool? obscurityy;
  final bool? readOnlyy;
  final String? Function(String?)? validatorrr;
  final VoidCallback? onTap;

  const customTextFormField({
    super.key,
    this.hintTextt,
    this.labelTextt,
    this.prefixIconn,
    this.suffixIconn,
    this.iconColors = const Color.fromARGB(255, 5, 65, 114),
    this.controllerr,
    this.keyboardType,
    this.obscurityy = false,
    this.readOnlyy = false,
    this.validatorrr,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      child: TextFormField(
        controller: controllerr,
        obscureText: obscurityy!,
        validator: validatorrr,
        readOnly: readOnlyy!,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: prefixIconn,
          prefixIconColor: iconColors,
          suffixIcon: suffixIconn,
          suffixIconColor: iconColors,
          border: const OutlineInputBorder(),
          hintText: hintTextt,
          labelText: labelTextt,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
