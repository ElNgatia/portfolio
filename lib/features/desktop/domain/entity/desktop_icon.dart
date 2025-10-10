class DesktopIcon {
  final String id;
  final String title;
  final String icon;
  final AppType appType;
  const DesktopIcon({
    required this.id,
    required this.title,
    required this.icon,
    required this.appType,
  });
}

enum AppType {
  about,
  projects,
  experience,
  contact,
  resume,
}
