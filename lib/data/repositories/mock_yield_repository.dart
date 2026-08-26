import 'dart:math';
import '../models/yield_prediction.dart';
import 'yield_repository.dart';

class MockYieldRepository implements YieldRepository {
  final double failureRate;
  final Random _random;

  MockYieldRepository({this.failureRate = 0.0, int? seed})
      : _random = Random(seed);

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
    
    // Seed realistic paddy yield data
    return YieldPrediction(
      id: 'mock_yield_${_random.nextInt(1000)}',
      farmerProfileId: farmerProfileId,
      predictedYieldPercent: 65.0 + (_random.nextDouble() * 20.0 - 10.0), // 55% - 75%
      factors: [
        const YieldFactor(label: 'Soil Moisture', contributionValue: 0.15, iconKey: 'water_drop'),
        const YieldFactor(label: 'Pest Risk', contributionValue: -0.10, iconKey: 'bug_report'),
      ],
      sourceBadges: [SourceBadge.imdWeatherVerified],
      generatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    );
  }
}
