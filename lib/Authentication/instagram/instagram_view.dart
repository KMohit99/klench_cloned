import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:klench_/Authentication/SingIn/controller/SignIn_controller.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert' as convert;
import 'home.dart';
import 'instagram_constanr.dart';
import 'instagram_model.dart';

// import 'package:instagram_login/home.dart';
// import 'package:instagram_login/instagram_constant.dart';
// import 'package:instagram_login/instagram_model.dart';

class InstagramView extends StatefulWidget {
  final String login_type;
  final BuildContext context;

  InstagramView({Key? key, required this.login_type, required this.context})
      : super(key: key);

  // LoginModel? loginModel;


  static const String scope = 'user_profile,user_media';
  static const String responseType = 'code';

  // Your Instagram config information in facebook developer site.
  static final  String appId = '724311555515234'; //ex 202181494449441
  static final  String appSecret = '02bef57d91954f2b183ec9143d06a1dd'; //ex ec0660294c82039b12741caba60f440c
  static final String redirectUri = 'https://github.com/KMohit99'; //ex https://github.com/loydkim
  static final String initialUrl = 'https://api.instagram.com/oauth/authorize?client_id=$appId&redirect_uri=$redirectUri&scope=user_profile,user_media&response_type=$responseType';

  @override
  State<InstagramView> createState() => _InstagramViewState();
}

class _InstagramViewState extends State<InstagramView> {
  final authFunctionUrl = 'https://klench12.firebaseapp.com/__/auth/handler';
 //ex https://us-central1-signuptest-beb58.cloudfunctions.net/makeCustomToken

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final webview = WebView();
      final InstagramModel instagram = InstagramModel();

      // buildRedirectToHome(webview, instagram, context);
      return Scaffold(
        appBar: buildAppBar(context),
        body: WebView(
          initialUrl: InstagramView.initialUrl,
          navigationDelegate: (NavigationRequest request) {
            if(request.url.startsWith(InstagramView.redirectUri)){
              if(request.url.contains('error')) print('the url error');
              var startIndex = request.url.indexOf('code=');
              var endIndex = request.url.lastIndexOf('#');
              var code = request.url.substring(startIndex + 5,endIndex);
              _logIn(code);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (url) => print("Page started " + url),
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
          // onPageFinished: (url) async {
          //   // print('${instagram.username} logged in!');
          //   await _loginScreenController.SignUpAPi(
          //     context: context,
          //     type: 'instagram',
          //     username: _loginScreenController.userData['username'],
          //   );
          // },
        ),
      );
      //   WebView(
      //   initialUrl: InstagramConstant.instance.url,
      //   // resizeToAvoidBottomInset: true,
      //   // appBar: buildAppBar(context),
      // );
    });
  }

  Future<void>  _logIn(String code) async {
    // setState(() => _stackIndex = 2);

    try {
      // Step 1. Get user's short token using facebook developers account information
      // Http post to Instagram access token URL.
      final http.Response response = await http.post(
          Uri.parse("https://api.instagram.com/oauth/access_token"),
          body: {
            "client_id": InstagramView.appId,
            "redirect_uri": InstagramView.redirectUri,
            "client_secret": InstagramView.appSecret,
            "code": code,
            "grant_type": "authorization_code"
          });

      // Step 2. Change Instagram Short Access Token -> Long Access Token.
      final http.Response responseLongAccessToken = await http.get(
          Uri.parse('https://graph.instagram.com/access_token?grant_type=ig_exchange_token&client_secret=${InstagramView.appSecret}&access_token=${json.decode(response.body)['access_token']}'));

      // Step 3. Take User's Instagram Information using LongAccessToken
      final http.Response responseUserData = await http.get(
          Uri.parse('https://graph.instagram.com/${json.decode(response.body)['user_id'].toString()}?fields=id,username,account_type,media_count&access_token=${json.decode(responseLongAccessToken.body)['access_token']}'));

      // Step 4. Making Custom Token For Firebase Authentication using Firebase Function.
      final http.Response responseCustomToken = await http.get(
          Uri.parse('$authFunctionUrl?instagramToken=${json.decode(responseUserData.body)['id']}'));


      // Change the variable status.
      setState(() {
        _loginScreenController.userData = json.decode(responseUserData.body);
      });
      print("_loginScreenController.userData['username']");
      print(_loginScreenController.userData['username']);
      await _loginScreenController.SignUpAPi(
        context: context,
        type: 'instagram',
        username: _loginScreenController.userData['username'],
      );
    }catch(e) {
      print(e.toString());
    }
  }

  //
  final SignInScreenController _loginScreenController = Get.put(
      SignInScreenController(),
      tag: SignInScreenController().toString());

  // Future<dynamic> getUserInfo_social() async {
  AppBar buildAppBar(BuildContext context) => AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Instagram Login',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
      );
}
