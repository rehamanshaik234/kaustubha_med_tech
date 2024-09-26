import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/review/review_provider.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/review_card.dart';
import 'package:provider/provider.dart';

class DoctorReviewsScreen extends StatefulWidget {
  const DoctorReviewsScreen({super.key});

  @override
  State<DoctorReviewsScreen> createState() => _DoctorReviewsScreenState();
}

class _DoctorReviewsScreenState extends State<DoctorReviewsScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getReviews();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBgColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 20.sp,
          ),
        ),
        title: Text('Reviews', style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 20.sp),),
      ),
      body: Consumer<ReviewProvider>(
          builder:(context,provider,_){
            if(provider.loader){
              return const Center(child: CircularProgressIndicator(color: Colors.black,),);
            }
            if(provider.reviews.isEmpty){
              return Center(child: Text('No Reviews Found',style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),);
            }
            return ListView.builder(
                itemCount: provider.reviews.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8.h ,horizontal: 12.w),
                    child: ReviewCard(review: provider.reviews[index]),
                  );
            });
          }),
    );
  }

  void getReviews()async{
    final user=await LocalDB.getUserInfo();
    context.read<ReviewProvider>().getDoctorReviews({'doctorId':user?.id}, (r){});
  }
}
