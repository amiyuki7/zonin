import 'package:flutter/material.dart';
import 'package:zonin/colors.dart';

class ZoninTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const ZoninTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
  });

  @override
  State<ZoninTextField> createState() => _ZoninTextFieldState();
}

class _ZoninTextFieldState extends State<ZoninTextField> {
  final FocusNode _focusNode = FocusNode();
  Color _fillColor = jetGray;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _fillColor = _focusNode.hasFocus ? focusText : jetGray;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      cursorHeight: 15,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        isDense: true,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          fontSize: 16,
        ),
        fillColor: _fillColor,
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 3, color: accentPurple2),
        ),
        focusColor: focusText,
      ),
    );
  }
}
