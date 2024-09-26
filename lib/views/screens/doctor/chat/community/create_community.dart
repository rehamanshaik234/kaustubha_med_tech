import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/chat/chat_provider.dart';
import 'package:kaustubha_medtech/controller/providers/doctor/patients.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import 'package:kaustubha_medtech/models/chat/CommunityModel.dart';
import 'package:kaustubha_medtech/models/chat/ContactInfo.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_outline_button.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_options.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/asset_urls.dart';
import '../../../../alerts/custom_alerts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CreateCommunity extends StatefulWidget {
  const CreateCommunity({super.key});

  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> with SingleTickerProviderStateMixin {

  TrackerOption selectedOption=TrackerOption.pulse;
  late TabController tabController;
  int selectedTab=1;
  UserInfo? userInfo;
  TextEditingController search=TextEditingController();
  TextEditingController communityName=TextEditingController();
  List<UserInfo> patients=[];
  IO.Socket? socket;
  bool loader=false;

  @override
  void initState() {
    tabController=TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_){
      getPatients();
      connectSocket();
    });
    // TODO: implement initState
    super.initState();
  }
  
  void connectSocket(){
    socket = IO.io('https://chatapi.kaustubhamedtech.com', IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect()  // Optional, disable auto-connect
        .build());
    socket?.connect();
    socket?.on('error', (resp){
      print(resp.toString());
    });

    socket?.on('communityCreated', (response)async{
      print(response.toString());
      if(response!=null){
        CommunityModel communityModel=CommunityModel.fromJson(response);
        context.read<ChatProvider>().addCommunity(communityModel);
        loader=false;
        setState(() {});
        if(Navigator.canPop(context)){
          Navigator.pop(context);
        }
        CustomPopUp.showFToast(context, "Created Community");
      }
    });
  }

  @override
  void dispose() {
    socket=null;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBgColor,
        leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.black,size: 20.sp,)),
        title: Text("Create Community",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: 1.sw,
                  child: TextField(
                    controller: communityName,
                    onChanged: (t){
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        hintText: "Community Name",
                        border: InputBorder.none,
                        hintStyle:GoogleFonts.inter(color: Colors.grey,fontSize: 14.sp)
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16.w,),
              Text('Add Patients',style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 18.sp),),
            ],
          ),
          SizedBox(height: 4.h,),
          SizedBox(
            width: 1.sw,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: patients.map((patient){
                  return Container(
                    margin:EdgeInsets.only(left:16.w),
                    height: 50.sp,
                    width: 50.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black54)
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25.sp),
                          child: Image(image: NetworkImage(patient.image,),fit: BoxFit.cover, height: 50.sp,
                            width: 50.sp,),
                        ),
                        Positioned(
                          right:0,
                            child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                            color: Colors.black54
                          ),
                          child: InkWell(
                              onTap:(){
                                patients.remove(patient);
                                setState(() {});
                              },
                              child: Icon(Icons.close,color: Colors.white,size: 16.sp,)),
                        ))
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
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
                if(provider.loader && !provider.isPatientsFetched){
                  return SizedBox(height: 1.sh*0.5, child: const Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.black,),));
                }
                if(provider.errorMessage.isNotEmpty){
                  return SizedBox(height: 1.sh*0.5, child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.warning_amber,color: Colors.orangeAccent,size: 25.sp,),
                      Text(provider.errorMessage,style: GoogleFonts.dmSans(color: Colors.black54,fontSize: 16.sp),textAlign: TextAlign.center,),
                      SizedBox(height: 4.h,),
                      CustomOutlineButton(onPressed: (){
                        getPatients();
                        connectSocket();
                      }, title: "↻ Retry",width: 80.w,textSize: 12.sp,padding: 0,height: 24.h,)
                    ],
                  ),));
                }
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: ()async{
                      await getPatients(showPopUp: true);
                    },
                    child: ListView.builder(
                        itemCount: provider.patients.length,
                        itemBuilder: (context,index){
                          return patientCard(provider.patients[index], index);
                        }),
                  ),
                );
              }),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(right: 16.w,left:16.w,bottom: 20.h),
        child: CustomButton(onPressed: createSocket, title: 'Create',loader: loader,),
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
    return Visibility(
      visible: search.text.isNotEmpty ? patientDet.name?.toLowerCase().startsWith(search.text.replaceAll(' ', '').toLowerCase()) ?? false:true,
      child: Container(
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
                          height: 50.h,width:50.w,fit: BoxFit.cover,)),
                    SizedBox(width: 8.w,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(patientDet.name ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 16.sp,color: Colors.black87),),
                        Text(patientDet.email ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                      ],
                    ),
                    Spacer(),
                    !patients.contains(patientDet)?
                    CustomButton(onPressed: (){
                      patients.add(patientDet);
                      setState(() {});
                    }, title: "Add +",width: 80.w,textSize: 14.sp,padding: 0,):
                    Icon(Icons.check_circle,color: Colors.green,size: 30.sp,),
                    SizedBox(width: 8.w,)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createSocket()async{
    if(validate()) {
      loader=true;
      setState(() {});
      UserInfo? userInfo = await LocalDB.getUserInfo();
      List<String> ids = [userInfo?.id ?? ''];
      for (var patient in patients) {
        ids.add(patient.id ?? '');
      }
      print({
        "communityMembers": ids,
        "newCommunityName": communityName.text
      });
      socket?.emit('createCommunity', {
        "communityMembers": ids,
        "newCommunityName": communityName.text
      });
    }
  }

  bool validate(){
    if(communityName.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Community Name", Colors.redAccent);
      return false;
    }
    if(patients.length<1){
      CustomPopUp.showSnackBar(context, "Add At Least 2 Patients", Colors.redAccent);
      return false;
    }
    return true;
  }

}
