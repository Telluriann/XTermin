import 'dart:math';

enum PestRiskLevel { low, medium, high }

class DashboardMetrics {
  final double temperature; // in Celsius
  final double humidity; // in Percentage
  final double soilMoisture; // in Percentage
  final PestRiskLevel pestRisk;

  DashboardMetrics({
    required this.temperature,
    required this.humidity,
    required this.soilMoisture,
    required this.pestRisk,
  });

  // Mock data for initial rendering
  static DashboardMetrics get mockData => DashboardMetrics(
        temperature: 28.5,
        humidity: 65.0,
        soilMoisture: 42.0,
        pestRisk: PestRiskLevel.medium,
      );

  // Generate random data
  static DashboardMetrics generateRandom() {
    final random = Random();
    
    // Bounds: Temperature: 25 - 35, Humidity: 50 - 90, Soil Moisture: 20 - 60
    final temp = 25.0 + random.nextDouble() * 10.0;
    final hum = 50.0 + random.nextDouble() * 40.0;
    final soil = 20.0 + random.nextDouble() * 40.0;

    PestRiskLevel risk;
    if (hum > 70 && temp > 25) {
      risk = PestRiskLevel.high;
    } else if (hum >= 50 && hum <= 70) {
      risk = PestRiskLevel.medium;
    } else {
      risk = PestRiskLevel.low;
    }

    return DashboardMetrics(
      temperature: temp,
      humidity: hum,
      soilMoisture: soil,
      pestRisk: risk,
    );
  }
}
