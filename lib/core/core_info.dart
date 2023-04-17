// import 'package:influencer_academy/core/helpers/navigation_helper.dart';
// import 'package:influencer_academy/core/repo/bearer_token_repo.dart';
// import 'package:influencer_academy/main.dart';
// import 'package:influencer_academy/welcomePage/welcome_page_view.dart';
//
// import 'helpers/dio_helper.dart';
// import 'models/user.dart';
// import 'repo/profile_repo.dart';
//
// class CoreInfo{
//   static bool isInLive = false;
//   static User? loggedUser;
//   static BearerTokenRepo bearerTokenRepo = BearerTokenRepo();
//   static Future<void> init() async{
//     if(!isLogged()) return;
//     await ProfileRepo().getProfile();
//   }
//
//   static Future<void> handleAuthJson(Map<String, dynamic> json) async {
//     bearerTokenRepo.setBearerToken(json["token"]);
//     loggedUser = User.fromJson(json["data"]);
//     loggedUser!.initCategoriesNames(await ProfileRepo().getComments());
//   }
//
//   static bool isLogged(){
//     return bearerTokenRepo.getBearerToken() != null;
//   }
//
//   static Future<void> logOut() async{
//     try{
//       DioHelper().postData("user/logout", {},);
//     }
//     catch(e, trace){
//       print("Error in logOut: $e, $trace");
//     }
//     bearerTokenRepo.deleteBearerToken();
//     NavigationHelper.pushAndReplacement(navigatorKey.currentContext!, const WelcomePageView());
//   }
// }