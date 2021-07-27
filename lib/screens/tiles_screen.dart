import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/gardens_store.dart';
import '../widgets/tiles_bottom_bar.dart';
import '../widgets/tiles_grid_view.dart';
import '../screens/main_screen.dart';
import '../utils/constants.dart';

class TilesScreen extends StatelessWidget {
  static const String id = 'tiles_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<GardensStore>(builder: (context, gardensStore, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarBackgroundColor,
          leading: new IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, MainScreen.id);
            },
            icon: new Icon(Icons.arrow_back_ios),
          ),
          title: Text(gardensStore.gardens[gardensStore.selectedGardenIndex].name),
        ),
        body: TilesGrid(),
        bottomNavigationBar: TilesBottomBar(),
      );
    });
  }
}
