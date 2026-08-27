import 'package:portfolio/features/desktop/domain/entity/track.dart';

/// Playlist for the media player.
///
/// Tracks are bundled as local assets (assets/audio/) to avoid CORS errors
/// on web. Add your own MP3s to assets/audio/ and update this list.
const List<Track> playlist = [
  Track(
    title: 'Neon Skyline',
    artist: 'Video Game Music',
    url: 'assets/audio/track1.mp3',
  ),
  Track(
    title: 'Midnight Circuit',
    artist: 'Video Game Music',
    url: 'assets/audio/track2.mp3',
  ),
  Track(
    title: 'Paper Planes',
    artist: 'Video Game Music',
    url: 'assets/audio/track3.mp3',
  ),
  Track(
    title: 'Slow Orbit',
    artist: 'Video Game Music',
    url: 'assets/audio/track4.mp3',
  ),
  Track(
    title: 'Static Bloom',
    artist: 'Video Game Music',
    url: 'assets/audio/track5.mp3',
  ),
];
