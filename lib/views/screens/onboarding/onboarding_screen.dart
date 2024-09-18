import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_circular_progress.dart';
import 'package:kaustubha_medtech/views/widgets/logo.dart';

import '../../../controller/localdb/local_db.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController=PageController(initialPage: 0);
  int currentPage=0;
  bool loader=true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      checkIsShown();
    });
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return loader?const Center(child: CircularProgressIndicator(color: Colors.black,),): SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: Stack(
        children: [
          PageView(
             controller: pageController,
              onPageChanged: (page){
               setState(() {
                 currentPage=page;
               });
              },
              children: [
                PageContent(imageUrl: AssetUrls.onboardingImg1,title: "Welcome to Kaustubha.",content: 'Shaping the future of health with breakthrough innovations that promote physical, mental, and spiritual wellness',currentPage: 0,),
                PageContent(imageUrl: AssetUrls.onboardingImg2,title: "Innovation In Every Pulse",content: 'Bhrunomatra: Smart Wearable Pregnancy Monitoring Device',currentPage: 1,),
                PageContent(imageUrl: AssetUrls.onboardingImg3,title: "Convenient Pass Management",content: 'Continuous monitoring of pregnancy, Helps in partograph charting, Nonstress test (NST) and Contraction stress test (CST)',currentPage: 2,),
                PageContent(showButton: true, imageUrl: AssetUrls.onboardingImg4,title: "Hassle-Free Entry and Exit",content: 'This tool Helps Continuous monitoring of pregnancy, Helps in partograph charting, Nonstress test (NST) and Contraction stress test (CST) and many more things',onPressed: skip,currentPage: 3,),
              ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Padding(
                padding:  EdgeInsets.all(16.sp),
                child: SizedBox(
                  width: 1.sw-32.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentPage==0?SizedBox(
                        width: 70.w,
                          height: 40.h,
                          child: TextButton(onPressed: skip, child: Text("Skip",style: GoogleFonts.inter(color: Colors.grey,fontSize: 18.sp),))):SizedBox(width: 70.w,height: 40.h,),
                      SizedBox(
                        child: Row(
                          children: [
                            DotWidget(currentPage: currentPage,index: 0,),
                            DotWidget(currentPage: currentPage,index: 1,),
                            DotWidget(currentPage: currentPage,index: 2,),
                            DotWidget(currentPage: currentPage,index: 3,),
                          ],
                        ),
                      ),
                      currentPage!=3?SizedBox(
                        width: 70.w,height: 40.h,
                        child: TextButton(onPressed: (){
                          if(currentPage<3){
                            pageController.jumpToPage(currentPage+1);
                          }else{
                            skip();
                          }
                        }, child: Text("Next",style: GoogleFonts.inter(color: Colors.black,fontSize: 18.sp),)),
                      ):SizedBox(width: 70.w,height: 40.h,),
                    ],
                  ),
                ),
              ) ),
        ],
      ),
    );
  }


  void skip(){
    LocalDB.setShownBoarding(true);
    Navigator.pushNamed(context, RoutesName.welcome);
  }

  void checkIsShown()async{
    bool isShown=await LocalDB.getShownBoarding();
    if(isShown){
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.welcome, (r)=>false);
      await LocalDB.setShownBoarding(true);
      return;
    }
    loader=false;
    setState(() {

    });
  }
}


class PageContent extends StatelessWidget {
  late String imageUrl;
  late String title;
  late String content;
  late bool showButton;
  VoidCallback? onPressed;
  int currentPage;
  PageContent({super.key,required this.imageUrl,required this.title,required this.content, this.showButton=false,this.onPressed,this.currentPage=0});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 16.sp),
        child: SizedBox(
          width: 1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:EdgeInsets.only(top: 24.h,left: 16.w,bottom: 12.h),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LogoWidget(),
                  ],
                ),
              ),
              SizedBox(height:currentPage==1 || currentPage==2? 1.sh*0.1:1.sh*0.125),
              Image(image: AssetImage(imageUrl,),fit: BoxFit.contain),
              SizedBox(height: 8.h,),
              Text(title,style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24.sp),textAlign: TextAlign.center,),
              SizedBox(height: 12.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 24.0.w),
                child: Text(content,style: GoogleFonts.inter(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14.sp),textAlign: TextAlign.center,),
              ),
              Visibility(
                visible: showButton,
                  child: Padding(
                    padding: EdgeInsets.only(top:1.sh*0.05,left: 24.sp,right: 24.sp,bottom: 24.sp),
                    child: CustomButton(onPressed: onPressed ?? (){}, title: "Get Started"),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DotWidget extends StatelessWidget {
  int currentPage;
  int index;
  DotWidget({super.key,required this.currentPage,required this.index});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width:10.h,
      height: 10.h,
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
          color:currentPage==index? Colors.black:Colors.black12,
          borderRadius: BorderRadius.circular(8)
      ),
    );
  }
}


