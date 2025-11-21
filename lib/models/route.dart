import 'bus.dart';

class Route {
  final int id;
  final String routeName;
  final Bus bus;
  final List<int> studentIds;
  final String polyline;

  Route({
    required this.id,
    required this.routeName,
    required this.bus,
    required this.studentIds,
    required this.polyline,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      id: json['id'],
      routeName: json['routeName'],
      bus: Bus.fromJson(json['bus']),
      studentIds: List<int>.from(json['studentIds'] ?? const []),
      polyline: json['polyline'],
    );
  }
}
