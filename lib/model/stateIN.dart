
// State class definition
class StateIN {
  String name;
  List<String> districts;

  // Constructor
  StateIN({required this.name, required this.districts});

  // Factory method to create a State object from JSON
  factory StateIN.fromJson(Map<String, dynamic> json) {
    return StateIN(
      name: json['state'],
      districts: List<String>.from(json['districts']),
    );
  }
}
