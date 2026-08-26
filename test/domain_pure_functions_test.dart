import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/data/models/post.dart';
import 'package:harvestpro/data/models/yield_prediction.dart';

void main() {
  group('YieldPrediction Pure Functions', () {
    test('deriveStatus correctly categorizes yield', () {
      expect(YieldPrediction.deriveStatus(80.0), YieldStatus.good);
      expect(YieldPrediction.deriveStatus(70.0), YieldStatus.good);
      expect(YieldPrediction.deriveStatus(69.9), YieldStatus.caution);
      expect(YieldPrediction.deriveStatus(40.0), YieldStatus.caution);
      expect(YieldPrediction.deriveStatus(39.9), YieldStatus.critical);
      expect(YieldPrediction.deriveStatus(10.0), YieldStatus.critical);
    });
  });

  group('Post Pure Functions', () {
    test('deriveIsHidden triggers at 3 reports', () {
      expect(Post.deriveIsHidden(0), false);
      expect(Post.deriveIsHidden(2), false);
      expect(Post.deriveIsHidden(3), true);
      expect(Post.deriveIsHidden(5), true);
    });
  });
}
