import 'dart:math';
import '../models/yield_prediction.dart';
import 'yield_repository.dart';

class MockYieldRepository implements YieldRepository {
  final double failureRate;
  final Random _random;

  MockYieldRepository({this.failureRate = 0.0, int? seed})
      : _random = Random(seed);

  // 0 = Random, 1 = Good (82%), 2 = Caution (54%), 3 = Critical (23%)
  int debugScenario = 0;

  Future<void> _simulateLatencyAndFailure() async {
    final delay = 300 + _random.nextInt(600);
    await Future.delayed(Duration(milliseconds: delay));
    if (_random.nextDouble() < failureRate) {
      throw Exception('Simulated network failure in MockYieldRepository');
    }
  }

  @override
  Future<YieldPrediction?> getLatest(String farmerProfileId) async {
    await _simulateLatencyAndFailure();
    
    if (debugScenario == 1) {
      return YieldPrediction(
        id: 'mock_yield_good_${DateTime.now().millisecondsSinceEpoch}',
        farmerProfileId: farmerProfileId,
        predictedYieldPercent: 82.0,
        factors: const [
          YieldFactor(label: 'factor_soilMoisture', contributionValue: 0.15, iconKey: 'water_drop'),
          YieldFactor(label: 'factor_pestRisk', contributionValue: -0.05, iconKey: 'bug_report'),
        ],
        sourceBadges: const [SourceBadge.imdWeatherVerified, SourceBadge.agriStackLinked],
        generatedAt: DateTime.now().subtract(const Duration(hours: 1)),
      );
    } else if (debugScenario == 2) {
      return YieldPrediction(
        id: 'mock_yield_caution_${DateTime.now().millisecondsSinceEpoch}',
        farmerProfileId: farmerProfileId,
        predictedYieldPercent: 54.0,
        factors: const [
          YieldFactor(label: 'factor_pestRisk', contributionValue: -0.25, iconKey: 'bug_report'),
          YieldFactor(label: 'factor_rainfall', contributionValue: -0.15, iconKey: 'cloud'),
        ],
        sourceBadges: const [SourceBadge.imdWeatherVerified],
        generatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      );
    } else if (debugScenario == 3) {
      return YieldPrediction(
        id: 'mock_yield_critical_${DateTime.now().millisecondsSinceEpoch}',
        farmerProfileId: farmerProfileId,
        predictedYieldPercent: 23.0,
        factors: const [
          YieldFactor(label: 'factor_rainfall', contributionValue: -0.40, iconKey: 'cloud'),
          YieldFactor(label: 'factor_soilMoisture', contributionValue: -0.20, iconKey: 'water_drop'),
        ],
        sourceBadges: const [SourceBadge.imdWeatherVerified],
        generatedAt: DateTime.now().subtract(const Duration(hours: 3)),
      );
    }

    // Seed realistic paddy yield data (Random)
    return YieldPrediction(
      id: 'mock_yield_${_random.nextInt(1000)}',
      farmerProfileId: farmerProfileId,
      predictedYieldPercent: 65.0 + (_random.nextDouble() * 20.0 - 10.0), // 55% - 75%
      factors: const [
        YieldFactor(label: 'factor_soilMoisture', contributionValue: 0.15, iconKey: 'water_drop'),
        YieldFactor(label: 'factor_pestRisk', contributionValue: -0.10, iconKey: 'bug_report'),
      ],
      sourceBadges: const [SourceBadge.imdWeatherVerified],
      generatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    );
  }
}
