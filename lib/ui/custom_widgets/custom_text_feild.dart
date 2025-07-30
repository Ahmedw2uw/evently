import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFeild extends StatefulWidget {
  final String hint;
  final String? preFixIcon;
  final bool isPassword;
  final int minmumLines;
  final TextEditingController? controler;

  const CustomTextFeild({
    super.key,
    required this.hint,
    this.preFixIcon,
    this.isPassword = false,
    this.minmumLines = 1,
    this.controler,//* this to control of the text in te fealds 

  });

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: TextField(
          controller: widget.controler,//* this to control of the text that enterd in the feald+>used it in the uthentication
          maxLines: widget.isPassword ? 1 : widget.minmumLines,
          minLines: widget.minmumLines,
          decoration: InputDecoration(
            
            hintText: widget.hint,
            hintStyle:
                Theme.of(context)
                    .textTheme
                    .titleSmall, //* this used to acces in the theme class by contex =>text theme =>title small
                   
            prefixIcon:
                widget.preFixIcon == null
                    ? null
                    : SvgPicture.asset(widget.preFixIcon!),
            suffixIcon:
                widget.isPassword
                    ? InkWell(
                      onTap: () {
                        obscureText = !obscureText; //* change the (obscureText)
                        setState(() {});
                      },
                      child: Icon(
                        obscureText
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                      ), //* if true cipher false normal
                    )
                    : null,
            prefixIconConstraints: BoxConstraints(
              maxHeight: 24,
              maxWidth: 24,
            ), //* to assin the higit and width
          ),
          obscureText:
              widget.isPassword
                  ? obscureText
                  : false, //* this to sipher thext if true chipher not normal
        ),
      ),
    );
  }
}
