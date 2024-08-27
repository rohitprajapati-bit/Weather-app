class CityModel {
  String? name;
  String? latitude;
  String? longitude;

  CityModel({this.name, this.latitude, this.longitude});

}

 List<CityModel> cityList = [
    CityModel(name: "Mumbai", latitude: "19.076090", longitude: "72.877426"),
    CityModel(name: "Delhi", latitude: "28.6139", longitude: "77.2090"),
    CityModel(name: "Bengaluru", latitude: "12.9716", longitude: "77.5946"),
    CityModel(name: "Chennai", latitude: "13.0827", longitude: "80.2707"),
    CityModel(name: "Kolkata", latitude: "22.5726", longitude: "22.5726"),
    CityModel(name: "Hyderabad", latitude: "17.3850", longitude: "78.4867"),
    CityModel(name: "Pune", latitude: "18.5204", longitude: "73.8567"),
    CityModel(name: "Ahmedabad", latitude: "23.0225", longitude: "72.5714"),
    CityModel(name: "Jaipur", latitude: "26.9124", longitude: "75.7873"),
    CityModel(name: "Lucknow", latitude: "26.850000", longitude: "80.949997")
  ];
