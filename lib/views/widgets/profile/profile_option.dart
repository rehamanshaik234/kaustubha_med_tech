import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class ProfileOption extends StatelessWidget {
  late IconData icon;
  late String title;
  late VoidCallback onTap;
  ProfileOption({super.key,required this.title,required this.icon,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon,size: 20.sp,color: Colors.black54,),
              SizedBox(width: 8.w,),
              Text(title,style: GoogleFonts.dmSans(fontSize: 18.sp,color: Colors.black54),),
              const Spacer(),
              Icon(CupertinoIcons.forward,size: 20.sp,color: Colors.black26,)
            ],
          ),
          SizedBox(height: 8.h,),
          Divider(color: Colors.black12,height: 1.h,)
        ],
      ),
    );
  }
}
