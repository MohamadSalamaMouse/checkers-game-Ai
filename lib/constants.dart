import 'package:flutter/material.dart';


const Color kPrimaryColor = Color(0xFFEE1B24);
const Color kSecondaryColor = Color(0xFF242A37);
const LinearGradient kGradientPrimaryColor = LinearGradient(colors: [Color(0xFFF78361), Color(0xFFF54B64)], begin:Alignment.bottomRight, end:  Alignment.topLeft,);

const Color kFontColor = Colors.black;
const Color kFontSecondaryColor = Color(0xFF4E586E);

String kErrorText = "Something went wrong, please try again later";
String kSoonJokeText = "ما انا قلتلك soon بترخم ليه؟";

List<BoxShadow> kShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    // spreadRadius: 5,
    blurRadius: 2,
    offset: const Offset(0, 5), // changes position of shadow
  ),
];

BorderRadius kRadiusBorder =  const BorderRadius.all(Radius.circular(4.0),);

UnderlineInputBorder kAppBarBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4),),);

BoxShadow shadow = BoxShadow(
  color: Colors.grey.withOpacity(0.3),
  spreadRadius: 2,
  blurRadius: 5,
  offset: const Offset(0, 3), // changes position of shadow
);
OutlineInputBorder getBorderStyle(Color color, double borderWidth )
{
  return OutlineInputBorder(
    borderRadius:  const BorderRadius.all(Radius.circular(22.0),),
    borderSide: BorderSide(color: color,width:borderWidth ),
  );
}
