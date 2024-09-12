
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/views/widgets/custom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/controller/firebase/firebase_auth.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';

import '../../../controller/firebase/firestore_database.dart';
import '../../../controller/providers/authentication/sign_up_provider.dart';
import '../../../models/create_account/UserAccount.dart';
import '../../../utils/firestore_urls.dart';
import '../../../utils/routes/routes.dart';
import '../../widgets/custom_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBgColor,
            leading: Padding(
              padding:  EdgeInsets.only(left: 12.w),
              child: Image(image: AssetImage(AssetUrls.profile)),
            ),
            centerTitle: false,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Good Morning",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),)
              ],
            ),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.grey,size: 24.sp,)),
            ],
          ),
          body: Navigator(
            initialRoute: RoutesName.home,
            onGenerateRoute: (settings){
              return Routes.generateRoute(settings, currentRoute);
            },
          ),
          bottomSheet: CustomBottomNavBar(),
        );
      },
    );
  }

  void currentRoute(String? route){

  }
}
