import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class storage_shared {



  static Future<List<String>> Get_Data() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    List<String> data = [''];
    data = p.getStringList("Mark") ?? [];
    return data;
  }



  static Future<void> Store_Data(List<String> item) async {
//    SharedPreferences.setMockInitialValues({});
    EasyLoading.show(status: "loading ...");
    SharedPreferences p = await SharedPreferences.getInstance();
    List<String> old_data = await Get_Data();
    old_data.addAll(item);
    print("New Data $old_data");
    await p.setStringList("Mark", old_data);
    EasyLoading.showSuccess("Saved");
  }




  static Future<void> clear_data() async {
    EasyLoading.show(status: "loading ...");
    SharedPreferences p = await SharedPreferences.getInstance();
    await p.clear();
    EasyLoading.showSuccess("Cleared");
  }
}
