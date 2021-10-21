import 'package:flutter/material.dart';
import 'package:remetask/Utilities/constants.dart';
import 'package:remetask/Views/task_list_view.dart';
import 'package:remetask/Views/workspace_list_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int _selectedIndex = 1;

  var _navigationPages = [
    Container(color: Colors.red,),
    TaskListView(),
    WorkspaceListView(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        bottomNavigationBar: bottomNavBar(),
        body: _navigationPages.elementAt(_selectedIndex)
      ),
    );
  }

  void _onItemTapped(int index)
  {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget bottomNavBar()
  {

    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Tasks'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.view_carousel),//view_agenda view_carousel
            label: 'Workspaces'
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: kPrimaryColor,
      onTap: _onItemTapped,
    );
  }
}

