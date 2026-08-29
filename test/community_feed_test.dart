import 'package:flutter_test/flutter_test.dart';
import 'package:harvestpro/data/repositories/mock_community_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUp(() async {
    // Setup in-memory Hive for testing
    Hive.init('test_hive_temp');
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  test('MockCommunityRepository filters feed by village and district', () async {
    final repo = MockCommunityRepository(seed: 42);
    final feed = await repo.getFeed('Village', 'District');
    
    // Only posts matching 'Village' and 'District' should be returned.
    expect(feed.every((p) => p.village == 'Village' && p.district == 'District'), isTrue);
  });

  test('MockCommunityRepository auto-hides post after 3 reports', () async {
    final repo = MockCommunityRepository(seed: 42);
    // Seed data
    await repo.getFeed('Village', 'District');
    
    const postId = 'mock_post_1'; // Starts with 0 reports
    
    // Report 1
    await repo.reportPost(postId);
    var post = await repo.getPost(postId);
    expect(post?.reportCount, 1);
    expect(post?.isHidden, isFalse);

    // Report 2
    await repo.reportPost(postId);
    post = await repo.getPost(postId);
    expect(post?.reportCount, 2);
    expect(post?.isHidden, isFalse);

    // Report 3
    await repo.reportPost(postId);
    post = await repo.getPost(postId);
    expect(post?.reportCount, 3);
    expect(post?.isHidden, isTrue);

    // Check if it's hidden from feed
    final feed = await repo.getFeed('Village', 'District');
    expect(feed.any((p) => p.id == postId), isFalse);
  });
}
