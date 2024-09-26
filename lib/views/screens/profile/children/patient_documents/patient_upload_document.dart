import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_home.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorDetailsModel.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/models/patient_document/PatientDocuments.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/file_viewer_modal.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/enroll_form_field.dart';
import 'package:kaustubha_medtech/views/widgets/dotted_box.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../../../controller/providers/doctor_enrollment/doctor_enrollment.dart';
import '../../../../widgets/custom_button.dart';
class PatientUploadDocuments extends StatefulWidget {
  PatientUploadDocuments({super.key});

  @override
  State<PatientUploadDocuments> createState() => PatientUploadDocumentsState();
}

class PatientUploadDocumentsState extends State<PatientUploadDocuments> {
  PatientDocumentsModel? documentDetails;
  File? file1;
  File? file2;
  bool isRemoveFile1=false;
  bool isRemoveFile2=false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      checkIsUpdate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBgColor,
        leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.black,size: 20.sp,)),
        title: Text("Documents",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: SingleChildScrollView(
          child: SizedBox(
            width: 1.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25.h,),
                SizedBox(
                  height: 160.sp,
                  width: 180.sp,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 10.sp,
                          right: 10.sp,
                          child: DottedBox(child: Text(isRemoveFile1? "Removed" : file1==null? documentDetails==null || documentDetails?.imageUrl1==null?'Document 1':"Uploaded ✅":"Uploaded ✅",style: GoogleFonts.dmSans(fontSize: 20.sp,color: file1==null?null:Colors.green),textAlign: TextAlign.center,))),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Visibility(
                            visible: !isRemoveFile1 &&(documentDetails==null && documentDetails?.imageUrl1==null? file1!=null : (documentDetails!=null && documentDetails?.imageUrl1!=null) || file1!=null),
                            child: InkWell(
                              onTap: (){
                                if(file1!=null){
                                  FileViewerModal.showLocalFilePopUp(context, file1!.path);
                                }else if(documentDetails!=null && documentDetails?.imageUrl1!=null) {
                                  FileViewerModal.showNetworkFilePopUp(context, documentDetails!.imageUrl1.toString());
                                }
                              },
                              child: CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  child: Icon(CupertinoIcons.eye,size: 20.sp,)),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 8.h,),
                Visibility(
                    visible: !isRemoveFile1,
                    child: Text(file1==null? documentDetails==null|| documentDetails?.imageUrl1==null?'(Supported File format JPG,PNG,SVG)':path.basename(documentDetails!.imageUrl1.toString()):path.basename(file1!.path),style: GoogleFonts.dmSans(color:file1==null? Colors.grey:Colors.black,fontSize: 12.sp),)),
                SizedBox(height: 8.h,),
                SizedBox(
                  width: 0.4.sw,
                  height: 40.h,
                  child: CustomButton(onPressed: uploadFile1, title:file1==null?"Upload":"Change", textSize: 12.sp,),
                ),
                Visibility(
                  visible: (file1!=null || documentDetails?.imageUrl1!=null) && !isRemoveFile1,
                  child: Column(
                    children: [
                      SizedBox(height: 8.h,),
                      SizedBox(
                        width: 0.4.sw,
                        height: 40.h,
                        child: CustomButton(onPressed: removeFile1, title: 'Remove', textSize: 12.sp,bgColor: Colors.redAccent,),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h,),
                SizedBox(
                  height: 160.sp,
                  width: 180.sp,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 10.sp,
                          right: 10.sp,
                          child: DottedBox(child: Text(isRemoveFile2? "Removed":file2==null? documentDetails==null || documentDetails?.imageUrl2==null?'Document 2': "Uploaded ✅":"Uploaded ✅",style: GoogleFonts.dmSans(fontSize: 20.sp,color: file1==null?null:Colors.green),textAlign: TextAlign.center,))),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Visibility(
                            visible: !isRemoveFile2 && (documentDetails==null && documentDetails?.imageUrl2==null? file2!=null : (documentDetails!=null && documentDetails?.imageUrl2!=null) || file2!=null),
                            child: InkWell(
                              onTap: (){
                                if(file2!=null){
                                  FileViewerModal.showLocalFilePopUp(context, file2!.path);
                                } else if(documentDetails!=null && documentDetails?.imageUrl2!=null) {
                                  FileViewerModal.showNetworkFilePopUp(
                                      context, documentDetails!.imageUrl2.toString());
                                }
                              },
                              child: CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  child: Icon(CupertinoIcons.eye,size: 20.sp,)),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 8.h,),
                Visibility(
                    visible: !isRemoveFile2,
                    child: Text(file2==null? documentDetails==null || documentDetails?.imageUrl2==null?'(Supported File format JPG,PNG,SVG)':path.basename(documentDetails!.imageUrl2.toString()):path.basename(file2!.path),
                      style: GoogleFonts.dmSans(color:file1==null? Colors.grey:Colors.black,fontSize: 12.sp),)),
                SizedBox(height: 8.h,),
                SizedBox(
                  width: 0.4.sw,
                  height: 40.h,
                  child: CustomButton(onPressed: uploadFile2, title:file2==null? "Upload":"Change", textSize: 12.sp,),
                ),
                Visibility(
                  visible: (file2!=null || documentDetails?.imageUrl2!=null) && !isRemoveFile2,
                  child: Column(
                    children: [
                      SizedBox(height: 8.h,),
                      SizedBox(
                        width: 0.4.sw,
                        height: 40.h,
                        child: CustomButton(onPressed: removeFile2, title: 'Remove', textSize: 12.sp,bgColor: Colors.redAccent,),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60.h,)
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Consumer<PatientHomeProvider>(
        builder: (context,provider,child) {
          return Padding(
            padding: EdgeInsets.only(left:16.sp,bottom:24.h,right: 16.w),
            child: CustomButton(onPressed:()=>validateFields(), title: documentDetails?.userId==null? "Save":"Update",loader:provider.loader,),
          );
        }
      ),
    );
  }

  void uploadFile1()async{
    // PermissionStatus permissionStatus= await Permission.storage.request();
    // if(permissionStatus==PermissionStatus.denied){
    //   CustomPopUp.showSnackBar(context, "Permission Denied", Colors.redAccent);
    //   return;
    // }
    final file= await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpeg','png'],allowCompression: true);
    if(file!=null && file.files.isNotEmpty){
      file1=File(file.files.first.path ?? '');
      isRemoveFile1=false;
      setState(() {});
    }
  }

  void removeFile1()async{
    isRemoveFile1=true;
    file1=null;
    setState(() {});
  }

  void removeFile2()async{
    isRemoveFile2=true;
    file2=null;
    setState(() {});
  }

  void uploadFile2()async{
    // PermissionStatus permissionStatus= await Permission.storage.request();
    // if(permissionStatus==PermissionStatus.denied){
    //   CustomPopUp.showSnackBar(context, "Permission Denied", Colors.redAccent);
    //   return;
    // }
    final file= await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpeg','png'],allowCompression: true);
    if(file!=null && file.files.isNotEmpty){
      file2=File(file.files.first.path ?? '');
      isRemoveFile2=false;
      setState(() {});
    }
  }


  bool validateFields(){
    bool isLicenseEmpty = (documentDetails?.imageUrl1 == null && file1 == null);
    bool isCertificateEmpty = (documentDetails?.imageUrl2 == null && file2 == null);
    if ((isLicenseEmpty && isCertificateEmpty) || (isRemoveFile1 && isRemoveFile2)) {
      CustomPopUp.showSnackBar(context, "At least One Document Required ", Colors.redAccent);
      return false;
    }
    final provider=Provider.of<PatientHomeProvider>(context,listen: false);
    provider.uploadDocuments(onUploadResponse,file1: isRemoveFile1? null:file1,file2: isRemoveFile2? null:file2 );
    return true;
  }

  void onUploadResponse(ResponseMessage resp){
    if(resp.error==null && resp.status==true){
      CustomPopUp.showSnackBar(context, "Uploaded Successfully", Colors.green);
      Navigator.of(context).pop();
    }else{
      CustomPopUp.showSnackBar(context, resp.message ?? "Error In Uploading", Colors.redAccent);
    }
  }

  void checkIsUpdate() {
    final provider=Provider.of<PatientHomeProvider>(context,listen: false);
    if(provider.patientDocumentsModel.userId!=null){
      documentDetails=provider.patientDocumentsModel;
      setState(() {});
    }
  }
}
