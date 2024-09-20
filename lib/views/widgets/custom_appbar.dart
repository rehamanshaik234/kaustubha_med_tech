import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';

import '../../utils/app_colors/app_colors.dart';
import '../../utils/constants/asset_urls.dart';
class CustomAppbar {
  static AppBar appBar(BuildContext context,{PreferredSize? bottom}){
    return AppBar(
      backgroundColor: AppColors.scaffoldBgColor,
      leading: InkWell(
        onTap: ()=>Navigator.pushNamed(context,RoutesName.profile),
        child: Padding(
          padding:  EdgeInsets.only(left: 12.w),
          child: Image(image: AssetImage(AssetUrls.profile)),
        ),
      ),
      centerTitle: false,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Good Morning",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),)
        ],
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.grey,size: 24.sp,)),
      ],
      bottom: bottom,
    );
  }
}
