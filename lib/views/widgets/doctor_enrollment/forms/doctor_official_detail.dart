import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorDetailsModel.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/file_viewer_modal.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/enroll_form_field.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/dotted_box.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../controller/providers/doctor_enrollment/doctor_enrollment.dart';
import '../../custom_button.dart';
class DoctorOfficialDetails extends StatefulWidget {
  DoctorOfficialDetails({super.key,this.doctorDetails});

  DoctorDetailsModel? doctorDetails;

  @override
  State<DoctorOfficialDetails> createState() => DoctorOfficialDetailsState();
}

class DoctorOfficialDetailsState extends State<DoctorOfficialDetails> with AutomaticKeepAliveClientMixin {
  TextEditingController licenseNumber=TextEditingController();
  TextEditingController certificateNumber=TextEditingController();
  Liscense? licenseDetails;
  File? license;

  File? certificate;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      checkIsUpdate();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(radius: 4.sp,backgroundColor: Colors.black,),
                SizedBox(width: 8.w,),
                Text('Medical Licensing',style: GoogleFonts.dmSans(fontWeight: FontWeight.w400,fontSize: 20.sp),)
              ],
            ),
            Row(
              children: [
                CircleAvatar(radius: 4.sp,backgroundColor: Colors.black,),
                SizedBox(width: 8.w,),
                Text('Medical Certification',style: GoogleFonts.dmSans(fontWeight: FontWeight.w400,fontSize: 20.sp),)
              ],
            ),
            SizedBox(height: 50.h,),
            SizedBox(
              height: 180.sp,
              width: 180.sp,
              child: Stack(
                children: [
                  Positioned(
                      top: 10.sp,
                      right: 10.sp,
                      child: DottedBox(child: Text(license==null? licenseDetails==null?'Medical License':"Uploaded ✅":"Uploaded ✅",style: GoogleFonts.dmSans(fontSize: 20.sp,color: license==null?null:Colors.green),textAlign: TextAlign.center,))),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Visibility(
                        visible:licenseDetails==null && licenseDetails?.imageUrl1==null? license!=null : (licenseDetails!=null && licenseDetails?.imageUrl1!=null) || license!=null,
                        child: InkWell(
                          onTap: (){
                            if(license!=null){
                              FileViewerModal.showLocalFilePopUp(context, license!.path);
                            }else if(licenseDetails!=null && licenseDetails?.imageUrl1!=null) {
                              FileViewerModal.showNetworkFilePopUp(
                                  context, licenseDetails!.imageUrl1.toString());
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
            Text(license==null? licenseDetails==null?'(Supported File format JPG,PNG,SVG)':path.basename(licenseDetails!.imageUrl1.toString()):path.basename(license!.path),style: GoogleFonts.dmSans(color:license==null? Colors.grey:Colors.black,fontSize: 12.sp),),
            SizedBox(height: 24.h,),
            SizedBox(
              width: 0.4.sw,
              height: 40.h,
              child: CustomButton(onPressed: uploadMedicalLicense, title:license==null?"Upload":"Change", textSize: 12.sp,),
            ),
            SizedBox(height: 50.h,),
            EnrollFormField(controller: licenseNumber, title: "Medical registration number (License)*", hint: 'Enter Number Here'),
            SizedBox(height: 50.h,),
            SizedBox(
              height: 180.sp,
              width: 180.sp,
              child: Stack(
                children: [
                  Positioned(
                      top: 10.sp,
                      right: 10.sp,
                      child: DottedBox(child: Text(certificate==null? licenseDetails==null?'Medical Certificate':"Uploaded ✅":"Uploaded ✅",style: GoogleFonts.dmSans(fontSize: 20.sp,color: license==null?null:Colors.green),textAlign: TextAlign.center,))),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Visibility(
                        visible:licenseDetails==null && licenseDetails?.imageUrl2==null? certificate!=null : (licenseDetails!=null && licenseDetails?.imageUrl2!=null) || certificate!=null,
                        child: InkWell(
                          onTap: (){
                            if(certificate!=null){
                              FileViewerModal.showLocalFilePopUp(context, certificate!.path);
                            } else if(licenseDetails!=null && licenseDetails?.imageUrl2!=null) {
                              FileViewerModal.showNetworkFilePopUp(
                                  context, licenseDetails!.imageUrl2.toString());
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
            Text(certificate==null? licenseDetails==null?'(Supported File format JPG,PNG,SVG)':path.basename(licenseDetails!.imageUrl2.toString()):path.basename(certificate!.path),style: GoogleFonts.dmSans(color:license==null? Colors.grey:Colors.black,fontSize: 12.sp),),
            SizedBox(height: 24.h,),
            SizedBox(
              width: 0.4.sw,
              height: 40.h,
              child: CustomButton(onPressed: uploadMedicalCertificate, title:certificate==null? "Upload":"Change", textSize: 12.sp,),
            ),
            SizedBox(height: 50.h,),
            EnrollFormField(controller: certificateNumber, title: "Medical registration number (Certify.)*", hint: 'Enter Number Here'),
            SizedBox(height: 60.h,)
          ],
        ),
      ),
    );
  }

  void uploadMedicalLicense()async{
    PermissionStatus permissionStatus= await Permission.storage.request();
    if(permissionStatus==PermissionStatus.denied){
      CustomPopUp.showSnackBar(context, "Permission Denied", Colors.redAccent);
      return;
    }
    final file= await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpeg','png'],allowCompression: true);
    if(file!=null && file.files.isNotEmpty){
      license=File(file.files.first.path ?? '');
      setState(() {});
    }
  }

  void uploadMedicalCertificate()async{
    PermissionStatus permissionStatus= await Permission.storage.request();
    if(permissionStatus==PermissionStatus.denied){
      CustomPopUp.showSnackBar(context, "Permission Denied", Colors.redAccent);
      return;
    }
    final file= await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpeg','png'],allowCompression: true);
    if(file!=null && file.files.isNotEmpty){
      certificate=File(file.files.first.path ?? '');
      setState(() {});
    }
  }


  bool validateFields(){
    if(widget.doctorDetails?.liscense?.imageUrl1 == null && license == null){
      CustomPopUp.showSnackBar(context, "Upload Medical License", Colors.redAccent);
      return false;
    }
    if(licenseNumber.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Medical License Number", Colors.redAccent);
      return false;
    }
    if(widget.doctorDetails?.liscense?.imageUrl2 == null && certificate == null){
      CustomPopUp.showSnackBar(context, "Upload Medical Certificate", Colors.redAccent);
      return false;
    }
    if(certificateNumber.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Medical Certificate Number", Colors.redAccent);
      return false;
    }
    final provider=Provider.of<DoctorEnrollmentProvider>(context,listen: false);
    provider.setLicense(license);
    provider.setCertificate(certificate);
    provider.setLicenseNum(licenseNumber.text);
    provider.setCertificateNum(certificateNumber.text);
    return true;
  }

  void checkIsUpdate() {
    if(widget.doctorDetails!=null && widget.doctorDetails?.liscense!=null){
      licenseDetails=widget.doctorDetails?.liscense;
      licenseNumber.text=widget.doctorDetails?.liscense?.registrationNumber1 ?? "";
      certificateNumber.text=widget.doctorDetails?.liscense?.registrationNumber2 ?? "";
      setState(() {});
    }
  }
}
