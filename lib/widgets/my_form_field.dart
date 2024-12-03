import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

class MyTextField extends StatefulWidget {
  final String? hintText;
  final bool isPassword;
  final bool isPhoneNumber;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const MyTextField({
    super.key,
    this.hintText,
    this.isPassword = false,
    this.isPhoneNumber = false,
    this.controller,
    this.validator,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    if (widget.isPhoneNumber && widget.controller != null) {
      widget.controller!.text = '+998 ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: widget.isPassword ? _isObscured : false,
      keyboardType:
          widget.isPhoneNumber ? TextInputType.phone : TextInputType.text,
      inputFormatters: widget.isPhoneNumber
          ? [MaskedInputFormatter('+000 00 000-00-00')]
          : null,
      style: const TextStyle(
        fontSize: 12.0,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: 12.0,
          color: Colors.black.withOpacity(.5),
        ),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blueAccent, width: .5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey, width: .5),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 15,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
      cursorColor: Colors.blueAccent,
      validator: widget.validator,
    );
  }
}
