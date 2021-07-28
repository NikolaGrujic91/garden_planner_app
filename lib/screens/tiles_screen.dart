import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/gardens_store.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/tiles_bottom_bar.dart';
import '../widgets/tiles_grid_view.dart';
import '../screens/main_screen.dart';

class TilesScreen extends StatelessWidget {
  static const String id = 'tiles_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<GardensStore>(builder: (context, gardensStore, child) {
      return Scaffold(
        appBar: BaseAppBar(
          backScreenID: MainScreen.id,
          title: gardensStore.gardens[gardensStore.selectedGardenIndex].name,
          saveCallback: null,
          appBar: AppBar(),
        ),
        body: TilesGrid(),
        bottomNavigationBar: TilesBottomBar(),
      );
    });
  }
}
