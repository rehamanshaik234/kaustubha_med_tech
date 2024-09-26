  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../controller/providers/common_provider.dart';

class CustomPopUp{

  static FToast fToast=FToast();

  static void showSnackBar(BuildContext context,String title,Color bgColor,{Widget? child,TextStyle? textStyle}){
    if(!context.mounted){
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
         backgroundColor: bgColor,
          behavior: SnackBarBehavior.floating,
          content: Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text(title,style: textStyle?? GoogleFonts.dmSans(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w500),),
              child ?? Container()
            ],
          ))
    );
  }

  static void showTopSnackBar(BuildContext context,String title,Color bgColor,{Widget? child,TextStyle? textStyle,required VoidCallback onAcceptCall,required VoidCallback onDeclineCall,IO.Socket? socket}) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    socket?.on('callUser', (signal){
      if (signal!=null && signal['signal'].toString()=='endCall' && overlayEntry.mounted) {
          context.read<CommonProvider>().setShowingCallPopup(false);
          overlayEntry.remove();
      }
    });
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10, // Adjusts for the status bar height
        left: 20,
        right: 20,
        child: Material(
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: textStyle?? GoogleFonts.dmSans(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          overlayEntry.remove();
                          context.read<CommonProvider>().setShowingCallPopup(false);
                          onAcceptCall();
                        },
                        icon: CircleAvatar(
                            radius: 15.sp,
                            backgroundColor: Colors.green,
                            child: Center(
                                child: Icon(Icons.call_outlined, color: Colors.white,size: 15.sp,))),
                      ),
                      IconButton(
                        onPressed: (){
                          overlayEntry.remove();
                          context.read<CommonProvider>().setShowingCallPopup(false);
                          onDeclineCall();
                        },
                        icon: CircleAvatar(
                            radius: 15.sp,
                            backgroundColor: Colors.red,
                            child: Center(
                                child: Icon(Icons.call_end_rounded, color: Colors.white,size: 15.sp,))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry);
    context.read<CommonProvider>().setShowingCallPopup(true);
    Future.delayed(const Duration(seconds: 30),(){
        if(overlayEntry.mounted){
          overlayEntry.remove();
          context.read<CommonProvider>().setShowingCallPopup(false);
        }
    });
  }


  static void showFToast(BuildContext context,String title){
    fToast.init(context);
    fToast.showToast(child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: Colors.green
      ),
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.only(bottom: 40.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle,color: Colors.white,size: 20.sp,),
          SizedBox(width: 4.w,),
          Text(title,style: GoogleFonts.dmSans(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16.sp),),
        ],
      ),
    ));
  }
}