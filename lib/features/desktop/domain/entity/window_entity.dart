import 'dart:ui';

class WindowEntity {
  final String id;
  final String title;
  final Offset position;
  final Size size;
  final bool isOpen;
  final bool isMinimized;
  final bool isFocused;

  const WindowEntity({
    required this.id,
    required this.title,
    required this.position,
    required this.size,
    this.isOpen = true,
    this.isMinimized = false,
    this.isFocused = false,
  });

  WindowEntity copyWith({
    Offset? position,
    Size? size,
    bool? isOpen,
    bool? isMinimized,
    bool? isFocused,
  }) => WindowEntity(
    id: id,
    title: title,
    position: position ?? this.position,
    size: size ?? this.size,
    isOpen: isOpen ?? this.isOpen,
    isMinimized: isMinimized ?? this.isMinimized,
    isFocused: isFocused ?? this.isFocused,
  );
}
