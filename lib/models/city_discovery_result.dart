class CityDiscoveryResult {
  final bool success;
  final String? cityId;
  final String? cityName;
  final String? error;

  const CityDiscoveryResult({
    required this.success,
    this.cityId,
    this.cityName,
    this.error,
  });

  factory CityDiscoveryResult.success({
    required String cityId,
    required String cityName,
  }) {
    return CityDiscoveryResult(
      success: true,
      cityId: cityId,
      cityName: cityName,
    );
  }

  factory CityDiscoveryResult.failure(String error) {
    return CityDiscoveryResult(
      success: false,
      error: error,
    );
  }
}
