import '../models/yield_prediction.dart';

abstract class YieldRepository {
  Future<YieldPrediction?> getLatest(String farmerProfileId);
}
