import 'package:portfolio/features/desktop/domain/entity/track.dart';

/// Playlist for the media player.
///
/// Demo streams (SoundHelix, free for testing). Swap these URLs for your
/// own hosted tracks or move files into assets/audio/ and reference them
/// as asset paths.
const List<Track> playlist = [
  Track(
    title: 'Neon Skyline',
    artist: 'SoundHelix',
    url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
  ),
  Track(
    title: 'Midnight Circuit',
    artist: 'SoundHelix',
    url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
  ),
  Track(
    title: 'Paper Planes',
    artist: 'SoundHelix',
    url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
  ),
  Track(
    title: 'Slow Orbit',
    artist: 'SoundHelix',
    url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
  ),
  Track(
    title: 'Static Bloom',
    artist: 'SoundHelix',
    url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
  ),
];
