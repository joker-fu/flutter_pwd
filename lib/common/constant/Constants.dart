import 'package:local_auth/auth_strings.dart';

class PrefsKeys{
  static const gesturePassword = "gesturePassword";
}

class Routers {
  static const String home = 'route_home';
}

const androidAuthStrings = const AndroidAuthMessages(
  cancelButton: '取消',
  goToSettingsButton: '去设置',
  fingerprintNotRecognized: '指纹识别失败',
  goToSettingsDescription: '请设置指纹',
  fingerprintHint: '指纹',
  fingerprintSuccess: '指纹识别成功',
  signInTitle: '指纹验证',
  fingerprintRequiredTitle: '请先录入指纹!',
);

const iOSAuthStrings = const IOSAuthMessages(
  lockOut: "生物认证是禁用的。请锁定和解锁屏幕“启用它。",
  goToSettingsButton: "进入系统设置",
  goToSettingsDescription: "生物认证不是建立在你的设备。请启用“触摸ID或面临ID在你的手机上。",
  cancelButton: "取消",
);
