flutter clean \
  && rm ios/Podfile.lock pubspec.lock \
  && rm -rf ios/Pods ios/Runner.xcworkspace \
  && flutter build ios --build-name=1.0.0 --build-number=1 --release --dart-define=MY_APP_ENV=prod --no-codesign