class Post {
  final String title;
  final List<Uri> mediaUrls;
  final String author;
  final bool isVideo;

  Post({
    required this.title,
    required this.mediaUrls,
    required this.author,
    required this.isVideo,
  });

  factory Post.fromRedditJson(Map<String, dynamic> data) {
    final isPostVideo = data['is_video'] == true;
    final List<Uri> collectedmediaUrls = [];

    final galleryItems = _getGalleryItems(data);
    if (galleryItems.isNotEmpty) {
      collectedmediaUrls.addAll(galleryItems);
    }

    if (collectedmediaUrls.isEmpty) {
      final singleMediaItem = _getBestSingleMediaItem(data, isPostVideo);
      if (singleMediaItem != null) {
        collectedmediaUrls.add(singleMediaItem);
      }
    }

    return Post(
      title: data['title'] as String,
      mediaUrls: collectedmediaUrls,
      author: data['author'] as String,
      isVideo: isPostVideo,
    );
  }

  static List<Uri> _getGalleryItems(Map<String, dynamic> post) {
    final List<Uri> items = [];
    final mediaMetadata = post['media_metadata'];

    if (mediaMetadata is Map<String, dynamic>) {
      for (final key in mediaMetadata.keys) {
        final item = mediaMetadata[key];

        if (item is Map<String, dynamic> && item['s'] is Map<String, dynamic>) {
          final source = item['s'];
          if (source['u'] != null &&
              source['x'] != null &&
              source['y'] != null) {
            try {
              final cleanUrl = (source['u'] as String).replaceAll('&amp;', '&');
              items.add(Uri.parse(cleanUrl));
            } catch (e) {
              continue;
            }
          }
        }
      }
    }
    return items;
  }

  static Uri? _getBestSingleMediaItem(Map<String, dynamic> post, bool isVideo) {
    if (isVideo) {
      final secureMedia = post['secure_media'];
      if (secureMedia is Map<String, dynamic> &&
          secureMedia['reddit_video'] is Map<String, dynamic>) {
        final redditVideo = secureMedia['reddit_video'] as Map<String, dynamic>;
        final fallbackUrl = redditVideo['fallback_url'] as String?;
        return fallbackUrl == null
            ? null
            : Uri.parse(fallbackUrl.replaceAll('&amp;', '&'));
      }
    }

    final preview = post['preview'];
    if (preview != null &&
        preview['images'] is List &&
        preview['images'].isNotEmpty) {
      final images = preview['images'] as List<dynamic>;
      final image = images[0];

      if (image != null) {
        final source = image['source'];
        if (source != null &&
            source['url'] != null &&
            source['width'] != null &&
            source['height'] != null) {
          final postUrl = source['url'] as String;

          final cleanUrl = postUrl.replaceAll('&amp;', '&');
          return Uri.parse(cleanUrl);
        }
      }
    }

    // TOP-LEVEL FALLBACK (without reliable aspect ratio data, so we skip it)
    return null;
  }
}
