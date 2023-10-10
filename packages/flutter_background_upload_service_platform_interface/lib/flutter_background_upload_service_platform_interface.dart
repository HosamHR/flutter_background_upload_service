import 'dart:async';

import 'package:flutter_background_upload_service_platform_interface/src/configs.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

export 'src/configs.dart';

abstract class Observable {
  void invoke(String method, [Map<String, dynamic>? args]);
  Stream<Map<String, dynamic>?> on(String method);
}

abstract class FlutterBackgroundUploadServicePlatform extends PlatformInterface
    implements Observable {
  FlutterBackgroundUploadServicePlatform() : super(token: _token);
  static final Object _token = Object();

  static FlutterBackgroundUploadServicePlatform? _instance;

  static FlutterBackgroundUploadServicePlatform get instance {
    if (_instance == null) {
      throw 'FlutterBackgroundService is currently supported for Android and iOS Platform only.';
    }

    return _instance!;
  }

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [FlutterBackgroundUploadServicePlatform] when they register themselves.
  static set instance(FlutterBackgroundUploadServicePlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<bool> configure({
    required IosConfiguration iosConfiguration,
    required AndroidConfiguration androidConfiguration,
  });

  Future<bool> start();

  Future<bool> isServiceRunning();
}

abstract class ServiceInstance implements Observable {
  /// Stop the service
  Future<void> stopSelf();
}
