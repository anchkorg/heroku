//import 'dart:math';

import 'event_history_model.dart';

class EventCategory {
  final String name;
  final List<EventHistory> events;

  EventCategory(this.name, this.events);
  factory EventCategory.fromMap(Map<String, dynamic> map) {
    List<EventHistory> underscoreEvents =
        EventHistory.fromMap(map['events']) as List<EventHistory>;
    return EventCategory(
      map['name'],
      underscoreEvents,
    );
  }
  factory EventCategory.fromCategoryName(
      String name, Map<String, dynamic> map) {
    List<EventHistory> underscoreEvents =
        EventHistory.fromMap(map) as List<EventHistory>;
    List<EventHistory> underscoreCategoryEvents =
        underscoreEvents.where((element) => element.category == name).toList();
    return EventCategory(
      name,
      underscoreCategoryEvents,
    );
  }
  factory EventCategory.byCategoryName(String name, List<EventHistory> events) {
    List<EventHistory> underscoreCategoryEvents =
        events.where((element) => element.category == name).toList();
    return EventCategory(
      name,
      underscoreCategoryEvents,
    );
  }
  @override
  String toString() {
    return 'EventCategory\nname: $name\nnumber of events: ${events.length}\nEvents\n${events.toString()}';
  }

  Map<String, dynamic> toEventJson() => {
        "name": name,
        "events":
            List<dynamic>.from(events.map((x) => x.fromCategoryToJson(name))),
      };
}
