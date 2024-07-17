// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:form_field_validator/form_field_validator.dart';

// class customTextFormField extends StatelessWidget {
//   final String? hintTextt;
//   final String? labelTextt;
//   final Icon? prefixIconn;
//   final Icon? suffixIconn;
//   final Color? iconColors;
//   final TextEditingController? controllerr;
//   final TextInputType? keyboardType;
//   final bool? obscurityy;
//   final MultiValidator validatorrr;

//   const customTextFormField({
//     super.key,
//     this.hintTextt,
//     this.labelTextt,
//     this.prefixIconn,
//     this.suffixIconn,
//     this.iconColors = const Color.fromARGB(255, 5, 65, 114),
//     this.controllerr,
//     this.keyboardType,
//     this.obscurityy = false,
//     required this.validatorrr,
//     // required this.validatorrr,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: TextFormField(
//         controller: controllerr,
//         obscureText: obscurityy!,
//         validator: validatorrr,
//         decoration: InputDecoration(
//             prefixIcon: prefixIconn,
//             prefixIconColor: iconColors,
//             suffixIcon: suffixIconn,
//             suffixIconColor: iconColors,
//             border: OutlineInputBorder(),
//             hintText: hintTextt,
//             labelText: labelTextt),
//         keyboardType: keyboardType,
//       ),
//     );
//   }
// }




//////////////////////////////////////////////////////////////////////////////////////////////

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class customTextFormField extends StatelessWidget {
  final String? hintTextt;
  final String? labelTextt;
  final Icon? prefixIconn;
  final Icon? suffixIconn;
  final Color? iconColors;
  final TextEditingController? controllerr;
  final TextInputType? keyboardType;
  final bool? obscurityy;
  final bool? readOnlyy;
  final String? Function(String?)? validatorrr;

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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controllerr,
        obscureText: obscurityy!,
        validator: validatorrr,
        readOnly: readOnlyy!,
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
