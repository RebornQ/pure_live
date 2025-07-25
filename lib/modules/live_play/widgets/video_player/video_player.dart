import 'dart:io';
import 'package:floating/floating.dart';
import 'package:pure_live/common/index.dart';
import 'package:media_kit_video/media_kit_video.dart' as media_kit_video;
import 'package:pure_live/modules/live_play/widgets/video_player/video_controller.dart';
import 'package:pure_live/modules/live_play/widgets/video_player/video_controller_panel.dart';

class VideoPlayer extends StatefulWidget {
  final VideoController controller;
  const VideoPlayer({super.key, required this.controller});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  Widget _buildVideoPanel() {
    return VideoControllerPanel(controller: widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      if (widget.controller.settings.videoPlayerIndex.value == 0) {
        return PiPSwitcher(
          floating: widget.controller.pip,
          childWhenDisabled: media_kit_video.Video(
            key: widget.controller.key,
            pauseUponEnteringBackgroundMode: !widget.controller.settings.enableBackgroundPlay.value,
            resumeUponEnteringForegroundMode: !widget.controller.settings.enableBackgroundPlay.value,
            controller: widget.controller.mediaPlayerController,
            fit: widget.controller.settings.videofitArrary[widget.controller.videoFitIndex.value],
            controls: widget.controller.room.platform == Sites.iptvSite
                ? media_kit_video.MaterialVideoControls
                : (state) => _buildVideoPanel(),
          ),
          childWhenEnabled: media_kit_video.Video(
            key: widget.controller.key,
            pauseUponEnteringBackgroundMode: !widget.controller.settings.enableBackgroundPlay.value,
            resumeUponEnteringForegroundMode: !widget.controller.settings.enableBackgroundPlay.value,
            controller: widget.controller.mediaPlayerController,
            fit: widget.controller.settings.videofitArrary[widget.controller.videoFitIndex.value],
            controls: widget.controller.room.platform == Sites.iptvSite
                ? media_kit_video.MaterialVideoControls
                : (state) => _buildVideoPanel(),
          ),
        );
      } else {
        return BetterPlayer(key: widget.controller.playerKey, controller: widget.controller.mobileController!);
      }
    }
    return media_kit_video.Video(
      key: widget.controller.key,
      pauseUponEnteringBackgroundMode: !widget.controller.settings.enableBackgroundPlay.value,
      resumeUponEnteringForegroundMode: !widget.controller.settings.enableBackgroundPlay.value,
      controller: widget.controller.mediaPlayerController,
      fit: widget.controller.settings.videofitArrary[widget.controller.videoFitIndex.value],
      controls: widget.controller.room.platform == Sites.iptvSite
          ? media_kit_video.MaterialVideoControls
          : (state) => _buildVideoPanel(),
    );
  }
}
