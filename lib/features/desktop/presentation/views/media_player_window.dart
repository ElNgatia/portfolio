import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/skin.dart';
import 'package:portfolio/features/desktop/data/music_data.dart';
import 'package:portfolio/features/desktop/domain/entity/track.dart';

/// Windows Media Player-style app: now-playing header, seek bar,
/// transport controls and the playlist below.
class MediaPlayerWindow extends StatefulWidget {
  const MediaPlayerWindow({super.key});

  @override
  State<MediaPlayerWindow> createState() => _MediaPlayerWindowState();
}

class _MediaPlayerWindowState extends State<MediaPlayerWindow> {
  final AudioPlayer _player = AudioPlayer();

  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  double _volume = 1.0;
  String? _error;

  Track get _track => playlist[_currentIndex];

  @override
  void initState() {
    super.initState();
    _player.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _isPlaying = state == PlayerState.playing);
    });
    _player.onDurationChanged.listen((duration) {
      if (mounted) setState(() => _duration = duration);
    });
    _player.onPositionChanged.listen((position) {
      if (mounted) setState(() => _position = position);
    });
    _player.onPlayerComplete.listen((_) => _playNext());
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _play(int index) async {
    setState(() {
      _currentIndex = index;
      _position = Duration.zero;
      _duration = Duration.zero;
      _error = null;
    });
    try {
      await _player.play(AssetSource(_track.url.replaceFirst('assets/', '')));
    } catch (e) {
      print("Error playing track: $e ${_track.title}");
      if (mounted) {
        setState(() => _error = 'Could not load this track.');
      }
    }
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _player.pause();
    } else if (_position == Duration.zero && _duration == Duration.zero) {
      await _play(_currentIndex);
    } else {
      await _player.resume();
    }
  }

  Future<void> _playNext() =>
      _play((_currentIndex + 1) % playlist.length);

  Future<void> _playPrevious() =>
      _play((_currentIndex - 1 + playlist.length) % playlist.length);

  Future<void> _seek(Duration position) => _player.seek(position);

  Future<void> _setVolume(double volume) async {
    setState(() => _volume = volume);
    await _player.setVolume(volume);
  }

  String _format(Duration duration) {
    final minutes = duration.inMinutes.toString();
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);

    return Container(
      color: skin.pageBackground,
      child: Column(
        children: [
          // Now playing
          Container(
            width: double.infinity,
            color: skin.cardHeaderBackground,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        skin.accent.withValues(alpha: 0.85),
                        skin.headingColor.withValues(alpha: 0.55),
                      ],
                    ),
                  ),
                  child: const Icon(Icons.music_note,
                      size: 30, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _track.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: skin.headingWeight,
                          color: skin.headingColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _track.artist,
                        style:
                            TextStyle(fontSize: 12, color: skin.textMuted),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          _error!,
                          style: TextStyle(
                              fontSize: 11, color: skin.warningBadge.text),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Seek bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Row(
              children: [
                Text(
                  _format(_position),
                  style: TextStyle(fontSize: 11, color: skin.textMuted),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 3,
                      activeTrackColor: skin.accent,
                      inactiveTrackColor: skin.divider,
                      thumbColor: skin.accent,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 6),
                      overlayShape:
                          const RoundSliderOverlayShape(overlayRadius: 11),
                    ),
                    child: Slider(
                      key: const ValueKey('media_player_seek'),
                      value: _position <= _duration && _duration > Duration.zero
                          ? _position.inMilliseconds.toDouble()
                          : 0,
                      max: _duration > Duration.zero
                          ? _duration.inMilliseconds.toDouble()
                          : 1,
                      onChanged: _duration > Duration.zero
                          ? (value) => _seek(
                              Duration(milliseconds: value.round()))
                          : null,
                    ),
                  ),
                ),
                Text(
                  _format(_duration),
                  style: TextStyle(fontSize: 11, color: skin.textMuted),
                ),
              ],
            ),
          ),

          // Transport controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                tooltip: 'Previous',
                onPressed: _playPrevious,
                icon: Icon(Icons.skip_previous, color: skin.textSecondary),
              ),
              _PlayPauseButton(
                isPlaying: _isPlaying,
                accent: skin.accent,
                onPressed: _togglePlay,
              ),
              IconButton(
                tooltip: 'Next',
                onPressed: _playNext,
                icon: Icon(Icons.skip_next, color: skin.textSecondary),
              ),
              const SizedBox(width: 16),
              Icon(Icons.volume_down, size: 18, color: skin.iconMuted),
              SizedBox(
                width: 90,
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 2,
                    activeTrackColor: skin.accent,
                    inactiveTrackColor: skin.divider,
                    thumbColor: skin.accent,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 5),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 9),
                  ),
                  child: Slider(
                    value: _volume,
                    onChanged: _setVolume,
                  ),
                ),
              ),
            ],
          ),

          Container(height: 1, color: skin.divider),

          // Playlist
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Playlist',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: skin.textMuted,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                final track = playlist[index];
                final isCurrent = index == _currentIndex;
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    key: ValueKey('media_player_track_$index'),
                    onTap: () => _play(index),
                    hoverColor: skin.hoverBackground,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? skin.hoverBackground
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isCurrent && _isPlaying
                                ? Icons.graphic_eq
                                : Icons.music_note_outlined,
                            size: 15,
                            color: isCurrent ? skin.accent : skin.iconMuted,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              track.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: isCurrent
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isCurrent
                                    ? skin.accent
                                    : skin.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            track.artist,
                            style: TextStyle(
                              fontSize: 11,
                              color: skin.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({
    required this.isPlaying,
    required this.accent,
    required this.onPressed,
  });

  final bool isPlaying;
  final Color accent;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const ValueKey('media_player_play_pause'),
      onTap: onPressed,
      child: Container(
        width: 44,
        height: 44,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(shape: BoxShape.circle, color: accent),
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          size: 26,
          color: Colors.white,
        ),
      ),
    );
  }
}
