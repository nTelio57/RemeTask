import 'package:flutter/material.dart';
import 'package:remetask/Utilities/constants.dart';

class BottomNavigationButton extends StatelessWidget {
  const BottomNavigationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fabButton();
  }

  Widget fabButton(){
    return FloatingActionButton(
      onPressed: (){
        print('Add task clicked');
      },
      child: Icon(Icons.add),
      backgroundColor: kComplementaryColor,
    );
  }

}


class BottomNavigationMenus extends StatelessWidget {
  const BottomNavigationMenus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bottomAppBar();
  }

  Widget bottomAppBar(){
    return BottomAppBar(
      shape: CircularNotchedRectangle(

      ),
      color: kPrimaryColor,
      child: IconTheme(
        data: IconThemeData(
          color: kTextOnPrimary
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.groups),
              onPressed: (){},
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.list_alt),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}
