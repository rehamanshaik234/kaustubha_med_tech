import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaustubha_medtech/controller/providers/doctor_enrollment/doctor_enrollment.dart';
import 'package:kaustubha_medtech/models/doctor_enrollment/DoctorOfficialDetModel.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/enroll_form_field.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/gender_dropdown.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class DoctorOfficialDetails extends StatefulWidget {
  DoctorOfficialDetails({super.key,required this.validFields});
  Function(bool) validFields;

  @override
  State<DoctorOfficialDetails> createState() => DoctorOfficialDetailsState();
}

class DoctorOfficialDetailsState extends State<DoctorOfficialDetails> {
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  File? profile;
  // Controllers
  TextEditingController name = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController specialization = TextEditingController();
  TextEditingController subSpecialization = TextEditingController();
  TextEditingController exp = TextEditingController();
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
  FocusNode addressFocus = FocusNode();
  FocusNode countryFocus = FocusNode();
  FocusNode stateFocus = FocusNode();
  FocusNode cityFocus = FocusNode();

  String? gender;

  // Common validation function with focus management
  String? commonValidator(String? value, String fieldName, FocusNode focusNode) {
    if (value == null || value.isEmpty) {
      // Request focus to the respective field
      return 'Please enter $fieldName';
    }
    return null; // No error, valid input
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50.sp),
                child: CircleAvatar(
                  radius: 50.sp,
                  backgroundColor: Colors.grey,
                  child:profile==null?Icon(
                    Icons.person_pin,
                    color: Colors.white,
                    size: 80.sp,
                  ):Image.file(profile ?? File(''),fit: BoxFit.cover,height: 100.h,width: 100.w,),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                width: 0.4.sw,
                height: 40.h,
                child: CustomButton(
                  onPressed: selectProfilePic,
                  title: "Upload photo",
                  textSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              EnrollFormField(
                controller: name,
                focusNode: nameFocus,
                title: "Legal Name",
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
              EnrollFormField(
                controller: specialization,
                focusNode: specializationFocus,
                title: "Specialization",
                hint: 'Enter Here',
                validator: (value) => commonValidator(
                    value, 'specialization', specializationFocus),
              ),
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
                controller: address,
                focusNode: addressFocus,
                title: "Address",
                hint: 'Enter Here',
                validator: (value) =>
                    commonValidator(value, 'address', addressFocus),
              ),
              EnrollFormField(
                controller: country,
                focusNode: countryFocus,
                title: "Country",
                hint: 'Enter Here',
                validator: (value) =>
                    commonValidator(value, 'country', countryFocus),
              ),
              EnrollFormField(
                controller: state,
                focusNode: stateFocus,
                title: "State",
                hint: 'Enter Here',
                validator: (value) =>
                    commonValidator(value, 'state', stateFocus),
              ),
              EnrollFormField(
                controller: city,
                focusNode: cityFocus,
                title: "City",
                hint: 'Enter Here',
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
    bool isValid = formKey.currentState?.validate() ?? false;
    if (profile == null) {
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
    if (specialization.text.isEmpty) {
      specializationFocus.requestFocus();
      CustomPopUp.showSnackBar(context, "Enter Specialization", Colors.redAccent);
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
    DoctorOfficialDetModel detModel=DoctorOfficialDetModel(legalName: name.text,gender: gender,dateOfBirth: dateOfBirth.text,
    qualification: qualification.text,specialization: specialization.text,subSpecialist: subSpecialization.text,
    experienceYears: exp.text,address: address.text,country: country.text,state: state.text,city: city.text,bookedAppointment: 0);
    Provider.of<DoctorEnrollmentProvider>(context).setOfficialDet(detModel);
    return true;
  }
}
