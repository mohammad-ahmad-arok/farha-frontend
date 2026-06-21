import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

// تأكدي من صحة هذه المسارات في مشروع Farha الخاص بكِ
import '../../../Shared/Components/EventDetails/EventDetailsComponents.dart';
import '../../../Shared/Components/ServiceProvider/ServicesProviderComponents.dart';
import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/Colors.dart';

class ALahazej extends StatefulWidget {
  const ALahazej({super.key});

  @override
  State<ALahazej> createState() => _ALahazejState();
}

class _ALahazejState extends State<ALahazej> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // --- روابط صور جديدة ومباشرة من بيكسلز (Pexels) لضمان العمل ---
  final List<CategoryItem> categories = [
    CategoryItem(
      title: "أهازيج دينية",
      items: [
        CardItem(
          title: "يا رب",
          description: "أهزوجة دينية جميلة وهادئة",
          imageUrl: "https://images.pexels.com/photos/2233416/pexels-photo-2233416.jpeg?auto=compress&cs=tinysrgb&w=600",
          type: ItemType.audio,
          audioUrl: "assets/audios/1.mp3",
          lyrics: "يا رب يا رب...\nيا رب العالمين",
          duration: 180,
        ),
        CardItem(
          title: "صلوا على النبي",
          description: "مديح نبوي مميز وروحاني",
          imageUrl: "https://images.pexels.com/photos/8164381/pexels-photo-8164381.jpeg?auto=compress&cs=tinysrgb&w=600",
          type: ItemType.audio,
          audioUrl: "assets/audio/salu_ala_alnabi.mp3",
          lyrics: "صلوا على النبي\nصلوا على الحبيب",
          duration: 195,
        ),
      ],
    ),
    CategoryItem(
      title: "أهازيج شعبية",
      items: [
        CardItem(
          title: "يا مارق عالجسر",
          description: "أهزوجة شعبية تراثية أصيلة",
          imageUrl: "https://images.pexels.com/photos/4348093/pexels-photo-4348093.jpeg?auto=compress&cs=tinysrgb&w=600",
          type: ItemType.audio,
          audioUrl: "assets/audio/ya_mareq.mp3",
          lyrics: "يا مارق عالجسر\nشوف الحسن والقمر",
          duration: 210,
        ),
      ],
    ),
    CategoryItem(
      title: "أهازيج أفراح",
      items: [
        CardItem(
          title: "يا هلية",
          description: "أهزوجة زفاف تقليدية مبهجة",
          imageUrl: "https://images.pexels.com/photos/169198/pexels-photo-169198.jpeg?auto=compress&cs=tinysrgb&w=600",
          type: ItemType.audio,
          audioUrl: "assets/audio/ya_haliya.mp3",
          lyrics: "يا هلية بالعريس\nجينا نبارك ونقول",
          duration: 150,
        ),
      ],
    ),
  ];

  final Map<int, bool> expandedCategories = {};
  CardItem? _currentlyPlayingItem;
  bool _isPlaying = false;
  double _currentProgress = 0.0;
  int _currentSeconds = 0;
  int _totalDuration = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < categories.length; i++) {
      expandedCategories[i] = i == 0;
    }

    _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) setState(() => _totalDuration = duration.inSeconds);
    });

    _audioPlayer.onPositionChanged.listen((position) {
      if (mounted && _currentlyPlayingItem != null) {
        setState(() {
          _currentSeconds = position.inSeconds;
          if (_totalDuration > 0) _currentProgress = _currentSeconds / _totalDuration;
        });
      }
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _isPlaying = state == PlayerState.playing);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause(CardItem item) async {
    try {
      if (_currentlyPlayingItem == item) {
        _isPlaying ? await _audioPlayer.pause() : await _audioPlayer.resume();
      } else {
        await _audioPlayer.stop();
        setState(() {
          _currentlyPlayingItem = item;
          _currentProgress = 0.0;
          _currentSeconds = 0;
        });
        if (item.audioUrl != null) {
          String audioPath = item.audioUrl!.replaceFirst('assets/', '');
          await _audioPlayer.play(AssetSource(audioPath));
        }
      }
    } catch (e) {
      debugPrint('Audio Play Error: $e');
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isLandscape = orientation == Orientation.landscape;
          final Size size = MediaQuery.of(context).size;
          final double horizontalPadding = isLandscape ? size.width * 0.08 : size.width * 0.05;

          return Column(
            children: [
              SizedBox(
                height: isLandscape ? 60 : null,
                child: AppBarEventDetails(context, "الأهازيج", showLeftButton: false),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: isLandscape ? 8 : 15
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: outSearchBarHome(context: context, onChanged: (value) {}),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  itemCount: categories.length,
                  itemBuilder: (context, index) => buildCategorySection(index, isLandscape),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCategorySection(int index, bool isLandscape) {
    final category = categories[index];
    final isExpanded = expandedCategories[index] ?? false;

    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => expandedCategories[index] = !isExpanded),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.transparent,
            child: Row(
              children: [
                // منع التداخل في حال كان العنوان طويلاً
                Flexible(child: IntroSecondText(subtitle: category.title, color: dark, size: isLandscape ? 14 : 16)),
                const SizedBox(width: 10),
                Expanded(child: Container(height: 1, color: Colors.grey[200])),
                const SizedBox(width: 10),
                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),
        if (isExpanded)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: category.items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isLandscape ? 2 : 1,
              mainAxisExtent: isLandscape ? 75 : 85,
              crossAxisSpacing: 15,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, itemIndex) => buildHorizontalCard(category.items[itemIndex], isLandscape),
          ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildHorizontalCard(CardItem item, bool isLandscape) {
    return GestureDetector(
      onTap: () => item.type == ItemType.audio ? _showMiniAudioPlayer(context, item) : _showTextDialog(context, item),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: purple.withOpacity(0.3)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: isLandscape ? 20 : 25,
              backgroundColor: Colors.grey[200],
              backgroundImage: NetworkImage(item.imageUrl),
              onBackgroundImageError: (_, __) => const Icon(Icons.music_note),
            ),
            const SizedBox(width: 12),
            // استخدام Expanded لحل مشكلة الـ Overflow في الـ Row
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntroSecondText(subtitle: item.title, color: dark, size: 14),
                  IntroSecondText(subtitle: item.description, color: secondText, size: 11),
                ],
              ),
            ),
            Checkbox(
              value: item.isSelected,
              activeColor: purple,
              onChanged: (val) => setState(() => item.isSelected = val ?? false),
            ),
          ],
        ),
      ),
    );
  }

  void _showMiniAudioPlayer(BuildContext context, CardItem item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final isLand = MediaQuery.of(context).orientation == Orientation.landscape;
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          item.imageUrl,
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(width: 55, height: 55, color: Colors.grey[300], child: const Icon(Icons.music_note)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      // حل مشكلة النص الطويل في الـ BottomSheet
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntroSecondText(subtitle: item.title, color: dark, size: 16),
                            if (!isLand) IntroSecondText(subtitle: item.description, color: secondText, size: 13),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          (_currentlyPlayingItem == item && _isPlaying) ? Icons.pause_circle_filled : Icons.play_circle_filled,
                          color: purple, size: 45,
                        ),
                        onPressed: () {
                          _togglePlayPause(item);
                          setSheetState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: (_currentlyPlayingItem == item) ? _currentProgress : 0.0,
                    color: purple,
                    backgroundColor: Colors.grey[200],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showTextDialog(BuildContext context, CardItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(width: 40, height: 4, color: Colors.grey[300], margin: const EdgeInsets.only(bottom: 15)),
              IntroSecondText(subtitle: item.title, color: dark, size: 18),
              const Divider(),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [IntroSecondText(subtitle: item.lyrics ?? "", color: dark, size: 14)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// النماذج
enum ItemType { audio, text }

class CategoryItem {
  final String title;
  final List<CardItem> items;
  CategoryItem({required this.title, required this.items});
}

class CardItem {
  final String title;
  final String description;
  final String imageUrl;
  final ItemType type;
  final String? audioUrl;
  final String? lyrics;
  final int? duration;
  bool isSelected;

  CardItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.type,
    this.audioUrl,
    this.lyrics,
    this.duration,
    this.isSelected = false,
  });
}