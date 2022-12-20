import 'package:get/get.dart';
import 'package:klench_/homepage/swipe_screen.dart';

import '../Dashboard/dashboard_screen.dart';
import '../homepage/kegel_screen.dart';
import '../homepage/m_screen_metal.dart';
import '../homepage/pee_screen.dart';
import '../homepage/warmpUp_screen.dart';
import '../splash_Screen.dart';
import 'Bindings_class.dart';
import 'binding_utils.dart';

class AppPages {
  static final getPageList = [
    GetPage(
      name: BindingUtils.splashRoute,
      page: () => SplashScreen(),
      binding: Splash_Bindnig(),
    ),
    GetPage(
      name: BindingUtils.FrontpageScreenScreenRoute,
      page: () => SplashScreen(),
      binding: Frontpage_Bindnig(),
    ),
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/warmpup', page: () => WarmUpScreen()),
    GetPage(
      name: '/kegel',
      page: () => KegelScreen(),
    ),
    GetPage(
      name: '/masturbation',
      page: () => M_ScreenMetal(),
    ),
    GetPage(
      name: '/pee',
      page: () => PeeScreen(),
    ),
    GetPage(
      name: '/profile',
      page: () => DashboardScreen(page: 0),
    ),
    GetPage(
      name: '/homepage',
      page: () =>  DashboardScreen(page: 1),
    ),
    GetPage(
      name: '/breathing',
      page: () =>  DashboardScreen(page: 2),
    ),
    GetPage(
      name: '/settings',
      page: () =>  DashboardScreen(page: 3),
    ),

  ];
}

// Widget? get getPage {
//   if (widget.page == 0) {
//     return const ProfilePageScreen();
//   } else if (widget.page== 1) {
//     return const HomepageScreen();
//     // return const SwipeScreen();
//   } else if (widget.page == 2) {
//     return const BreathingScreen();
//   } else if (widget.page == 3) {
//     return const SettingScreen();
//   }
// }
