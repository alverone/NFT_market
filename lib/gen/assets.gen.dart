/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsJpgGen {
  const $AssetsJpgGen();

  /// File path: assets/jpg/theshiboshis.jpeg
  AssetGenImage get theshiboshis =>
      const AssetGenImage('assets/jpg/theshiboshis.jpeg');
}

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/candyhunter.png
  AssetGenImage get candyhunter =>
      const AssetGenImage('assets/png/candyhunter.png');

  /// File path: assets/png/cryptocorgi.png
  AssetGenImage get cryptocorgi =>
      const AssetGenImage('assets/png/cryptocorgi.png');

  /// File path: assets/png/cryptocorgis.png
  AssetGenImage get cryptocorgis =>
      const AssetGenImage('assets/png/cryptocorgis.png');

  /// File path: assets/png/mekaverse.png
  AssetGenImage get mekaverse =>
      const AssetGenImage('assets/png/mekaverse.png');

  /// File path: assets/png/monsters.png
  AssetGenImage get monsters => const AssetGenImage('assets/png/monsters.png');

  /// File path: assets/png/onboarding_background.png
  AssetGenImage get onboardingBackground =>
      const AssetGenImage('assets/png/onboarding_background.png');

  /// File path: assets/png/sample.png
  AssetGenImage get sample => const AssetGenImage('assets/png/sample.png');

  /// File path: assets/png/satoshiverse.png
  AssetGenImage get satoshiverse =>
      const AssetGenImage('assets/png/satoshiverse.png');

  /// File path: assets/png/shiba.png
  AssetGenImage get shiba => const AssetGenImage('assets/png/shiba.png');

  /// File path: assets/png/watcher.png
  AssetGenImage get watcher => const AssetGenImage('assets/png/watcher.png');
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/cryptocurrency.svg
  SvgGenImage get cryptocurrency =>
      const SvgGenImage('assets/svg/cryptocurrency.svg');

  /// File path: assets/svg/heart.svg
  SvgGenImage get heart => const SvgGenImage('assets/svg/heart.svg');

  /// File path: assets/svg/heart_filled.svg
  SvgGenImage get heartFilled =>
      const SvgGenImage('assets/svg/heart_filled.svg');

  /// File path: assets/svg/logout.svg
  SvgGenImage get logout => const SvgGenImage('assets/svg/logout.svg');

  /// File path: assets/svg/message.svg
  SvgGenImage get message => const SvgGenImage('assets/svg/message.svg');

  /// File path: assets/svg/more.svg
  SvgGenImage get more => const SvgGenImage('assets/svg/more.svg');

  /// File path: assets/svg/notification.svg
  SvgGenImage get notification =>
      const SvgGenImage('assets/svg/notification.svg');

  /// File path: assets/svg/search-normal.svg
  SvgGenImage get searchNormal =>
      const SvgGenImage('assets/svg/search-normal.svg');

  /// File path: assets/svg/search.svg
  SvgGenImage get search => const SvgGenImage('assets/svg/search.svg');
}

class Assets {
  Assets._();

  static const $AssetsJpgGen jpg = $AssetsJpgGen();
  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
