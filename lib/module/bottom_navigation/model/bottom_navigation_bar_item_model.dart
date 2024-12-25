import "dart:convert";
import "dart:ui";

class BottomNavigationItemModel {
  Color? selectedColor;
  String? icon;
  String? activeIcon;
  String? title;

  BottomNavigationItemModel({
    this.selectedColor,
    this.icon,
    this.activeIcon,
    this.title,
  });

  BottomNavigationItemModel copyWith({
    Color? selectedColor,
    String? icon,
    String? fillIcon,
    String? title,
  }) =>
      BottomNavigationItemModel(
        selectedColor: selectedColor ?? this.selectedColor,
        icon: icon ?? this.icon,
        activeIcon: activeIcon ?? this.icon,
        title: title ?? this.title,
      );

  factory BottomNavigationItemModel.fromJson(String str) => BottomNavigationItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BottomNavigationItemModel.fromMap(Map<String, dynamic> json) => BottomNavigationItemModel(
        selectedColor: json["selectedColor"],
        icon: json["icon"],
        activeIcon: json["activeIcon"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "selectedColor": selectedColor,
        "icon": icon,
        "activeIcon": activeIcon,
        "title": title,
      };
}
