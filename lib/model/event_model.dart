// ignore_for_file: non_constant_identifier_names

class EventModel {
  late String eventname;
  late String thumb_url;
  late String event_url;
  late String start_time_display;
  late String location;

  EventModel(
      {required this.eventname,
      required this.thumb_url,
      required this.event_url,
      required this.start_time_display,
      required this.location});

  EventModel.fromJson(Map<String, dynamic> json) {
    eventname = json['eventname'];
    thumb_url = json['thumb_url'];
    event_url = json['event_url'];
    start_time_display = json['start_time_display'];
    location = json['location'];
  }
}
