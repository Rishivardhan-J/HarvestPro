import 'dart:convert';
import 'dart:math';
import '../../core/storage/hive_box_manager.dart';
import '../models/recommendation.dart';
import 'recommendation_repository.dart';

class MockRecommendationRepository implements RecommendationRepository {
  static const String _boxName = 'recommendations';
  final double failureRate;
  final Random _random;

  MockRecommendationRepository({this.failureRate = 0.0, int? seed})
      : _random = Random(seed);

  Future<void> init() async {}

  Future<void> _simulateLatencyAndFailure() async {
    final delay = 300 + _random.nextInt(600);
    await Future.delayed(Duration(milliseconds: delay));
    if (_random.nextDouble() < failureRate) {
      throw StorageException('Simulated network failure in MockRecommendationRepository');
    }
  }

  Future<void> _seedInitialData(String profileId) async {
    final box = await HiveBoxManager().openBox(_boxName);
    if (box.isEmpty) {
      final initialRecs = [
        Recommendation(
          id: 'mock_rec_1',
          farmerProfileId: profileId,
          titleKey: 'recommendations_fertilizer_urea',
          descriptionKey: 'recommendations_fertilizer_urea_desc',
          estimatedValueRupees: 450.0,
          estimatedValueUnit: EstimatedValueUnit.perAcre,
          category: RecommendationCategory.fertilizer,
          status: RecommendationStatus.pending,
          iconKey: 'science',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Recommendation(
          id: 'mock_rec_2',
          farmerProfileId: profileId,
          titleKey: 'recommendations_pest_stem_borer',
          descriptionKey: 'recommendations_pest_stem_borer_desc',
          estimatedValueRupees: 1200.0,
          estimatedValueUnit: EstimatedValueUnit.total,
          category: RecommendationCategory.pest,
          status: RecommendationStatus.pending,
          iconKey: 'pest_control',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ];
      for (final rec in initialRecs) {
        // Manually build JSON to avoid toJson missing scheduledFor until build_runner is run
        final map = {
          'id': rec.id,
          'farmerProfileId': rec.farmerProfileId,
          'titleKey': rec.titleKey,
          'descriptionKey': rec.descriptionKey,
          'estimatedValueRupees': rec.estimatedValueRupees,
          'estimatedValueUnit': rec.estimatedValueUnit.name,
          'category': rec.category.name,
          'status': rec.status.name,
          'iconKey': rec.iconKey,
          'createdAt': rec.createdAt.toIso8601String(),
        };
        await box.put(rec.id, jsonEncode(map));
      }
    }
  }

  Recommendation _fromJson(Map<String, dynamic> map) {
    return Recommendation(
      id: map['id'],
      farmerProfileId: map['farmerProfileId'],
      titleKey: map['titleKey'],
      descriptionKey: map['descriptionKey'],
      estimatedValueRupees: (map['estimatedValueRupees'] as num).toDouble(),
      estimatedValueUnit: EstimatedValueUnit.values.firstWhere((e) => e.name == map['estimatedValueUnit']),
      category: RecommendationCategory.values.firstWhere((e) => e.name == map['category']),
      status: RecommendationStatus.values.firstWhere((e) => e.name == map['status']),
      iconKey: map['iconKey'],
      createdAt: DateTime.parse(map['createdAt']),
      scheduledFor: map['scheduledFor'] != null ? DateTime.parse(map['scheduledFor']) : null,
    );
  }

  Map<String, dynamic> _toJson(Recommendation rec) {
    return {
      'id': rec.id,
      'farmerProfileId': rec.farmerProfileId,
      'titleKey': rec.titleKey,
      'descriptionKey': rec.descriptionKey,
      'estimatedValueRupees': rec.estimatedValueRupees,
      'estimatedValueUnit': rec.estimatedValueUnit.name,
      'category': rec.category.name,
      'status': rec.status.name,
      'iconKey': rec.iconKey,
      'createdAt': rec.createdAt.toIso8601String(),
      if (rec.scheduledFor != null) 'scheduledFor': rec.scheduledFor!.toIso8601String(),
    };
  }

  @override
  Future<List<Recommendation>> getActiveRecommendations(String farmerProfileId) async {
    await _simulateLatencyAndFailure();
    try {
      await _seedInitialData(farmerProfileId);

      final now = DateTime.now();
      final active = <Recommendation>[];

      final box = await HiveBoxManager().openBox(_boxName);
      for (final value in box.values) {
        final rec = _fromJson(jsonDecode(value));
        if (rec.farmerProfileId != farmerProfileId) {
          continue;
        }

        if (rec.status == RecommendationStatus.pending) {
          active.add(rec);
        } else if (rec.status == RecommendationStatus.remindLater) {
          if (rec.scheduledFor != null && (now.isAfter(rec.scheduledFor!) || now.isAtSameMomentAs(rec.scheduledFor!))) {
            active.add(rec);
          }
        }
      }
      
      // Sort by createdAt descending
      active.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return active;
    } catch (e) {
      throw StorageException('Failed to get active recommendations', e);
    }
  }

  @override
  Future<void> updateRecommendationStatus(String id, RecommendationStatus status, {DateTime? scheduledFor}) async {
    try {
      final box = await HiveBoxManager().openBox(_boxName);
      final jsonStr = box.get(id);
      if (jsonStr != null) {
        final rec = _fromJson(jsonDecode(jsonStr));
        // Using manual replacement since copyWith might not exist for scheduledFor yet
        final updated = Recommendation(
          id: rec.id,
          farmerProfileId: rec.farmerProfileId,
          titleKey: rec.titleKey,
          descriptionKey: rec.descriptionKey,
          estimatedValueRupees: rec.estimatedValueRupees,
          estimatedValueUnit: rec.estimatedValueUnit,
          category: rec.category,
          status: status,
          iconKey: rec.iconKey,
          createdAt: rec.createdAt,
          scheduledFor: scheduledFor ?? rec.scheduledFor,
        );
        await box.put(id, jsonEncode(_toJson(updated)));
      }
    } catch (e) {
      throw StorageException('Failed to update recommendation status', e);
    }
  }

  @override
  Future<List<Recommendation>> getCompletedRecommendations(String farmerProfileId) async {
    try {
      final box = await HiveBoxManager().openBox(_boxName);
      final completed = <Recommendation>[];
      for (final value in box.values) {
        final rec = _fromJson(jsonDecode(value));
        if (rec.farmerProfileId == farmerProfileId && rec.status == RecommendationStatus.done) {
          completed.add(rec);
        }
      }
      return completed;
    } catch (e) {
      throw StorageException('Failed to get completed recommendations', e);
    }
  }
}
