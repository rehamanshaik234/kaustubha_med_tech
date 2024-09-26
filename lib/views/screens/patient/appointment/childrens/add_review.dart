import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/views/alerts/book_appointment.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/routes/route_names/route_names.dart';
import '../../../../widgets/custom_button.dart';
class AddReview extends StatefulWidget {
  const AddReview({super.key});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  int rating=0;
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
      body: Consumer<PatientAppointmentProvider>(
        builder: (context,provider,_) {
          return Column(
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
                          InkWell(
                              onTap:()=>Navigator.pop(context),
                              child: Text('Cancel',style: GoogleFonts.roboto(color: Colors.black54,fontSize: 16.sp),)),
                          CustomButton(onPressed: ()=>addReview(provider), title: "Post",width: 60.w,padding: 0,height: 30.h,loader: provider.loader,)
                        ],
                      ),
                      SizedBox(height: 16.h,),
                      Text('Rating:',style: GoogleFonts.roboto(color: Colors.black54,fontSize: 16.sp),),
                      SizedBox(height: 4.h,),
                      Row(
                        children: [
                          SizedBox(width: 8.w,),
                          InkWell(onTap: ()=>setState(() { rating=1;}), child: Icon(rating>=1? Icons.star_outlined:Icons.star_outline_outlined, size: 30.sp,color: Colors.orangeAccent,)),
                          SizedBox(width: 8.w,),
                          InkWell(onTap: ()=>setState(() { rating=2;}), child: Icon(rating>=2? Icons.star_outlined:Icons.star_outline_outlined, size: 30.sp,color: Colors.orangeAccent,)),
                          SizedBox(width: 8.w,),
                          InkWell(onTap: ()=>setState(() { rating=3;}), child: Icon(rating>=3? Icons.star_outlined:Icons.star_outline_outlined, size: 30.sp,color: Colors.orangeAccent,)),
                          SizedBox(width: 8.w,),
                          InkWell(onTap: ()=>setState(() { rating=4;}), child: Icon(rating>=4? Icons.star_outlined:Icons.star_outline_outlined, size: 30.sp,color: Colors.orangeAccent,)),
                          SizedBox(width: 8.w,),
                          InkWell(onTap: ()=>setState(() { rating=5;}), child: Icon(rating>=5? Icons.star_outlined:Icons.star_outline_outlined, size: 30.sp,color: Colors.orangeAccent,)),
                        ],
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
          );
        }
      ),
    );
  }

 void addReview(PatientAppointmentProvider provider)async{
    if(rating==0){
      CustomPopUp.showSnackBar(context, "Please Select Ratings", Colors.redAccent);
      return;
    }
    if(review.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Please Enter Review Message", Colors.redAccent);
      return;
    }
    Map? appointmentData=ModalRoute.of(context)?.settings.arguments as Map?;
    Map<String,dynamic> data={
      'appointmentId': appointmentData!=null? appointmentData['id']:"",
      'rating':rating.toString(),
      'message':review.text
    };
    provider.addReview(data, (r){
      if(r.error==null){
        CustomPopUp.showSnackBar(context, "Added Review", Colors.green);
        Navigator.pop(context);
      }
    });
 }
}
