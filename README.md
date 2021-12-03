# garden-planner-app

Tasks:
- DONE - add border around home tiles
- set correct app name in caption title on mac and windows
- set color scheme
- set app icon for all platforms
- DONE - extend tiles to store 4 plants (trees, fruits, vegetables, flowers)
- DONE - drag and drop on edit tiles screen
- DONE - Delete plants in Edit Plants screen
- DONE - Move IconData and color from tile class
- DONE - Edit tiles - short press opens dialog to change plants information
- DONE - Edit tiles - long press opens dialog to change tile type
- DONE - Zoom and pan grid
- DONE - Directly go back, no stack
- Set new icons
- DONE - Ratio of grid view to always follows ratio of rows and columns, so the tiles are always square
- DONE - Add max of four icons to tile, but one of each type
- DONE - Add unlimited fruits, vegetables, trees and flowers to tile, but only 4 icons are visible
- DONE - Text field display clear button
- DONE - Add extra/description field
- DONE - iOS & Android use picker to chose type of plants
- DONE - macOS & Win - tabbing between fields
- DONE - iOS & macOS - order of delete cancel buttons in modal dialogs
- DONE - macOS & Win - cursor change on tile
- DONE - Disable changing tile type if there is a plant on it
- DONE - Remove labels above text fields
- DONE - Reorder plant edit screen, planted date should be in separate row
- DONE - Divider between plant edit blocks
- macOS & Win - hover color
- iOS - check dark mode
- iOS - Launch screen
- Schedule for watering/notification, reminder
    - DONE - Model: extend plant.dart with 4 fields
        1. Watering (start date)
        2. Frequency (in days)
        3. Fertilizing (start date)
        4. Frequency (in days)
      Add HiveFields for proper serialization
    - DONE - Screens:
        1. Watering: reuse date_picker.dart
        2. Frequency: create modal widget with question "Water every
        _____ day
        (s)? "
        3. Fertilizing: reuse date_picker.dart
        4. Frequency: create modal widget with question "Fertilize every
        _____ day(s)?"

        2. & 4. can be the same modal widget that accepts different
        text.
        There are buttons already created in the edit_plant_screen.dart
        edit_event_screen.dart can be removed.
    - Calendar widget
      Add to the gardens list a calendar button, next to edit and delete button
      or as the action button while in the tiles view.
      Investigate if there is a calendar library, there was table_calendar at
       pub.dev.
      Display watering and fertilizing information in the calendar.
      - Calculate events dates
        - DONE Maps are stored on garden level
        - DONE Create wateringMap = LinkedHashMap<DateTime, List<String>>
        - DONE Create fertilizingMap = LinkedHashMap<DateTime, List<String>>
        - DONE Add hive types
        - save plant in edit plant dialog
        - on save calculate dates for events based on start date and frequency
        - calculate dates for next 5 years.
        - In calendar screen get selected garden, than get events from maps
          in function _getEventsForDay
- DONE - Photo
    - DONE - save image on local storage
    - DONE - name it as uuid
    - DONE - add image_uuid field to plant.dart
    - DONE - pick image from gallery
