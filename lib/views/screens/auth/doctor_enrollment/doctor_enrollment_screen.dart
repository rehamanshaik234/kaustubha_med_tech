import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/doctor_enrollment/doctor_enrollment.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorDetailsModel.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/forms/doctor_timeslots_details.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/forms/doctor_personal_details.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/forms/doctor_official_detail.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/enroll_stepper.dart';
import 'package:provider/provider.dart';

class DoctorEnrollmentScreen extends StatefulWidget {
  const DoctorEnrollmentScreen({super.key});

  @override
  State<DoctorEnrollmentScreen> createState() => _DoctorEnrollmentScreenState();
}

class _DoctorEnrollmentScreenState extends State<DoctorEnrollmentScreen> with SingleTickerProviderStateMixin{
  late PageController controller;
  GlobalKey<DoctorPersonalDetailsState> officialDetKey=GlobalKey<DoctorPersonalDetailsState>();
  GlobalKey<DoctorTimingSlotsDetailsState> timingDetailsKey=GlobalKey<DoctorTimingSlotsDetailsState>();
  GlobalKey<DoctorOfficialDetailsState> officialDetailsKey=GlobalKey<DoctorOfficialDetailsState>();
  bool isUpdate=false;
  int currentPage=0;
  DoctorDetailsModel? doctorDetails;

  @override
  void initState() {
    controller=PageController(initialPage: 0);
    WidgetsBinding.instance.addPostFrameCallback((_){
      checkIsUpdate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DoctorEnrollmentProvider,UserProvider>(
      builder: (context,enrollProvider,userProvider,child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text('Doctor Enrollment',style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,
                fontSize: 20.sp),),
            bottom: PreferredSize(preferredSize: Size(1.sw, 40.h), child: EnrollStepper(currentIndex: currentPage,onTap: navToPage,ignore: userProvider.doctorDetails.id==null,)),
          ),
          body: isUpdate && userProvider.doctorDetailLoader? Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.black,strokeWidth: 2.w,),):
          SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: PageView(
                onPageChanged: (page){
                  currentPage=page;
                  setState(() {});
                },
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
                       DoctorPersonalDetails(validFields: (val){},key: officialDetKey,doctorDetails: doctorDetails,),
                       DoctorTimingSlotsDetails(key: timingDetailsKey,doctorDetails: doctorDetails,),
                       DoctorOfficialDetails(key: officialDetailsKey,doctorDetails: doctorDetails,),
                   ]
            ),
          ),
          bottomSheet: Padding(
            padding: EdgeInsets.only(left:16.sp,bottom:24.h,right: 16.w),
            child: CustomButton(onPressed:()=>validateFields(enrollProvider,userProvider), title: currentPage==2?"Save" :'Next',loader: userProvider.loader||enrollProvider.loader,),
          ),
        );
      }
    );
  }


  void validateFields(DoctorEnrollmentProvider enrollProvider,UserProvider userProvider)async{
    if (currentPage == 0) {
      bool isValid = officialDetKey.currentState?.validateFields() ?? false;
      if (isValid && !isUpdate) {
        await Future.wait([userProvider.updateUserProfilePic(enrollProvider.profilePic, (rep)=>onPersonalDetResponse(rep,userProvider,enrollProvider)),
            enrollProvider.enrollPersonalDetails((rep)=>onPersonalDetResponse(rep,userProvider,enrollProvider))
        ]);
      }else if(isValid && isUpdate){
        if(enrollProvider.profilePic!=null) {
          await Future.wait([
            userProvider.updateUserProfilePic(enrollProvider.profilePic, (rep) => onPersonalDetResponse(rep, userProvider, enrollProvider)),
            enrollProvider.updatePersonalDetails((rep) => onPersonalDetResponse(rep, userProvider, enrollProvider))
          ]);
        }else{
          await enrollProvider.updatePersonalDetails((rep) =>
                onPersonalDetResponse(rep, userProvider, enrollProvider));
        }
      }
    }else if(currentPage==1){
      bool isValid= timingDetailsKey.currentState?.validateFields() ?? false;
      if (isValid && !isUpdate){
         await enrollProvider.enrollTimingDetails(onTimingDetailsResp);
      } else if(isValid && isUpdate){
         await enrollProvider.updateTimingDetails(onTimingDetailsResp);
      }
    }else {
      bool isValid= officialDetailsKey.currentState?.validateFields() ?? false;
      if (isValid && !isUpdate) {
        await enrollProvider.enrollCertificateAndLicense(onCertificateResp);
      }else if(isValid && isUpdate){
        await enrollProvider.updateCertificateAndLicense(onCertificateResp);
      }
    }
  }

  void changePage(int page){
    if(page<=2){
      controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }else{
      controller.animateToPage(0,duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  void navToPage(int page){
    controller.animateToPage(page, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void onPersonalDetResponse(ResponseMessage rep,UserProvider user, DoctorEnrollmentProvider enroll){
    if(rep.error==null && !user.loader && !enroll.loader){
      CustomPopUp.showSnackBar(context, "${!isUpdate? "Added":"Updated"} SuccessFully", Colors.green);
      navToPage(1);
    }else if(rep.error!=null && user.loader && enroll.loader){
      CustomPopUp.showSnackBar(context, rep.error ?? "", Colors.redAccent);
    }
  }

  void onTimingDetailsResp(ResponseMessage rep){
    if(rep.error!=null){
      CustomPopUp.showSnackBar(context, rep.error ?? "", Colors.redAccent);
    }else{
      CustomPopUp.showSnackBar(context, rep.message ?? "Added SuccessFully", Colors.green);
      navToPage(2);
    }
  }

  void onCertificateResp(ResponseMessage rep){
    if(rep.error!=null){
      CustomPopUp.showSnackBar(context, rep.error ?? "", Colors.redAccent);
    }else{
      CustomPopUp.showSnackBar(context, rep.message?? "Added SuccessFully", Colors.green);
      if(!isUpdate) {
        Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
            RoutesName.doctorMain, (r) => false);
      }else{
        Navigator.of(context).pop();
      }
    }
  }

  void getDoctorEnrollmentInfo() {
    UserProvider provider=Provider.of<UserProvider>(context,listen: false);
    if(provider.enrollStatus.profile==true && provider.enrollStatus.availability==true){
      navToPage(2);
    }else if(provider.enrollStatus.profile==true &&provider.enrollStatus.availability!=true ){
      navToPage(1);
    }
  }

  void checkIsUpdate()async{
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    if(data==null){
      getDoctorEnrollmentInfo();
    }else{
      UserInfo? user=await LocalDB.getUserInfo();
      Provider.of<UserProvider>(context,listen: false).getDoctorDetails(user?.id ?? "",onResponse);
      isUpdate=true;
      setState(() {});
    }
  }

  void onResponse(ResponseMessage response){
    DoctorDetailsModel doctorDetails= Provider.of<UserProvider>(context,listen: false).doctorDetails;
    if(response.error==null && doctorDetails.id!=null){
     this.doctorDetails=doctorDetails;
     setState(() {});
    }
  }
}
