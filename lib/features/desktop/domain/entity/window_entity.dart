import 'package:flutter/material.dart';

class WindowEntity {
  final String id;
  final String title;
  final Offset position;
  final Size size;
  final bool isOpen;
  final bool isMinimized;
  final bool isFocused;
  final bool isMaximized;
  final Size? preMaximizeSize;
  final Offset? preMaximizePosition;
  final Icon icon;

  const WindowEntity({
    required this.id,
    required this.title,
    required this.position,
    required this.size,
    this.isOpen = true,
    this.isMinimized = false,
    this.isFocused = false,
    this.isMaximized = false,
    this.preMaximizeSize,
    this.preMaximizePosition,
    required this.icon,
  });

  WindowEntity copyWith({
    Offset? position,
    Size? size,
    bool? isOpen,
    bool? isMinimized,
    bool? isFocused,
    bool? isMaximized,
    Size? preMaximizeSize,
    Offset? preMaximizePosition,
    bool clearPreMaximize = false,
  }) => WindowEntity(
    id: id,
    title: title,
    position: position ?? this.position,
    size: size ?? this.size,
    isOpen: isOpen ?? this.isOpen,
    isMinimized: isMinimized ?? this.isMinimized,
    isFocused: isFocused ?? this.isFocused,
    isMaximized: isMaximized ?? this.isMaximized,
    preMaximizeSize:
        clearPreMaximize ? null : (preMaximizeSize ?? this.preMaximizeSize),
    preMaximizePosition: clearPreMaximize
        ? null
        : (preMaximizePosition ?? this.preMaximizePosition),
    icon: icon,
  );
}
