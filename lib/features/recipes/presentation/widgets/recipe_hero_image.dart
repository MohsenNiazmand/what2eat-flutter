import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:what_2_eat/core/constants/colors.dart';

abstract final class RecipeHeroImage {
  static const fit = BoxFit.cover;
  static const alignment = Alignment.center;
  static const listSize = 60.0;
  static const listRadius = listSize / 2;
  static const listMemCacheSize = 120;
}

class RecipeListHeroThumbnail extends StatelessWidget {
  const RecipeListHeroThumbnail({
    required this.heroTag,
    required this.imageUrl,
    super.key,
  });

  final String heroTag;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: RecipeHeroImage.listSize,
      height: RecipeHeroImage.listSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: cBorder.withValues(alpha: 0.85),
        ),
        boxShadow: [
          BoxShadow(
            color: cPrimary.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Hero(
        tag: heroTag,
        flightShuttleBuilder: _recipeHeroFlightShuttleBuilder(imageUrl),
        child: _RecipeHeroShell(
          imageUrl: imageUrl,
          borderRadius: RecipeHeroImage.listRadius,
          width: RecipeHeroImage.listSize,
          height: RecipeHeroImage.listSize,
          memCacheSize: RecipeHeroImage.listMemCacheSize,
        ),
      ),
    );
  }
}

class RecipeDetailHeroImage extends StatelessWidget {
  const RecipeDetailHeroImage({
    required this.heroTag,
    required this.imageUrl,
    super.key,
  });

  final String heroTag;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: heroTag,
          child: _RecipeHeroShell(
            imageUrl: imageUrl,
            borderRadius: 0,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        const _RecipeHeroScrim(top: true),
        const _RecipeHeroScrim(top: false),
      ],
    );
  }
}

class _RecipeHeroScrim extends StatelessWidget {
  const _RecipeHeroScrim({required this.top});

  final bool top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: top ? 0 : null,
      bottom: top ? null : 0,
      height: top ? 120 : 140,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: top ? Alignment.topCenter : Alignment.bottomCenter,
            end: top ? Alignment.bottomCenter : Alignment.topCenter,
            colors: [
              Colors.black.withValues(alpha: top ? 0.52 : 0.55),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeHeroShell extends StatelessWidget {
  const _RecipeHeroShell({
    required this.imageUrl,
    required this.borderRadius,
    required this.width,
    required this.height,
    this.memCacheSize,
  });

  final String? imageUrl;
  final double borderRadius;
  final double width;
  final double height;
  final int? memCacheSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: SizedBox(
          width: width,
          height: height,
          child: _RecipeHeroImageCore(
            imageUrl: imageUrl,
            memCacheSize: memCacheSize,
          ),
        ),
      ),
    );
  }
}

class _RecipeHeroImageCore extends StatelessWidget {
  const _RecipeHeroImageCore({
    required this.imageUrl,
    this.memCacheSize,
    this.placeholderCompact = true,
  });

  final String? imageUrl;
  final int? memCacheSize;
  final bool placeholderCompact;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        cacheKey: imageUrl,
        fit: RecipeHeroImage.fit,
        alignment: RecipeHeroImage.alignment,
        memCacheWidth: memCacheSize,
        memCacheHeight: memCacheSize,
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        placeholder: (_, __) => RecipeImagePlaceholder(
          compact: placeholderCompact,
          animate: false,
        ),
        errorWidget: (_, __, ___) => RecipeImagePlaceholder(
          compact: placeholderCompact,
          animate: false,
        ),
      );
    }

    return RecipeImagePlaceholder(
      compact: placeholderCompact,
      animate: false,
    );
  }
}

Widget Function(
  BuildContext,
  Animation<double>,
  HeroFlightDirection,
  BuildContext,
  BuildContext,
) _recipeHeroFlightShuttleBuilder(String? imageUrl) {
  return (
    flightContext,
    animation,
    flightDirection,
    fromHeroContext,
    toHeroContext,
  ) {
    final radius = Tween<double>(
      begin: RecipeHeroImage.listRadius,
      end: 0,
    ).evaluate(animation);

    return Material(
      type: MaterialType.transparency,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: _RecipeHeroImageCore(
          imageUrl: imageUrl,
          placeholderCompact: true,
        ),
      ),
    );
  };
}

class RecipeImagePlaceholder extends StatefulWidget {
  const RecipeImagePlaceholder({
    this.compact = false,
    this.animate = true,
    super.key,
  });

  final bool compact;
  final bool animate;

  @override
  State<RecipeImagePlaceholder> createState() => _RecipeImagePlaceholderState();
}

class _RecipeImagePlaceholderState extends State<RecipeImagePlaceholder>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
      )..repeat();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = widget.compact ? 28.0 : 72.0;
    final icon = Icon(
      Icons.restaurant_menu_rounded,
      size: iconSize,
      color: widget.compact
          ? cPrimary.withValues(alpha: 0.82)
          : Colors.white54,
    );

    if (!widget.animate || _controller == null) {
      return ColoredBox(
        color: cSurfaceElevated,
        child: Center(child: icon),
      );
    }

    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1 + 2 * _controller!.value, -0.2),
              end: Alignment(0 + 2 * _controller!.value, 0.2),
              colors: [
                cSurfaceElevated,
                cPrimary.withValues(alpha: 0.18),
                cSurfaceElevated,
              ],
            ),
          ),
          child: child,
        );
      },
      child: Center(child: icon),
    );
  }
}
