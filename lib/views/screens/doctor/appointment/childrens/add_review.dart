import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/views/alerts/book_appointment.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/routes/route_names.dart';
import '../../../../widgets/custom_button.dart';
class AddReview extends StatefulWidget {
  const AddReview({super.key});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  int score=0;
  TextEditingController title=TextEditingController();
  TextEditingController review=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldBgColor,
        leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.black,size: 20.sp,)),
        title: Text("Add Review",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Divider(height: 2.h,color: Colors.grey.shade400,),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cancel',style: GoogleFonts.roboto(color: Colors.black54,fontSize: 16.sp),),
                      CustomButton(onPressed: (){}, title: "Post",width: 60.w,padding: 0,height: 30.h,)
                    ],
                  ),
                  SizedBox(height: 16.h,),
                  Text('Score:',style: GoogleFonts.roboto(color: Colors.black54,fontSize: 16.sp),),
                  SizedBox(height: 4.h,),
                  Row(
                    children: [
                      SizedBox(width: 8.w,),
                      InkWell(onTap: ()=>setState(() { score=1;}), child: Icon(score>=1? Icons.star_outlined:Icons.star_outline_outlined, size: 30.sp,)),
                      SizedBox(width: 8.w,),
                      InkWell(onTap: ()=>setState(() { score=2;}), child: Icon(score>=2? Icons.star_outlined:Icons.star_outline_outlined, size: 30.sp,)),
                      SizedBox(width: 8.w,),
                      InkWell(onTap: ()=>setState(() { score=3;}), child: Icon(score>=3? Icons.star_outlined:Icons.star_outline_outlined, size: 30.sp,)),
                      SizedBox(width: 8.w,),
                      InkWell(onTap: ()=>setState(() { score=4;}), child: Icon(score>=4? Icons.star_outlined:Icons.star_outline_outlined, size: 30.sp,)),
                      SizedBox(width: 8.w,),
                      InkWell(onTap: ()=>setState(() { score=5;}), child: Icon(score>=5? Icons.star_outlined:Icons.star_outline_outlined, size: 30.sp,)),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: CustomTextField(hintText: "Title", textEditingController: title,outlinedBorder: true,border: InputBorder.none,includeSpacing: true,),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: CustomTextField(hintText: "Review", textEditingController: review,outlinedBorder: true,border: InputBorder.none,lines: 8,includeSpacing: true,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
