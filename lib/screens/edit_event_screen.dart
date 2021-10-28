import 'package:flutter/material.dart';
import 'package:garden_planner_app/screens/edit_plant_screen.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/widgets/base_app_bar.dart';
import 'package:garden_planner_app/widgets/date_picker.dart';
import 'package:garden_planner_app/widgets/styled_outlined_button.dart';
import 'package:garden_planner_app/widgets/styled_text.dart';
import 'package:garden_planner_app/widgets/text_field_bordered.dart';

/// Main Screen Widget
class EditEventScreen extends StatelessWidget {
  /// Creates a new instance
  const EditEventScreen({Key? key}) : super(key: key);

  /// Screen ID
  static const String id = 'edit_event_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backScreenID: EditPlantScreen.id,
        title: 'Edit Event',
      ),
      body: Container(
        color: kBackgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Row(
              children: [
                const StyledText(
                  text: 'Start:',
                ),
                const Spacer(),
                StyledText(
                  text: '20.09.2021.',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                DatePicker(
                  restorationId: EditPlantScreen.id,
                  callback: (String newValue) {
                    /// TODO
                    //_setPlantedDate(newValue);
                  },
                  initialDate: '',
                  text: 'Edit Start Date',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const StyledText(
                  text: 'Repeat:',
                ),
                const Spacer(),
                StyledText(
                  text: 'Never',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                StyledOutlinedButton(
                  text: 'Edit Repeat',
                  onPressed: () async {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
