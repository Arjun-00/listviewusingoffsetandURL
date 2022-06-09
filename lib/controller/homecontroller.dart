import 'package:get/get.dart';
import 'package:simple_getx_api/class/datas.dart';
import 'package:simple_getx_api/service/services.dart';

class HomeController extends GetxController{

  Datas apidatas = Datas();
  List<Data> userdata = <Data>[].obs;
  var totalpage = 0;
  var pages = 1;

  @override
  void onInit() {
    fetchDatas();
    super.onInit();
  }

  Future<List<Data>> fetchDatas({int pages =0}) async{
    var listofdata = await Services.getApiDatas(pages);

    if(listofdata is Datas){
      apidatas =listofdata;
      pages = listofdata.page!;
      totalpage = listofdata.totalPages!;
      userdata = apidatas.data!;
    }else{
      return listofdata;
    }
    return userdata;
  }

}