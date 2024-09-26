import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/doctor/patients.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import 'package:kaustubha_medtech/models/chat/ContactInfo.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_options.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/asset_urls.dart';
import '../../../alerts/custom_alerts.dart';

class DoctorPatientsScreen extends StatefulWidget {
  const DoctorPatientsScreen({super.key});

  @override
  State<DoctorPatientsScreen> createState() => _DoctorPatientsScreenState();
}

class _DoctorPatientsScreenState extends State<DoctorPatientsScreen> with SingleTickerProviderStateMixin {
  TextEditingController search=TextEditingController();
  TrackerOption selectedOption=TrackerOption.pulse;
  late TabController tabController;
  int selectedTab=1;
  UserInfo? userInfo;

@override
  void initState() {
   tabController=TabController(length: 3, vsync: this);
   WidgetsBinding.instance.addPostFrameCallback((_){
     getPatients();
   });
   // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBgColor,
        leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.black,size: 20.sp,)),
        title: Text("Patients",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 8.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Card(
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(width: 8.w,),
                  Icon(Icons.search,color: Colors.grey,size: 20.sp,),
                  SizedBox(width: 8.w,),
                  SizedBox(
                    width: 1.sw*0.7,
                    child: TextField(
                      controller: search,
                      onChanged: (t){
                        search.text=t;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          hintText: "Search Patient..",
                          border: InputBorder.none,
                          hintStyle:GoogleFonts.inter(color: Colors.grey,fontSize: 14.sp)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h,),
          Consumer<DoctorPatientsProvider>(
              builder: (context,provider,child){
                List<UserInfo> patients=[];
                if(provider.loader && !provider.isPatientsFetched){
                  return SizedBox(height: 1.sh*0.7, child: const Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.black,),));
                }
                if(provider.errorMessage.isNotEmpty){
                  return SizedBox(height: 1.sh*0.7, child: Center(child: Text(provider.errorMessage,style: GoogleFonts.dmSans(color: Colors.black54,fontSize: 16.sp),),));
                }
                if(search.text.isNotEmpty) {
                  patients.clear();
                  patients.addAll(provider.patients.where((patient) {
                    return patient.name?.toLowerCase().startsWith(search.text.toLowerCase()) == true && !patients.contains(patient);
                  }));
                }
                if(provider.patients.isEmpty ||(search.text.isNotEmpty && patients.isEmpty)){
                  return SizedBox(height: 1.sh*0.7, child: const Center(child: Text("No Patients Found"),));
                }
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: ()async{
                      await getPatients(showPopUp: true);
                    },
                    child: ListView.builder(
                        itemCount:search.text.isNotEmpty? patients.length: provider.patients.length,
                        itemBuilder: (context,index){
                         return patientCard(search.text.isNotEmpty?patients[index]:provider.patients[index], index);
                        }),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Future<void> getPatients({bool? showPopUp})async{
     DoctorPatientsProvider provider=Provider.of<DoctorPatientsProvider>(context,listen: false);
     userInfo= await LocalDB.getUserInfo();
       await provider.getPatientsList((r){
         if(r.data!=null && showPopUp==true) {
           CustomPopUp.showFToast(context, "Patients Updated");
         }
       });
  }

  Widget patientCard(UserInfo patientDet, int index){
    return Container(
      margin: index==(index+1)? EdgeInsets.only(bottom: 50.h):EdgeInsets.zero,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.sp),
                      child: Image(image:patientDet.image!=null?NetworkImage(patientDet.image): AssetImage(AssetUrls.profile),
                        height: 100.h,width: 100.w,fit: BoxFit.cover,)),
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(patientDet.name ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
                            SizedBox(width: 4.w,),
                            Visibility(
                                visible: patientDet.numberVerified==true,
                                child: Icon(Icons.check_circle,color: Colors.green,size: 20.sp,))
                          ],
                        ),
                        SizedBox(height: 4.h,),
                        Text(patientDet.email ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                        SizedBox(height: 4.h,),
                        Text(patientDet.phone ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                        SizedBox(height: 4.h,),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 8.h,),
              Divider(color: Colors.grey.shade400,height: 2.h,),
              SizedBox(height: 8.h,),
              Row(
                children: [
                  Expanded(child: CustomButton(onPressed: (){
                    Navigator.of(context,rootNavigator: true).pushNamed(RoutesName.doctorChat,arguments: ContactInfo(name:patientDet.name,doctorId: userInfo?.id,
                        userId: patientDet.id,doctorName: userInfo?.name).toJson());
                  }, title: "Message",textSize: 14.sp,borderRadius: BorderRadius.circular(20.sp),
                    bgColor: AppColors.buttonSecondaryBgColor,textColor: AppColors.primaryColor,)),
                  SizedBox(width: 16.w,),
                  Expanded(child: CustomButton(onPressed: (){
                    Provider.of<TrackerProvider>(context,listen: false).getPatientTracker((response){},userId: patientDet.id);
                    Navigator.of(context,rootNavigator: true).pushNamed(RoutesName.tracker,arguments: patientDet.toJson());
                  }, title: "See Details",textSize: 14.sp,borderRadius: BorderRadius.circular(20.sp),)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


}
