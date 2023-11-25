import 'package:cares_task/core/features/auth/auth_controller.dart';
import 'package:cares_task/core/features/home/course_details_screen.dart';
import 'package:cares_task/core/features/home/home_controller.dart';
import 'package:cares_task/core/features/home/model/course_response.dart';
import 'package:cares_task/core/theme/color_scheme.dart';
import 'package:cares_task/core/utils/hexcolor.dart';
import 'package:cares_task/core/widgets/custom_error_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final authController = Get.put(AuthController());

  final homeController = Get.put(HomeController());

  final queryEditingController = TextEditingController();

  String query = "";

  void goToDetails(Products courseResponse){

    FocusScope.of(context).unfocus();

    Get.to(() => CourseDetailsScreen(
      courselist: courseResponse,
    ));

  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(child: Scaffold(
      appBar:AppBar(
        backgroundColor:darkColorScheme.inverseSurface,
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Home Page",
          style: textTheme.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),actions: [

        IconButton(
          onPressed: () {

            authController.logout();
          },
          icon: CircleAvatar(
            child: Icon(FluentIcons.lock_closed_12_regular,size: 24,),
            radius: 24.0,
            backgroundColor: HexColor("#F5F6FC"),
          ),
        )
      ],),

      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [

            Card(
              child: TextFormField(
                controller: queryEditingController,
                decoration: InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    hintText: "Search...For..title",
                    prefixIcon: Icon(
                      Icons.search,
                      color: HexColor('#855EA9'),
                    ),

                    hintStyle: textTheme.bodyMedium
                        ?.copyWith(color: HexColor("#BCC2EB")),
                    suffixIcon: query.isBlank == true || query.isEmpty
                        ? Icon(
                      FluentIcons.search_24_regular,
                      color: HexColor("#BCC2EB"),
                    )
                        : IconButton(
                        icon: Icon(Icons.close, color: HexColor("#BCC2EB")),
                        onPressed: () {
                          //clear query
                          setState(() {
                            query = "";
                          });
                          queryEditingController.clear();
                          FocusScope.of(context).unfocus();
                          homeController.filterUserList(null);
                        })

                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                 homeController.filterUserList(value);
                },
              ),
            ),

            Expanded(
              child: homeController.obx((state) =>
                  RefreshIndicator(child: ListView.builder(
                      itemCount: state!.length,
                      itemBuilder: (BuildContext context,index){

                        final item = state[index];

                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: (){
                            goToDetails(item);
                          },
                          child: Card(
                            color:  HexColor("#FAFDFC"),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Card(child: Image.network("${item.thumbnail}",width: double.infinity,height: 200,fit: BoxFit.fill,)),

                                        Text(
                                          "title : ${item.title}",
                                          style: textTheme.bodySmall?.copyWith(
                                              color: lightColorScheme.onTertiaryContainer,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Description :${item.description}",
                                          style: textTheme.bodySmall?.copyWith(
                                              color: lightColorScheme.onTertiaryContainer,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Price :${item.price}",
                                            style: textTheme.bodySmall?.copyWith(
                                                color: lightColorScheme.primary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),



                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }), onRefresh: homeController.showCourseList),onError: (msg) {
                return CustomErrorWidget(
                    icon: Icon(
                      msg == "No Internet." ? FluentIcons.wifi_off_24_regular : FluentIcons.error_circle_24_filled,
                      color: Colors.red,
                      size: 40,
                    ),
                    btnLevel: "Retry",
                    message: msg.toString(),
                    onClick: () {
                      homeController.showCourseList();
                    });
              }),
            ),
          ],
        ),
      ),
    ));
  }
}
