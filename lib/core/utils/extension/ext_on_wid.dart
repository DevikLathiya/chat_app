import 'package:flutter/cupertino.dart';

extension WidgetExtension on Widget {
  Widget dismissKeyboard() {
    return GestureDetector(onTap: () => FocusManager.instance.primaryFocus?.unfocus(), child: this);
  }

  Widget addGesture(VoidCallback onTap) {
    dismissKeyboard();
    return GestureDetector(behavior: HitTestBehavior.opaque, onTap: () => onTap(), child: this);
  }

  Widget toCenter() => Center(child: this);

  Widget radiusAll(double radius) {
    dismissKeyboard();
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  }
}
