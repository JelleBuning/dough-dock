import 'package:cached_network_image/cached_network_image.dart';
import 'package:dough_dock/ui/explore/view_model/explore_view_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key, required this.viewModel});
  final ExploreViewModel viewModel;
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool _isSearching = false;
  final FocusNode _searchFocusNode = FocusNode();
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  final Map<Uri, VideoPlayerController> _videoControllers = {};
  Future<void>? _currentVideoInitialization;
  Uri? _currentVideoUri;

  @override
  void initState() {
    super.initState();
    widget.viewModel.fetchExploreData();
    _searchFocusNode.addListener(_onSearchFocusChange);
  }

  void _onSearchFocusChange() {
    if (!_searchFocusNode.hasFocus && _isSearching) {
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.removeListener(_onSearchFocusChange);
    _searchFocusNode.dispose();
    _pageController.dispose();
    for (final controller in _videoControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _isSearching ? _buildSearchPage() : _buildExplorePage(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final leadingWidget =
        _isSearching
            ? IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _isSearching = false;
                });
              },
              icon: const Icon(Icons.arrow_back_rounded),
            )
            : null;

    final titlePadding = EdgeInsets.fromLTRB(_isSearching ? 0 : 15, 15, 15, 15);

    return AppBar(
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surface,
      titleSpacing: 0,
      leading: leadingWidget,
      title: Padding(
        padding: titlePadding,
        child: SizedBox(
          height: 40,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 750),
            child: TextField(
              focusNode: _searchFocusNode,
              controller: _searchController,
              onTap: () {
                setState(() {
                  _isSearching = true;
                });
              },
              onChanged: widget.viewModel.search,
              autofocus: false,
              style: const TextStyle(fontSize: 16, color: Color(0xFFbdc6cf)),
              decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                contentPadding: EdgeInsets.zero,
                border: _inputBorder(),
                focusedBorder: _inputBorder(),
                prefixIcon: const Icon(Icons.search_rounded),
              ),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide.none,
    );
  }

  Widget _buildExplorePage() {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        if (widget.viewModel.exploreResults.isEmpty) {
          return const SizedBox.shrink();
        }

        return ListView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          children:
              widget.viewModel.exploreResults
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 750),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                spacing: 10,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title),
                                  if (item.mediaUrls.isNotEmpty)
                                    _buildMediaContent(
                                      item.mediaUrls,
                                      item.isVideo,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        );
      },
    );
  }

  Widget _buildMediaContent(List<Uri> mediaUrls, bool isVideo) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromARGB(5, 255, 196, 86),
      ),
      child: AspectRatio(
        aspectRatio: 1.0,
        child:
            isVideo
                ? _buildVideoPlayer(mediaUrls.first)
                : PageView(
                  children:
                      mediaUrls
                          .map(
                            (url) => CachedNetworkImage(
                              imageUrl: url.toString(),
                              fit: BoxFit.contain,
                              placeholder:
                                  (context, url) => const SizedBox.shrink(),
                              errorWidget:
                                  (context, url, error) =>
                                      const Center(child: Icon(Icons.error)),
                            ),
                          )
                          .toList(),
                ),
      ),
    );
  }

  Widget _buildVideoPlayer(Uri videoUrl) {
    final controller = _getVideoController(videoUrl);

    if (_currentVideoUri != videoUrl) {
      _currentVideoUri = videoUrl;
      _currentVideoInitialization = _initializeVideo(controller);
    }

    return FutureBuilder<void>(
      future: _currentVideoInitialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (controller.value.hasError) {
            return const Center(child: Icon(Icons.error));
          }
          controller.play();
          return GestureDetector(
            onTap: () {
              setState(() {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
              });
            },
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: controller.value.size.width,
                      height: controller.value.size.height,
                      child: VideoPlayer(controller),
                    ),
                  ),
                  if (!controller.value.isPlaying)
                    const Icon(
                      Icons.play_circle_fill,
                      size: 64.0,
                      color: Colors.white70,
                    ),
                ],
              ),
            ),
          );
        } else {
          return const AspectRatio(
            aspectRatio: 16 / 9,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Future<void> _initializeVideo(VideoPlayerController controller) async {
    await controller.initialize();
    controller.setLooping(true);
    controller.setVolume(0.0);
    setState(() {});
  }

  VideoPlayerController _getVideoController(Uri url) {
    if (_videoControllers.containsKey(url)) {
      return _videoControllers[url]!;
    }
    final controller = VideoPlayerController.networkUrl(url);
    _videoControllers[url] = controller;
    return controller;
  }

  Widget _buildSearchPage() {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        return ListView.builder(
          itemCount: widget.viewModel.searchResults.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.viewModel.searchResults[index]),
              onTap: () {},
            );
          },
        );
      },
    );
  }
}
