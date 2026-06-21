import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Api/eventsApi.dart';
import '../Models/EventModel.dart';

class EventController extends GetxController {
  var isLoading = true.obs;
  var eventList = <EventModel>[].obs;

  void getEvents() async {
    try {
      isLoading(true);

      // نحدد النوع هنا بوضوح لتجنب الالتباس
      EventResponse? response = await EventApi().fetchEvents();

      if (response != null && response.success == true) {
        // الآن سيختفي الخطأ لأن Dart يعرف أن response هو EventResponse
        eventList.assignAll(response.data);
      }
    } catch (e) {
      print("Error fetching events: $e");
    } finally {
      isLoading(false);
    }
  }
}