class Bus {
  final int id;
  final String plateNumber;
  final int capacity;
  final String driverName;

  Bus({
    required this.id,
    required this.plateNumber,
    required this.capacity,
    required this.driverName,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id'],
      plateNumber: json['plateNumber'],
      capacity: json['capacity'],
      driverName: json['driverName'],
    );
  }
}
