class MLResponse {
  final int cls;
  final String description;
  final String method;
  final String route;

  MLResponse({this.cls, this.description, this.method, this.route});

  // Sample response
  //  {
  //  "class": 1,
  //  "description": "",
  //  "method": "POST",
  //  "route": "/classify_image"
  //  }

  factory MLResponse.fromJson(Map<String, dynamic> json) {
    return MLResponse(
      cls: json['class'],
      description: json['description'],
      method: json['method'],
      route: json['route'],
    );
  }
}