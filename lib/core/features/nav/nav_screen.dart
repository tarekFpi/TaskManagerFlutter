import 'package:cares_task/core/features/crud/insert_screen.dart';
import 'package:cares_task/core/features/nav/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {

  int currentPageIndex = 0;


  List<Widget> pages =   [
    const HomeScreen(),
    const InsertScreen(),
  ];

  @override
  void initState() {

  var pageIndex = Get.arguments;

   if(pageIndex==2){
      currentPageIndex = 2;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: pages[currentPageIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 8,
              ),
            ],
          ),
          child: NavigationBar(
           // backgroundColor: lightColorScheme.surfaceVariant,
            backgroundColor: Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.white,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[

              NavigationDestination(
                icon: Icon( FluentIcons.home_20_filled),
                label: 'Home',
                selectedIcon: Icon(
                  FluentIcons.home_20_filled,
                  color: Colors.white,
                ),
              ),
              NavigationDestination(
                icon: Icon(Icons.add),
                selectedIcon: Icon(
                   Icons.add,
                  color: Colors.white,
                ),
                label: 'Add',
              ),
            ],
          ),
        )
    );
  }
}
