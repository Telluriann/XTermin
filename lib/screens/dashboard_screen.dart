import 'dart:async';
import 'package:flutter/material.dart';
import '../models/dashboard_metrics.dart';
import '../theme/app_colors.dart';
import '../widgets/metric_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardMetrics metrics;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    metrics = DashboardMetrics.generateRandom();
    
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          metrics = DashboardMetrics.generateRandom();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good Morning,',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'XTermin Dashboard',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceHighlight,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 2),
                    ),
                    child: const Icon(Icons.person, color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Alert Banner
              if (metrics.pestRisk == PestRiskLevel.high) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.danger.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: AppColors.danger, size: 32),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'High Pest Risk Detected!',
                              style: TextStyle(
                                color: AppColors.danger,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Recommended Action: Initiate spray protocols immediately.',
                              style: TextStyle(
                                color: AppColors.textPrimary.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Overview Section
              const Text(
                'Farm Overview',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              
              // Grid of metrics
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85, // Makes the cards slightly taller
                  children: [
                    MetricCard(
                      title: 'Temperature',
                      value: metrics.temperature.toStringAsFixed(1),
                      unit: '°C',
                      icon: Icons.thermostat,
                      tintColor: AppColors.warning,
                    ),
                    MetricCard(
                      title: 'Humidity',
                      value: metrics.humidity.toStringAsFixed(1),
                      unit: '%',
                      icon: Icons.water_drop,
                      tintColor: AppColors.secondary,
                    ),
                    MetricCard(
                      title: 'Soil Moisture',
                      value: metrics.soilMoisture.toStringAsFixed(1),
                      unit: '%',
                      icon: Icons.grass, // Material Icons generic grass/soil representation
                      tintColor: AppColors.moisture,
                    ),
                    _buildPestRiskCard(metrics.pestRisk),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPestRiskCard(PestRiskLevel risk) {
    Color riskColor;
    String riskText;
    IconData riskIcon = Icons.bug_report;

    switch (risk) {
      case PestRiskLevel.low:
        riskColor = AppColors.primary;
        riskText = 'Low';
        break;
      case PestRiskLevel.medium:
        riskColor = AppColors.warning;
        riskText = 'Medium';
        break;
      case PestRiskLevel.high:
        riskColor = AppColors.danger;
        riskText = 'High';
        break;
    }

    return MetricCard(
      title: 'Pest Risk',
      value: riskText,
      unit: '',
      icon: riskIcon,
      tintColor: riskColor,
    );
  }
}
