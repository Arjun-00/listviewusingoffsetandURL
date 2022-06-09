import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_getx_api/class/datas.dart';
import 'package:simple_getx_api/controller/homecontroller.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  ScrollController scrollController = new ScrollController();
  List<Data> allDatas = [];
  String error = "";

  void fetchdatas() async{


    homeController.fetchDatas(pages: homeController.pages).then((value) {
      if(value is Datas){
        setState(() {
          allDatas = value;
        });
      }else {
        error = value.toString();
      }
    });
  }


  @override
  void initState() {
    super.initState();
    fetchdatas();
    scrollController.addListener(() async{
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels){
        if(homeController.pages < homeController.totalpage){
          homeController.pages = homeController.pages+1;
          homeController.fetchDatas(pages: homeController.pages).then((value) {
            setState(() {
              allDatas.addAll(value);
            });
          });
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    //fetchdatas();
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: error == ""?
            Center(
              child: CircularProgressIndicator()) : ListView.builder(
            controller: scrollController,
            itemCount: allDatas.length,
            itemBuilder: (BuildContext ctx,index){
              String image_url = allDatas[index].avatar.toString();
              return Container(
                height: MediaQuery.of(context).size.height *.2,
                width:  MediaQuery.of(context).size.width,
                child: ListTile(
                  leading:  Image.network(image_url),
                  subtitle: Text("RS :"+allDatas[index].firstName.toString()),
                  title: Text(allDatas[index].email!),
                ),
              );
            },
          ),

      ),
    );
  }
}
