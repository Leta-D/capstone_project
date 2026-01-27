class ItemModel {
  String donationId;
  String donorId;
  String? ngoId;
  String name;
  String type;
  String description;
  bool available;
  String location;
  String image;
  DateTime createdAt;

  ItemModel({
    required this.donationId,
    required this.donorId,
    required this.ngoId,
    required this.name,
    required this.type,
    required this.description,
    required this.available,
    required this.location,
    required this.image,
    required this.createdAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      donationId: json['donationId'] as String,
      donorId: json['donorId'] as String,
      ngoId: json['ngoId'] as String?,
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      available: json['available'] as bool,
      location: json['location'] as String,
      image: json['image'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}


// zufan = 0967433800 - 99
//         0967430000 -
//         0967433700 - 03
// winza = 0967433800 - 20* -40

// 15806401
// 75884244
// 88161426





