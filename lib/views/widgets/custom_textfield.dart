import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
class CustomTextField extends StatefulWidget {
  CustomTextField({super.key,required this.hintText,this.isPassword=false,this.inputType=TextInputType.text,
    required this.textEditingController,this.focusNode,this.onEditingCompleted,this.onChange,this.readOnly,this.outlinedBorder,this.includeSpacing});
  String hintText;
  bool isPassword;
  TextInputType inputType;
  TextEditingController textEditingController;
  FocusNode? focusNode;
  VoidCallback? onEditingCompleted;
  Function(String?)? onChange;
  bool? readOnly;
  bool? outlinedBorder;
  bool? includeSpacing;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword=true;
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.textEditingController,
        keyboardType: widget.inputType,
        obscureText: widget.isPassword? showPassword : false,
        focusNode: widget.focusNode,
        readOnly: widget.readOnly!=null?widget.readOnly ?? false :false,
        onEditingComplete: widget.onEditingCompleted,
        onChanged: (text){
          if(widget.includeSpacing==null || widget.includeSpacing==false) {
            int cursorPosition = widget.textEditingController.selection
                .baseOffset;
            String newText = text.replaceAll(" ", "");
            widget.textEditingController.text = newText;
            cursorPosition =
            cursorPosition <= newText.length ? cursorPosition : newText.length;
            widget.textEditingController.selection = TextSelection.fromPosition(
              TextPosition(offset: cursorPosition),);
            if (widget.onChange != null) {
              widget.onChange!(newText);
            }
          }
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          focusColor: Colors.black,
          hintStyle: GoogleFonts.inter(color: Colors.black54),
          hoverColor: Colors.grey,
          border: widget.outlinedBorder==true?OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26,width: 2.w),
            borderRadius: BorderRadius.circular(12.sp)
          ):null,
          suffixIcon: widget.isPassword? IconButton(onPressed: (){
            setState(() {
              showPassword=!showPassword;
            });
          }, icon: Icon(!showPassword? CupertinoIcons.eye_solid:CupertinoIcons.eye_slash )):null
        ),
    );
  }
}
