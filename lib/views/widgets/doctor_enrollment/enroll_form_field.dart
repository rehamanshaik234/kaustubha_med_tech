import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_textfield.dart';
class EnrollFormField extends StatefulWidget {
  EnrollFormField({super.key,required this.controller,required this.title,required this.hint,this.inputType,this.isDate,this.validator,this.focusNode});
  late TextEditingController controller;
  late String title;
  late String hint;
  late TextInputType? inputType;
  bool? isDate;
  String? Function(String?)? validator;
  FocusNode? focusNode;

  @override
  State<EnrollFormField> createState() => _EnrollFormFieldState();
}

class _EnrollFormFieldState extends State<EnrollFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.title,style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),
            ],
          ),
          SizedBox(height: 8.h,),
          CustomTextField(hintText: widget.hint, textEditingController: widget.controller,outlinedBorder: true,
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54), borderRadius: BorderRadius.circular(8.sp),),inputType: widget.inputType ?? TextInputType.text,
          onTap:widget.isDate==true?showDate:(){},readOnly: widget.isDate,
          validator: widget.validator,focusNode: widget.focusNode,)
        ],
      ),
    );
  }

  void showDate(){
    showDatePicker(
        context: context,
        helpText: "Date of Birth",
        initialDate:DateTime.utc(1995) ,
        firstDate: DateTime.utc(1990),
        lastDate: DateTime.utc(2010)).then((val){
          if(val!=null && widget.isDate==true){
            widget.controller.text=val.toString().substring(0,10);
            setState(() {});
          }
    });
  }



}
