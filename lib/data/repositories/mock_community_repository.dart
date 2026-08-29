import 'dart:convert';
import 'dart:math';
import '../../core/storage/hive_box_manager.dart';
import '../models/post.dart';
import 'community_repository.dart';

class MockCommunityRepository implements CommunityRepository {
  static const String _boxName = 'community_posts';
  final double failureRate;
  final Random _random;

  MockCommunityRepository({this.failureRate = 0.0, int? seed})
      : _random = Random(seed);

  Future<void> init() async {}

  Future<void> _simulateLatencyAndFailure() async {
    final delay = 300 + _random.nextInt(600);
    await Future.delayed(Duration(milliseconds: delay));
    if (_random.nextDouble() < failureRate) {
      throw StorageException('Simulated network failure in MockCommunityRepository');
    }
  }

  Future<void> _seedInitialData(String village, String district) async {
    final box = await HiveBoxManager().openBox(_boxName);
    if (box.isEmpty) {
      final initialPosts = [
        Post(
          id: 'mock_post_1',
          authorProfileId: 'some_other_farmer_1',
          authorDisplayName: 'A farmer in your village',
          village: village,
          district: district,
          contentText: 'Noticed some yellowing on the tips of my paddy leaves this morning. Anyone else seeing this?',
          postType: PostType.observation,
          reportCount: 0,
          createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        ),
        Post(
          id: 'mock_post_2',
          authorProfileId: 'some_other_farmer_2',
          authorDisplayName: 'A farmer in $district',
          village: 'Other Village',
          district: district,
          contentText: 'The new canal schedule is out. Water will be released on Tuesday.',
          postType: PostType.tip,
          reportCount: 0,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Post(
          id: 'mock_post_3',
          authorProfileId: 'some_other_farmer_3',
          authorDisplayName: 'A farmer in your village',
          village: village,
          district: district,
          contentText: 'This post was reported too many times and should be hidden.',
          postType: PostType.question,
          reportCount: 5,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ];
      for (final post in initialPosts) {
        final map = {
          'id': post.id,
          'authorProfileId': post.authorProfileId,
          'authorDisplayName': post.authorDisplayName,
          'village': post.village,
          'district': post.district,
          'contentText': post.contentText,
          'postType': post.postType.name,
          'reportCount': post.reportCount,
          'createdAt': post.createdAt.toIso8601String(),
        };
        await box.put(post.id, jsonEncode(map));
      }
    }
  }

  Post _fromJson(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      authorProfileId: map['authorProfileId'],
      authorDisplayName: map['authorDisplayName'],
      village: map['village'],
      district: map['district'],
      contentText: map['contentText'],
      postType: PostType.values.firstWhere((e) => e.name == map['postType']),
      reportCount: (map['reportCount'] as num).toInt(),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> _toJson(Post post) {
    return {
      'id': post.id,
      'authorProfileId': post.authorProfileId,
      'authorDisplayName': post.authorDisplayName,
      'village': post.village,
      'district': post.district,
      'contentText': post.contentText,
      'postType': post.postType.name,
      'reportCount': post.reportCount,
      'createdAt': post.createdAt.toIso8601String(),
    };
  }

  @override
  Future<List<Post>> getFeed(String village, String district) async {
    await _simulateLatencyAndFailure();
    try {
      await _seedInitialData(village, district);

      final box = await HiveBoxManager().openBox(_boxName);
      final feed = <Post>[];
      for (final value in box.values) {
        final post = _fromJson(jsonDecode(value));
        // Region scoping: Must match village AND district
        if (post.village == village && post.district == district && !post.isHidden) {
          feed.add(post);
        }
      }
      
      // Sort most recent first
      feed.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return feed;
    } catch (e) {
      throw StorageException('Failed to get community feed', e);
    }
  }

  @override
  Future<Post?> getPost(String id) async {
    await _simulateLatencyAndFailure();
    try {
      final box = await HiveBoxManager().openBox(_boxName);
      final jsonStr = box.get(id);
      if (jsonStr != null) {
        return _fromJson(jsonDecode(jsonStr));
      }
      return null;
    } catch (e) {
      throw StorageException('Failed to get post', e);
    }
  }

  @override
  Future<void> reportPost(String id) async {
    try {
      final box = await HiveBoxManager().openBox(_boxName);
      final jsonStr = box.get(id);
      if (jsonStr != null) {
        final post = _fromJson(jsonDecode(jsonStr));
        final updated = Post(
          id: post.id,
          authorProfileId: post.authorProfileId,
          authorDisplayName: post.authorDisplayName,
          village: post.village,
          district: post.district,
          contentText: post.contentText,
          postType: post.postType,
          reportCount: post.reportCount + 1,
          createdAt: post.createdAt,
        );
        await box.put(id, jsonEncode(_toJson(updated)));
      }
    } catch (e) {
      throw StorageException('Failed to report post', e);
    }
  }
}
