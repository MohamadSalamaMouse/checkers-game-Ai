import 'package:flutter/material.dart';

import '../constants.dart';

class AuthTextField extends StatefulWidget {
  final TextInputType keyboardType;
  final bool isPassword;
  final TextEditingController textController;
  final String labelText;
  final Widget? labelWidget;
  final String? Function(String?)? validation;
  final Widget? suffixWidget;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  final TextAlign textAlign;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool sameBorderAfterFocus;
  final bool autoFocus;
  final Color? labelColor;
  final Color fillColor;
  const AuthTextField({Key? key, this.autoFocus = false,required this.keyboardType, this.sameBorderAfterFocus = false,this.minLines,this.textAlign = TextAlign.start, this.onChanged,this.isPassword =false, this.labelWidget, required this.textController, required this.labelText, this.validation, this.suffixWidget, this.onFieldSubmitted, this.maxLines, this.floatingLabelBehavior = FloatingLabelBehavior.never, this.labelColor, this.fillColor = Colors.white,}) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isHidden= false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isHidden = widget.isPassword;
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFocus,
      textAlign: widget.textAlign,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines??1,
      minLines: widget.minLines??1,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: widget.keyboardType ,
      obscureText: isHidden,
      controller: widget.textController ,
      validator: (String? text){
        if(text! == '') {
          return "Please enter ${widget.labelText}";
        }
        if(widget.validation != null){
          return widget.validation!(text);
        }
        return null;
      },
      decoration: InputDecoration(
        floatingLabelBehavior: widget.floatingLabelBehavior,
        fillColor: widget.fillColor,
        filled: true,
        suffixIcon: widget.suffixWidget ??
            (widget.isPassword
                ? IconButton(
                    splashRadius: 7,
                    onPressed: () {
                      setState(
                        () {
                          isHidden = !isHidden;
                        },
                      );
                    },
                    icon: Icon(
                      !isHidden ? Icons.visibility : Icons.visibility_off,
                      color: const Color(0xFFA5ABB9),
                    ),
                  )
                : null),
        label: widget.labelWidget,
        labelText: widget.labelWidget == null ? widget.labelText : null,
        labelStyle: TextStyle(color: widget.labelColor,),
        contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
        enabledBorder:  getBorderStyle( const Color(0xFFCFD2D7),1),
        focusedBorder:  getBorderStyle( const Color(0xFFCFD2D7), widget.sameBorderAfterFocus ? 1 : 2),
        errorBorder: getBorderStyle(const Color(0xFFF22B2B),1),
        focusedErrorBorder:   getBorderStyle(Colors.red.shade900,2),
      ),
    );
  }
}
