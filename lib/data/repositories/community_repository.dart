import '../models/post.dart';

abstract class CommunityRepository {
  Future<List<Post>> getFeed(String village, String district);
  Future<Post?> getPost(String id);
}
