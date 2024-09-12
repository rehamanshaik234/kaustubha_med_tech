import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  late double value;
  VoidCallback onTap;
  CustomCircularProgressIndicator({super.key,required this.value,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Stack(
          alignment: Alignment.center,
          children: [
            // Background Circular Progress (remaining progress color)
            SizedBox(
              height: 60.sp,
              width: 60.sp,
              child:  const CircularProgressIndicator(
                value: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white30), // remaining progress color
              ),
            ),
            // Foreground Circular Progress (filled portion)
            SizedBox(
              height: 60.sp,
              width: 60.sp,
              child: CircularProgressIndicator(
                value: value, // Progress value
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // progress color
              ),
            ),
            // Child widget in the center
            Center(
              child: GestureDetector(
                onTap: onTap,
                child: CircleAvatar(
                  radius: 24.sp,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.navigate_next,color: Colors.black45,size: 30.sp,),
                ),
              )
            ),
          ],
    );
  }
}

