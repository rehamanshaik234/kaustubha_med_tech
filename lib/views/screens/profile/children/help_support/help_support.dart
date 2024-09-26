import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/review/review_provider.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/review_card.dart';
import 'package:provider/provider.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {


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
        title: Text('Help & Support', style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 20.sp),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
                title: Text('What is Kaustubha?',style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 16.h),
                    child: Text('Kaustubha is a specialized platform designed for pregnant women to book appointments with doctors and chat with them directly. It provides continuous access to medical professionals, ensuring that expectant mothers receive timely advice and support. '
                        'The platform is dedicated to promoting health and well-being during pregnancy.',style: GoogleFonts.dmSans(fontSize: 16.sp,color: Colors.black54),),
                  )
                ],
            ),
            ExpansionTile(
                title: Text('What payment methods are accepted?',style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 16.h),
                    child: Text('Kaustubha accepts a variety of payment methods to accommodate different preferences. You can use major credit and debit cards, PayPal, and other popular online payment systems. This flexibility ensures that you'
                        ' can choose the most convenient and secure payment option for you.',style: GoogleFonts.dmSans(fontSize: 16.sp,color: Colors.black54),),
                  )
                ],
            ),
            ExpansionTile(
                title: Text('How do I subscribe to a service on Kaustubha?',style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 16.h),
                    child: Text('To subscribe to a service on Kaustubha, visit the official website and sign up by creating an account. Follow the instructions to select the service you need, choose your preferred subscription plan, and complete the payment process.'
                        ' Once subscribed, you can easily book appointments and chat with doctors.',style: GoogleFonts.dmSans(fontSize: 16.sp,color: Colors.black54),),
                  )
                ],
            ),
            ExpansionTile(
              title: Text('Is customer support available 24/7?',style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 16.h),
                  child: Text('Yes, customer support on Kaustubha is available 24/7. This ensures that pregnant women can receive assistance at any time, day or night. Whether you have questions about appointments,'
                      ' need help with the platform, or require urgent support, our team is always ready to help.',style: GoogleFonts.dmSans(fontSize: 16.sp,color: Colors.black54),),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
