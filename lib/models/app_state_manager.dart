import 'package:flutter/material.dart';
import './nft_view.dart';

class AppStateManager extends ChangeNotifier {
  final List<String> _likedPosts = <String>[];
  final List<String> _followedProfiles = <String>[];
  String _selectedCategory = "art";
  bool _onboardingComplete = false;

  bool hasSelectedPost = false;
  late NFTView _currentlySelectedPost;

  bool get isOnboardingComplete => _onboardingComplete;
  String get currentCategory => _selectedCategory;
  List<String> get likedPosts => List.unmodifiable(_likedPosts);
  List<String> get followedProfiles => List.unmodifiable(_followedProfiles);
  NFTView get selectedPost => _currentlySelectedPost;

  void completeOnboarding() {
    _onboardingComplete = true;
    notifyListeners();
  }

  void changeSelectedPost(NFTView? post) {
    if (post != null) {
      _currentlySelectedPost = post;
      hasSelectedPost = true;
    } else {
      hasSelectedPost = false;
    }

    notifyListeners();
  }

  void changeCategory(String newCategory) {
    _selectedCategory = newCategory;
    notifyListeners();
  }

  void addLikedPost(String id) {
    if (!isLikedPostPresent(id)) {
      _likedPosts.add(id);
      notifyListeners();
    }
  }

  void removeLikedPost(String id) {
    _likedPosts.remove(id);
    notifyListeners();
  }

  bool isLikedPostPresent(String postId) {
    return _isElementPresent(_likedPosts, postId);
  }

  void addFollowedProfile(String profile) {
    if (!isFollowedProfilePresent(profile)) {
      _followedProfiles.add(profile);
    }
    notifyListeners();
  }

  void removeFollowedProfile(String profile) {
    _followedProfiles.remove(profile);
    notifyListeners();
  }

  bool isFollowedProfilePresent(String profile) {
    return _isElementPresent(_followedProfiles, profile);
  }

  bool _isElementPresent(List<String> list, String target) {
    final dynamic element = list.firstWhere(
      (element) => element == target,
      orElse: () => 'null',
    );

    if (element != 'null') {
      return true;
    } else {
      return false;
    }
  }
}
