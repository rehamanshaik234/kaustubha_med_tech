import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaustubha_medtech/controller/providers/doctor_enrollment/doctor_enrollment.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorDetailsModel.dart';
import 'package:kaustubha_medtech/models/doctor_enrollment/DoctorPersonalDetModel.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/enroll_form_field.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/gender_dropdown.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_colors/app_colors.dart';

class DoctorPersonalDetails extends StatefulWidget {
  DoctorPersonalDetails({super.key,required this.validFields,this.doctorDetails});
  Function(bool) validFields;
  DoctorDetailsModel? doctorDetails;

  @override
  State<DoctorPersonalDetails> createState() => DoctorPersonalDetailsState();
}

class DoctorPersonalDetailsState extends State<DoctorPersonalDetails> with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  File? profile;
  // Controllers
  TextEditingController name = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController qualification = TextEditingController();
  String? specialization;
  TextEditingController subSpecialization = TextEditingController();
  TextEditingController exp = TextEditingController();
  TextEditingController consultFee = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  // Focus nodes for auto-focus on validation error
  FocusNode nameFocus = FocusNode();
  FocusNode dobFocus = FocusNode();
  FocusNode qualificationFocus = FocusNode();
  FocusNode specializationFocus = FocusNode();
  FocusNode subSpecializationFocus = FocusNode();
  FocusNode expFocus = FocusNode();
  FocusNode consultFeeFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode countryFocus = FocusNode();
  FocusNode stateFocus = FocusNode();
  FocusNode cityFocus = FocusNode();

  String? gender;

  String? commonValidator(String? value, String fieldName, FocusNode focusNode) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      checkDetails();
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
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: selectProfilePic,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.sp),
                      child: CircleAvatar(
                        radius: 50.sp,
                        backgroundColor: Colors.grey,
                        child:profile==null?widget.doctorDetails!=null && widget.doctorDetails?.image!=null?
                        Image.network(widget.doctorDetails!.image,fit: BoxFit.cover,height: 100.h,width: 100.w,):
                        Icon(
                          Icons.person_pin,
                          color: Colors.white,
                          size: 80.sp,
                        ):Image.file(profile ?? File(''),fit: BoxFit.cover,height: 100.h,width: 100.w,),
                      ),
                    ),
                  ),
                  Positioned(
                    top:0,
                    right: 0,
                    child: Visibility(
                      visible: profile!=null,
                      child: InkWell(
                        onTap: (){
                          profile=null;
                          setState(() {});
                        },
                        child: CircleAvatar(radius: 15.sp,backgroundColor:Colors.redAccent,
                            child: Icon(CupertinoIcons.delete,size: 20.sp,)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                width: 0.4.sw,
                height: 40.h,
                child: CustomButton(
                  onPressed: selectProfilePic,
                  title:profile!=null || (widget.doctorDetails!=null && widget.doctorDetails?.image!=null)?
                  "Change":"Upload photo",
                  textSize: 12.sp,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              EnrollFormField(
                controller: name,
                focusNode: nameFocus,
                title: "Legal Name",
                includeSpacing: true,
                hint: 'Enter Name',
                validator: (value) => commonValidator(value, 'name', nameFocus),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: GenderDropDown(
                  onChange: (gender) {
                    this.gender=gender;
                    setState(() {});
                  },
                  selectedTab: gender,
                ),
              ),
              EnrollFormField(
                controller: dateOfBirth,
                focusNode: dobFocus,
                title: "Date of Birth",
                hint: 'Enter DOB',
                isDate: true,
                validator: (value) =>
                    commonValidator(value, 'date of birth', dobFocus),
              ),
              EnrollFormField(
                controller: qualification,
                focusNode: qualificationFocus,
                title: "Qualification",
                hint: 'Enter Here',
                validator: (value) => commonValidator(
                    value, 'qualification', qualificationFocus),
              ),
              specializationDropDown(specialization,specializationFocus),
              EnrollFormField(
                controller: subSpecialization,
                focusNode: subSpecializationFocus,
                title: "Sub Specialization",
                hint: 'Enter Here',
                validator: (value) => commonValidator(
                    value, 'sub-specialization', subSpecializationFocus),
              ),
              EnrollFormField(
                controller: exp,
                focusNode: expFocus,
                title: "Experience in Years",
                hint: 'Enter Here',
                inputType: TextInputType.number,
                validator: (value) =>
                    commonValidator(value, 'experience', expFocus),
              ),
              EnrollFormField(
                controller: consultFee,
                focusNode: consultFeeFocus,
                title: "Consultation Fee",
                hint: 'Enter Here',
                inputType: TextInputType.number,
                validator: (value) =>
                    commonValidator(value, 'Consultation Fee', expFocus),
              ),
              EnrollFormField(
                controller: address,
                focusNode: addressFocus,
                title: "Address",
                includeSpacing: true,
                hint: 'Enter Here',
                validator: (value) =>
                    commonValidator(value, 'address', addressFocus),
              ),
              EnrollFormField(
                controller: country,
                focusNode: countryFocus,
                title: "Country",
                hint: 'Enter Here',
                includeSpacing: true,
                validator: (value) =>
                    commonValidator(value, 'country', countryFocus),
              ),
              EnrollFormField(
                controller: state,
                focusNode: stateFocus,
                title: "State",
                includeSpacing: true,
                hint: 'Enter Here',
                validator: (value) =>
                    commonValidator(value, 'state', stateFocus),
              ),
              EnrollFormField(
                controller: city,
                focusNode: cityFocus,
                title: "City",
                hint: 'Enter Here',
                includeSpacing: true,
                validator: (value) => commonValidator(value, 'city', cityFocus),
              ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }

  void selectProfilePic() async {
    PermissionStatus permission = await Permission.photos.request();
    if (permission.isDenied) {
      CustomPopUp.showSnackBar(context, 'Access Denied', Colors.red);
      return;
    }
    final image =
    await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      profile=file;
      setState(() {});
    }
  }

  bool validateFields() {
    formKey.currentState?.validate() ?? false;
    if (profile == null && widget.doctorDetails?.image==null) {
      CustomPopUp.showSnackBar(context, "Add Profile", Colors.redAccent);
      return false;
    }
    if (name.text.isEmpty) {
      nameFocus.requestFocus();
      CustomPopUp.showSnackBar(context, "Enter Name", Colors.redAccent);
      return false;
    }
    if(gender==null){
      CustomPopUp.showSnackBar(context, "Enter Select Gender", Colors.redAccent);
      return false;
    }
    if (dateOfBirth.text.isEmpty) {
      CustomPopUp.showSnackBar(context, "Enter Date of Birth", Colors.redAccent);
      return false;
    }
    if (qualification.text.isEmpty) {
      qualificationFocus.requestFocus();
      CustomPopUp.showSnackBar(context, "Enter Qualification", Colors.redAccent);
      return false;
    }
    if (specialization==null) {
      specializationFocus.requestFocus();
      CustomPopUp.showSnackBar(context, "Select Specialization", Colors.redAccent);
      return false;
    }
    if (subSpecialization.text.isEmpty) {
      subSpecializationFocus.requestFocus();
      CustomPopUp.showSnackBar(context, "Enter Sub Specialization", Colors.redAccent);
      return false;
    }
    if (exp.text.isEmpty) {
      expFocus.requestFocus();
      CustomPopUp.showSnackBar(context, "Enter Experience in Years", Colors.redAccent);
      return false;
    }
    if (consultFee.text.isEmpty) {
      consultFeeFocus.requestFocus();
      CustomPopUp.showSnackBar(context, "Enter Consultation Fee", Colors.redAccent);
      return false;
    }
    if (address.text.isEmpty) {
      addressFocus.requestFocus();
      CustomPopUp.showSnackBar(context, "Enter Address", Colors.redAccent);
      return false;
    }
    if (country.text.isEmpty) {
      countryFocus.requestFocus();
      CustomPopUp.showSnackBar(context, "Enter Country", Colors.redAccent);
      return false;
    }
    if (state.text.isEmpty) {
      stateFocus.requestFocus();
      CustomPopUp.showSnackBar(context, "Enter State", Colors.redAccent);
      return false;
    }
    if (city.text.isEmpty) {
      cityFocus.requestFocus();
      CustomPopUp.showSnackBar(context, "Enter City", Colors.redAccent);
      return false;
    }
    DoctorPersonalDetModel detModel=DoctorPersonalDetModel(legalName: name.text,gender: gender,dateOfBirth: Constants.convertDateForEnrollment(dateOfBirth.text),
    qualification: qualification.text,specialization: specialization,subSpecialist: subSpecialization.text,
    experienceYears: exp.text,consultationFees: consultFee.text, address: address.text,country: country.text,state: state.text,city: city.text,bookedAppointment: 0);
    Provider.of<DoctorEnrollmentProvider>(context,listen: false).setPersonalDet(detModel);
    Provider.of<DoctorEnrollmentProvider>(context,listen: false).setProfile(profile);
    return true;
  }

  Widget specializationDropDown(String? value,FocusNode focus){
    List<String> options=Constants.specialisations;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                Text("Specialization",style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h,),
        Container(
          height: 50.h,
          width: 1.sw,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
              color: Colors.transparent,
              border: Border.all(color: Colors.black)
          ),
          padding: EdgeInsets.symmetric(horizontal:  12.w,vertical: 12.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: value,
                focusNode: specializationFocus,
                hint: SizedBox(
                    width: 0.75.sw,
                    child: Text('Select Specialisation',style:GoogleFonts.inter(color: Colors.black54),)),
                borderRadius: BorderRadius.circular(20.sp),
                items: List.generate(
                  options.length,
                      (index) => DropdownMenuItem(
                    value: options[index],
                    child: Text(
                      options[index],
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value != null) {
                    specialization=value;
                    setState(() {});
                  }
                },
                dropdownColor: Colors.white,
                underline: Container(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h,)
      ],
    );
  }

  void checkDetails(){
    if(widget.doctorDetails!=null){
      Profile profile=widget.doctorDetails?.profile ?? Profile();
      name.text= profile.legalName ?? "";
      gender=profile.gender;
      dateOfBirth.text= profile.dateOfBirth ?? "";
      qualification.text= profile.qualification ?? "";
      specialization= profile.specialization;
      subSpecialization.text= profile.subSpecialist ?? "";
      exp.text= profile.experienceYears ?? "";
      consultFee.text= profile.consultationFees ?? "";
      address.text= profile.address ?? "";
      country.text= profile.country ?? "";
      state.text= profile.state ?? "";
      city.text= profile.city ?? "";
    }
    setState(() {});
  }
}
