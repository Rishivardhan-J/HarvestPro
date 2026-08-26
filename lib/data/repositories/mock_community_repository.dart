import 'dart:math';
import '../models/post.dart';
import 'community_repository.dart';

class MockCommunityRepository implements CommunityRepository {
  final double failureRate;
  final Random _random;

  MockCommunityRepository({this.failureRate = 0.0, int? seed})
      : _random = Random(seed);

  Future<void> _simulateLatencyAndFailure() async {
    final delay = 300 + _random.nextInt(600);
    await Future.delayed(Duration(milliseconds: delay));
    if (_random.nextDouble() < failureRate) {
      throw Exception('Simulated network failure in MockCommunityRepository');
    }
  }

  @override
  Future<List<Post>> getFeed(String village, String district) async {
    await _simulateLatencyAndFailure();
    
    return [
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
  }

  @override
  Future<Post?> getPost(String id) async {
    await _simulateLatencyAndFailure();
    // Simulate finding a post
    return Post(
      id: id,
      authorProfileId: 'some_other_farmer_1',
      authorDisplayName: 'A farmer in your village',
      village: 'Village',
      district: 'District',
      contentText: 'Simulated post detail.',
      postType: PostType.observation,
      reportCount: 0,
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    );
  }
}
