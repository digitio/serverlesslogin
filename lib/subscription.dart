class Subscription {
  final String name;
  final String subscriptionType;
  final String websiteName;
  final DateTime startDate;
  final DateTime endDate;

  Subscription({
    required this.name,
    required this.subscriptionType,
    required this.websiteName,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'subscriptionType': subscriptionType,
        'websiteName': websiteName,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      };

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      name: json['name'],
      subscriptionType: json['subscriptionType'],
      websiteName: json['websiteName'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}
