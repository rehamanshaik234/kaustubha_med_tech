import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/views/alerts/logout_popup.dart';
import 'package:kaustubha_medtech/views/widgets/profile/profile_option.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_colors/app_colors.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,provider,child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBgColor,
            elevation: 0,
            leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back_rounded,
              color: Colors.black,size: 20.sp,)),
            title: Text('Profile',style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
          ),
          body: SizedBox(
            width: 1.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(75.sp),
                    child: Image(image: AssetImage(AssetUrls.profile),fit: BoxFit.cover,height: 150.h,width: 150.w,),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(provider.user.name ?? '',style: GoogleFonts.dmSans(fontSize: 16.sp,fontWeight: FontWeight.w700),),
                  Text(provider.user.phone ?? '',style: GoogleFonts.dmSans(fontSize: 14.sp,fontWeight: FontWeight.w400),),
                  SizedBox(height: 32.h,),
                  ProfileOption(title: "Edit Profile", icon: CupertinoIcons.person, onTap: ()=>Navigator.of(context,rootNavigator: true).pushNamed(RoutesName.editProfile)),
                  SizedBox(height: 24.h,),
                  ProfileOption(title: "Notifications", icon: Icons.notifications_none, onTap: ()=>Navigator.of(context,rootNavigator: true).pushNamed(RoutesName.notifications)),
                  SizedBox(height: 24.h,),
                  ProfileOption(title: "Help and Support", icon: Icons.live_help_outlined, onTap: (){}),
                  SizedBox(height: 24.h,),
                  ProfileOption(title: "Terms and Conditions", icon: Icons.security_outlined, onTap: (){}),
                  SizedBox(height: 24.h,),
                  ProfileOption(title: "Logout", icon: Icons.login_outlined, onTap: (){
                    LogoutPopup.showLogout(context,()async{
                      await LocalDB.logout();
                      Navigator.of(context,rootNavigator: true).pushNamedAndRemoveUntil(RoutesName.login, (r)=>false);
                    });
                  }),

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
