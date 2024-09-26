import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/chat/chat_provider.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/models/chat/CommunityModel.dart';
import 'package:kaustubha_medtech/models/chat/ContactInfo.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/constants/asset_urls.dart';
import '../../../widgets/custom_textfield.dart';
class PatientContactList extends StatefulWidget {
  const PatientContactList({super.key});

  @override
  State<PatientContactList> createState() => _PatientContactListState();
}

class _PatientContactListState extends State<PatientContactList> {
  String selectedOption='Chat';
  List<String> options=['Chat','Community'];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getContactList();
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,provider,child) {
        return Scaffold(
          appBar: CustomAppbar.patientAppBar(context,profilePicPath: provider.user.image),
          body: Column(
            children: [
              SizedBox(height: 8.h,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 12.w,),
                    optionsCard("Private Chat", options[0], AssetUrls.communityIcon, EdgeInsets.only(right: 8.w)),
                    optionsCard("Joined Community", options[1], AssetUrls.communityIcon, EdgeInsets.only(right: 8.w))
                  ],
                ),
              ),
              SizedBox(height: 16.h,),
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.sp)
                ),
                padding: EdgeInsets.symmetric(horizontal:  12.sp),
                margin: EdgeInsets.symmetric(horizontal: 12.sp),
                child: CustomTextField(
                  hintText: "Enter Message",
                  includeSpacing: true,
                  textEditingController: TextEditingController(),
                  outlinedBorder: true,
                  border: InputBorder.none,
                  suffix: InkWell(child: Icon(CupertinoIcons.search,size: 20.sp,),onTap: (){},),
                ),
              ),
              SizedBox(height: 8.h,),
              Expanded(
                child: Consumer<ChatProvider>(
                  builder: (context,provider,child) {
                    if(provider.loader){
                      return Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.black,strokeWidth: 2.sp,),);
                    }
                    if(selectedOption==options[0]) {
                      if(provider.contacts.isEmpty){
                        return Center(child: Text('No Chats Found',style: GoogleFonts.dmSans(fontSize: 16.sp,fontWeight: FontWeight.w500),),);
                      }
                      return ListView.builder(
                          itemCount: provider.contacts.length,
                          itemBuilder: (context, i) {
                            ContactInfo info = provider.contacts[i];
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.sp),
                              child: InkWell(
                                onTap: () =>
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed(RoutesName.doctorChat,
                                        arguments: info.toJson()),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.sp),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .end,
                                      children: [
                                        SizedBox(
                                          height: 50.sp,
                                          width: 50.sp,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                25.sp),
                                            child: Image(image: AssetImage(
                                                AssetUrls.doctorProfile)),
                                          ),
                                        ),
                                        SizedBox(width: 8.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(info.doctorName ?? "",
                                              style: GoogleFonts.dmSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp),),
                                            Text(info.mode ?? "",
                                              style: GoogleFonts.dmSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14.sp),),
                                          ],
                                        ),
                                        Spacer(),
                                        Text(info.time ?? "")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }else{
                      if(provider.communities.isEmpty){
                        return Center(child: Text('No Communities Found',style: GoogleFonts.dmSans(fontSize: 16.sp,fontWeight: FontWeight.w500),),);
                      }
                      return ListView.builder(
                          itemCount: provider.communities.length,
                          itemBuilder: (context,i){
                            CommunityModel info=provider.communities[i];
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.sp),
                              child: InkWell(
                                onTap: ()=>Navigator.of(context,rootNavigator: true).pushNamed(RoutesName.communityChat,arguments: info.toJson()),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.sp),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 50.sp,
                                          width: 50.sp,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(25.sp),
                                            child: CircleAvatar(
                                                 radius: 25.sp,
                                                 backgroundColor: AppColors.secondaryColor,
                                                child: Icon(CupertinoIcons.group_solid,color: Colors.black54,size: 35.sp,)),
                                          ),
                                        ),
                                        SizedBox(width: 8.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(info.communityName ?? "",style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),
                                            Text(info.type ?? "",style: GoogleFonts.dmSans(fontWeight: FontWeight.normal,fontSize: 14.sp),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  }
                ),
              ),
              SizedBox(height: 60.h,)
            ],
          ),
        );
      }
    );
  }

  void getContactList()async{
    ChatProvider provider=context.read<ChatProvider>();
    UserInfo? user=await LocalDB.getUserInfo();
    provider.getContactLists({'role':user?.role,'userId':user?.id}, (r){});
  }

  void getCommunities()async{
    ChatProvider provider=context.read<ChatProvider>();
    UserInfo? user=await LocalDB.getUserInfo();
    provider.getCommunities({'userId':user?.id}, (r){});
  }

  Widget optionsCard(String title,String option,String assetUrl,EdgeInsets margin,{double? imageHeight}){
    return InkWell(
      onTap: (){
        if(selectedOption!=option){
          if(option==options[0]){
            getContactList();
          }else{
            getCommunities();
          }
        }
        selectedOption=option;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: selectedOption==option? AppColors.primaryColor:Colors.transparent),
            borderRadius: BorderRadius.circular(25.sp),
            color: selectedOption==option?AppColors.secondaryColor:Colors.white
        ),
        padding: EdgeInsets.symmetric(horizontal:  8.sp,vertical: 4.h),
        margin: margin,
        child: Row(
          children: [
            Image(image: AssetImage(assetUrl),height: imageHeight,),
            SizedBox(width: 8.w,),
            Text(title,style: GoogleFonts.dmSans(color: Colors.black87,fontSize: 16.sp,),),
          ],
        ),
      ),
    );
  }
}
