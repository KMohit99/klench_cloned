import 'package:get/get.dart';

class Ledger_Setup_controller extends GetxController {
  String pageIndex_customer = '01';
  pageIndexUpdate_customer(String? value) {
    pageIndex_customer = value!;
    update();
  }

  bool m_running = false;
  bool k_running = false;
  bool p_running = false;
  bool w_running = false;

}
