import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDownItems{
  List<String> societies= ['Gookool Demo','Vindavan Society','Vindavan Society','Vindavan Society'];
  List<String> societyBlocks= ['Block A','Block B','Block C'];
  List<String> societyFloor= ['1st Floor','2nd Floor B','3rd Floor'];
  List<String> flatNumbers= ['202','203','204'];

  List<PopupMenuItem> getSocietyItems(){
    List<PopupMenuItem> societyOptions=[];
    for (int i=0; i<societies.length;i++) {
      societyOptions.add(PopupMenuItem(
        value: i,
        child: SizedBox(
          width: 1.sw,
          child: Row(
            children: [
              Text(societies[i],style: GoogleFonts.inter(fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
      );
    }
    societyOptions.add(PopupMenuItem(
      value: 3,
      child: SizedBox(
        width: 1.sw,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("+ Add Your Society", style: GoogleFonts.inter(color: Colors.blue)),
          ],
        ),
      ),
    ),);
    return societyOptions;
  }

  List<PopupMenuItem> getSocietyBlockItems(){
    List<PopupMenuItem> societyOptions=[];
    for (int i=0; i<societyBlocks.length;i++) {
      societyOptions.add(PopupMenuItem(
        value: i,
        child: SizedBox(
          width: 1.sw,
          child: Row(
            children: [
              Text(societyBlocks[i],style: GoogleFonts.inter(fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
      );
    }
    return societyOptions;
  }

  List<PopupMenuItem> getSocietyFloor(){
    List<PopupMenuItem> societyOptions=[];
    for (int i=0; i<societyFloor.length;i++) {
      societyOptions.add(PopupMenuItem(
        value: i,
        child: SizedBox(
          width: 1.sw,
          child: Row(
            children: [
              Text(societyFloor[i],style: GoogleFonts.inter(fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
      );
    }
    return societyOptions;
  }

  List<PopupMenuItem> getFloorFlatNumbers(){
    List<PopupMenuItem> societyOptions=[];
    for (int i=0; i<flatNumbers.length;i++) {
      societyOptions.add(PopupMenuItem(
        value: i,
        child: SizedBox(
          width: 1.sw,
          child: Row(
            children: [
              Text(flatNumbers[i],style: GoogleFonts.inter(fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
      );
    }
    return societyOptions;
  }

}