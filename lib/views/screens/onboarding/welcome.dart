import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_outline_button.dart';
import 'package:kaustubha_medtech/views/widgets/logo.dart';

import '../../../controller/localdb/local_db.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool loader=true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getUserInfo();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: loader?const Center(child: CircularProgressIndicator(color: Colors.black,),): Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 1.sh*0.15),
            const LogoWidget(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text("Explore Kaustubha Medtech",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 32.sp),textAlign: TextAlign.center,)),
              ],
            ),
            SizedBox(height: 80.h),
            CustomButton(onPressed: (){
              Navigator.pushNamed(context, RoutesName.login);
            },title: "Sign In",),
            SizedBox(height: 24.h,),
            CustomOutlineButton(onPressed: (){
              Navigator.pushNamed(context, RoutesName.signUp);
            },title: "Create Account",),
            SizedBox(height: 80.h),

          ],
        ),
      ),
    );
  }

  void getUserInfo()async{
    bool isLogin=await LocalDB.getUserLogin();
    UserInfo? userInfo=await LocalDB.getUserInfo();
    if(isLogin && userInfo!=null){
      if(userInfo.role==Constants.patientRole){
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.patientMain, (r)=>false);
      }else {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.doctorMain, (r) => false);
      }
      return;
    }
    loader=false;
    setState(() {

    });
  }
}
