import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
class LogoWidget extends StatelessWidget {
   LogoWidget({super.key,this.width,this.height});
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(AssetUrls.logo),fit: BoxFit.contain,height: height,width: width,);
  }
}
