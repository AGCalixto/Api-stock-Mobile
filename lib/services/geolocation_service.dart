class GeolocationService {
  Future<String> getCurrentLocation() async {
    // Simulated location detection
    await Future.delayed(const Duration(seconds: 1));

    const locations = ['United States', 'Germany', 'United Kingdom', 'Japan'];
    return locations[DateTime.now().second % locations.length];
  }
}