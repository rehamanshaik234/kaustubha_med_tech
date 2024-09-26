import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_text_field/phone_text_field.dart';

import '../alerts/custom_alerts.dart';

class PhoneNumberTextField extends StatefulWidget {
   PhoneNumberTextField({super.key,required this.hintText,this.isPassword=false,this.inputType=TextInputType.text,
    required this.initialValue,this.focusNode,this.onEditingCompleted,this.onChange,this.readOnly,
    this.outlinedBorder,this.includeSpacing,this.border,this.lines=1,this.outlineColor,this.fillColor,this.onTap,this.onSubmit,this.suffix,this.textInputAction});

  String hintText;
  GlobalKey? phoneTextFieldKey;
  bool isPassword;
  TextInputType inputType;
  String? initialValue;
  FocusNode? focusNode;
  VoidCallback? onEditingCompleted;
  Function(PhoneNumber?)? onChange;
  bool? readOnly;
  bool? outlinedBorder;
  bool? includeSpacing;
  Color? outlineColor;
  InputBorder? border;
  int lines;
  VoidCallback? onTap;
  Color? fillColor;
  Function(String)? onSubmit;
  Widget? suffix;
  TextInputAction? textInputAction;
  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {

  PhoneNumber? phoneNumber;
  @override
  Widget build(BuildContext context) {
    return PhoneTextField(
      locale: const Locale('en'),
      decoration: InputDecoration(
        hintText: widget.hintText,
        focusColor: Colors.black,
        hintStyle: GoogleFonts.inter(color: Colors.black54),
        hoverColor: Colors.grey,
        fillColor: widget.fillColor,
        border: widget.outlinedBorder == true
            ? widget.border ??
            OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26, width: 2.w),
              borderRadius: BorderRadius.circular(12.sp),
            )
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 12.0.h), // Adjust padding for alignment
        isDense: true, // Reduces the vertical space in the field, keeping the components more compact
      ),
      textStyle: GoogleFonts.dmSans(fontSize: 16.sp),
      showCountryCodeAsIcon: true,
      searchFieldInputDecoration: const InputDecoration(
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(),
        ),
        suffixIcon: Icon(Icons.search),
        hintText: "Search country",
      ),
      initialValue: widget.initialValue,
      initialCountryCode: "IN",
      onSubmit: (text) {
        if (widget.onSubmit != null) {
          widget.onSubmit!((phoneNumber?.countryCode ?? '') + text);
        }
      },
      onChanged: (number) {
        phoneNumber = number;
        setState(() {});
        widget.onChange!(number);
      },
    );
  }
}
