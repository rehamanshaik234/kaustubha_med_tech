import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class CustomDropdown extends StatefulWidget {
  final String hintText;
  List<PopupMenuItem> items;
  Function(String) onSelected;
  List<String> data;

  CustomDropdown({super.key, required this.hintText,required this.items,required this.onSelected,required this.data});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isMenuOpen = false; // Track if the menu is open
  String selectedValue='';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: _isMenuOpen ? ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0) : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Container(
            color: Colors.transparent, // Transparent container to allow blur
            child: InkWell(
              onTap: () => _showDropdownMenu(context),
              child: Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.sp),
                  border: Border.all(color: Colors.black54),
                ),
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedValue.isEmpty? widget.hintText:selectedValue,
                      style: GoogleFonts.inter(
                        color: selectedValue.isEmpty? Colors.black54:Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.sp,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.black54,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDropdownMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final RelativeRect position = RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height,
        offset.dx,
        0
    );
    setState(() {
      _isMenuOpen = true; // Set menu open
    });
    showMenu(
      context: context,
      position: position,
      color: Colors.white,
      items: widget.items,
    ).then((value) {
      setState(() {
        _isMenuOpen = false; // Close the menu and remove blur
      });
      if (value != null) {
        widget.onSelected(widget.data[value]);
        selectedValue=widget.data[value];
        setState(() {});
      }
    });
  }

}
