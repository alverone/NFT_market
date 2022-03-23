import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/physics.dart';
import 'dart:ui';

import '../ui/ui.dart';
import '../models/models.dart';
import '../theme/colors.dart';

class PostDetailScreen extends StatefulWidget {
  final NFTView? cardInfo;

  const PostDetailScreen({
    Key? key,
    required this.cardInfo,
  }) : super(key: key);

  static MaterialPage page(NFTView? cardInfo) {
    return MaterialPage(
      name: "/details",
      key: const ValueKey("/details"),
      child: PostDetailScreen(
        cardInfo: cardInfo,
      ),
    );
  }

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 470),
      reverseDuration: const Duration(milliseconds: 435),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _AnimationBody(
            cardInfo: widget.cardInfo!,
            animationController: _controller,
          ),
        ),
      ),
    );
  }
}

class _AnimationBody extends StatefulWidget {
  final AnimationController animationController;
  final NFTView cardInfo;

  const _AnimationBody({
    Key? key,
    required this.animationController,
    required this.cardInfo,
  }) : super(key: key);

  @override
  State<_AnimationBody> createState() => _AnimationBodyState();
}

class _AnimationBodyState extends State<_AnimationBody>
    with SingleTickerProviderStateMixin {
  //animations
  late final Animation<double> fadeIn;
  late final Animation<double> fadeOut;
  late Animation<double> imageHeight;
  late final Animation<EdgeInsets> imagePadding;
  late final Animation<BorderRadius?> borderRadius;
  late final Animation<double> iconTopOffset;
  late final Animation<double> textOffset;
  late final Animation<double> headingSize;
  late final Animation<double> subheadingSize;
  late final Animation<double> headingHeight;

  late AnimationController _dragController;
  late Animation<Alignment> _dragAnimation;

  //initial alignment of draggable card
  Alignment _dragAlignment = Alignment.bottomCenter;
  //end alignment of draggable card
  Alignment _gravitationalSide = Alignment.bottomCenter;
  //used to calculate if drag threshold has been passed
  double initialPosition = 0;
  double previousPosition = 0;

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _dragAnimation = _dragController.drive(
      AlignmentTween(begin: _dragAlignment, end: _gravitationalSide),
    );

    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 25,
      stiffness: 3,
      damping: 1.2,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _dragController.animateWith(simulation);

    previousPosition = 0;
    initialPosition = 0;
  }

  @override
  void initState() {
    super.initState();

    _dragController = AnimationController(vsync: this);
    _dragController.addListener(() {
      setState(() => _dragAlignment = _dragAnimation.value);
    });

    final CurvedAnimation animation = CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeInOut,
    );

    imagePadding = EdgeInsetsTween(
      begin: const EdgeInsets.fromLTRB(28, 0, 28, 50),
      end: const EdgeInsets.all(0),
    ).animate(animation);

    //tweens are defined in lib/models/animation_tweens.dart
    borderRadius = borderRadiusTween.animate(animation);
    iconTopOffset = iconTopOffsetTween.animate(animation);
    textOffset = textOffsetTween.animate(animation);
    headingSize = headingSizeTween.animate(animation);
    subheadingSize = subheadingSizeTween.animate(animation);
    headingHeight = headingHeightTween.animate(animation);
    fadeIn = fadeInTween.animate(animation);
    fadeOut = fadeOutTween.animate(animation);
  }

  //function that is responsible for drag position update
  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragAlignment += Alignment(
        details.delta.dx / (MediaQuery.of(context).size.width / 2),
        details.delta.dy / (MediaQuery.of(context).size.height / 2),
      );

      if (initialPosition != 0) {
        initialPosition = details.localPosition.dy;
      }

      previousPosition = details.localPosition.dy;
    });
  }

  //function that is responsible for drag end
  void _onPanEnd(DragEndDetails details) {
    if (previousPosition <= 360) {
      //if threshold has been passed in forward direction (up)
      _gravitationalSide = Alignment.topCenter;
      widget.animationController.forward().orCancel;
    } else if ((previousPosition > 300)) {
      //if threshold has been passed in reverse direction (down)
      _gravitationalSide = Alignment.bottomCenter;
      widget.animationController.reverse().orCancel;
    }

    _runAnimation(
      details.velocity.pixelsPerSecond,
      MediaQuery.of(context).size,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    final size = MediaQuery.of(context).size;
    imageHeight = Tween<double>(
      begin: size.height * (358 / 896),
      end: size.height * (275 / 896),
    ).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeInOut,
    ));

    return _ScreenBody(
      imageSrc: widget.cardInfo.imageSrc,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              //adjusts top margin of main image of card
              //according to current value of dragAlignment
              if ((_dragAlignment.y > 0))
                AnimatedContainer(
                  height: (130 / 896) * size.height * _dragAlignment.y,
                  duration: const Duration(milliseconds: 40),
                  curve: Curves.ease,
                ),
              Container(
                padding: imagePadding.value,
                child: Hero(
                  tag: widget.cardInfo.pieceName,
                  child: ClipRRect(
                    borderRadius: borderRadius.value,
                    child: Image.asset(
                      widget.cardInfo.imageSrc,
                      width: double.infinity,
                      height: imageHeight.value,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: _DraggableCardBody(
              onPanEnd: _onPanEnd,
              onPanUpdate: _onPanUpdate,
              dragAlignment: _dragAlignment,
              dragController: _dragController,
              animationController: widget.animationController,
              id: widget.cardInfo.id,
              opacity: fadeOut.value,
              child: _DraggableCardContent(
                cardInfo: widget.cardInfo,
                iconTopOffset: iconTopOffset.value,
                textOffset: textOffset.value,
                fadeInOpacity: fadeIn.value,
                fadeOutOpacity: fadeOut.value,
                headingHeight: headingHeight.value,
                headingSize: headingSize.value,
                subheadingSize: subheadingSize.value,
              ),
            ),
          ),
          //fixed at top of the screen widget
          Positioned(
            top: 0,
            width: size.width,
            child: _TopButtons(
              opacity: fadeIn.value,
              postId: widget.cardInfo.id,
            ),
          ),
          //fixed at bottom of the screen widget
          Positioned(
            width: size.width,
            height: 103,
            bottom: 0,
            child: const _BottomButtons(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: widget.animationController,
    );
  }
}

class _ScreenBody extends StatelessWidget {
  final String imageSrc;
  final Widget child;

  const _ScreenBody({
    Key? key,
    required this.child,
    required this.imageSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ClipRRect(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            right: 0,
            height: size.height * (538 / size.height),
            width: size.width,
            child: Image(
              image: AssetImage(imageSrc),
              fit: BoxFit.cover,
              height: size.height * (538 / size.height),
            ),
          ),
          Positioned(
            top: 0,
            height: size.height,
            width: size.width,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _DraggableCardBody extends StatelessWidget {
  double opacity;
  Alignment dragAlignment;
  final String id;
  final Widget child;
  final AnimationController dragController;
  final AnimationController animationController;
  final void Function(DragEndDetails) onPanEnd;
  final void Function(DragUpdateDetails) onPanUpdate;

  _DraggableCardBody({
    Key? key,
    required this.dragController,
    required this.animationController,
    required this.onPanEnd,
    required this.onPanUpdate,
    required this.child,
    required this.id,
    required this.dragAlignment,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height + (70 / 896 * size.height),
      width: size.width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            //translate container 390 pixels down
            transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0,
                290 / 896 * size.height, 0, 1),
            child: GestureDetector(
              onPanDown: (details) => dragController.stop(),
              onPanUpdate: onPanUpdate,
              onPanEnd: onPanEnd,
              child: Container(
                alignment: dragAlignment,
                child: Container(
                  height: 670 / 896 * size.height,
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 36),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 54,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.black.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(56),
                        ),
                      ),
                      const SizedBox(height: 30),
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: (-216 / 896 * size.height),
            child: Container(
              width: size.width,
              height: size.height,
              alignment: Alignment.bottomRight,
              child: _DraggableCardButtons(
                id: id,
                dragAlignment: dragAlignment,
                opacity: opacity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//content of draggable card, accepts animation values
class _DraggableCardContent extends StatelessWidget {
  final NFTView cardInfo;
  double iconTopOffset;
  double textOffset;
  double fadeInOpacity;
  double fadeOutOpacity;
  double headingSize;
  double headingHeight;
  double subheadingSize;

  _DraggableCardContent({
    Key? key,
    required this.cardInfo,
    required this.iconTopOffset,
    required this.textOffset,
    required this.fadeInOpacity,
    required this.fadeOutOpacity,
    required this.headingSize,
    required this.headingHeight,
    required this.subheadingSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxHeight: 90),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                height: 90,
                top: iconTopOffset,
                child: ClipOval(
                  child: Image(
                    image: AssetImage(cardInfo.authorIcon),
                    fit: BoxFit.cover,
                    width: 86,
                    height: 86,
                  ),
                ),
              ),
              Positioned(
                left: textOffset,
                width: MediaQuery.of(context).size.width - 58,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Opacity(
                      opacity: fadeInOpacity,
                      child: Text(
                        'By ${cardInfo.authorName}',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 22 / 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8D8D8D),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Flex(
                      direction: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cardInfo.pieceName,
                          style: TextStyle(
                            fontSize: headingSize,
                            height: headingHeight / headingSize,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Opacity(
                          opacity: fadeOutOpacity,
                          child: const Text(
                            'Highest Bid',
                            style: TextStyle(
                              fontSize: 16,
                              height: 22 / 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF767676),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              'On Sale for ',
                              style: TextStyle(
                                fontSize: subheadingSize,
                                height: 25 / subheadingSize,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF8D8D8D),
                              ),
                            ),
                            Text(
                              '${cardInfo.currentPrice.toString()} ETH',
                              style: TextStyle(
                                fontSize: subheadingSize,
                                height: 25 / subheadingSize,
                                fontWeight: FontWeight.w700,
                                color: AppColors.main,
                              ),
                            ),
                          ],
                        ),
                        Opacity(
                          opacity: fadeOutOpacity,
                          child: Text(
                            '${cardInfo.highestBid.toString()} ETH',
                            style: const TextStyle(
                              fontSize: 16,
                              height: 22 / 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Row(
          children: const [
            SizedBox(
              width: 180,
              child: Text(
                'Creator',
                style: TextStyle(
                  fontSize: 16,
                  height: 22 / 16,
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              'Collection',
              style: TextStyle(
                fontSize: 16,
                height: 22 / 16,
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Flex(
          direction: Axis.horizontal,
          children: [
            SizedBox(
              width: 180,
              child: Text(
                cardInfo.token,
                style: const TextStyle(
                  fontSize: 18,
                  height: 25 / 18,
                  color: Color(0xFF767676),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              child: Text(
                '@${cardInfo.authorName}',
                style: const TextStyle(
                  fontSize: 18,
                  height: 25 / 18,
                  color: Color(0xFF767676),
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 39),
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            height: 25 / 18,
            color: AppColors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(cardInfo.description),
      ],
    );
  }
}

class _DraggableCardButtons extends StatelessWidget {
  final String id;
  double opacity;
  Alignment dragAlignment;

  _DraggableCardButtons({
    Key? key,
    required this.opacity,
    required this.id,
    required this.dragAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 45),
      curve: Curves.ease,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment(0.9, dragAlignment.y),
      child: Opacity(
        opacity: opacity,
        child: Container(
          alignment: Alignment.topRight,
          height: 48,
          width: 118,
          child: Row(
            children: [
              _LikeButton(
                id: id,
                isInactive: opacity == 0,
                dark: true,
              ),
              const SizedBox(width: 16),
              AppIconButton(
                imageSrc: 'assets/images/message.svg',
                backgroundColor: AppColors.black,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopButtons extends StatelessWidget {
  final String postId;
  final double opacity;

  const _TopButtons({
    Key? key,
    required this.postId,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppIconButton(
              imageSrc: 'assets/images/logout.svg',
              onTap: () => Navigator.pop(context),
              backgroundColor: Colors.white,
            ),
            Opacity(
              opacity: opacity,
              child: Row(
                children: [
                  _LikeButton(
                    id: postId,
                    isInactive: opacity == 0,
                  ),
                  const SizedBox(width: 15),
                  AppIconButton(
                    imageSrc: 'assets/images/more.svg',
                    onTap: () {},
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomButtons extends StatelessWidget {
  const _BottomButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      width: MediaQuery.of(context).size.width,
      height: 103,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0),
            Colors.white,
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Row(
          children: [
            Material(
              color: AppColors.main,
              borderRadius: BorderRadius.circular(18),
              child: InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  height: 67,
                  width: (MediaQuery.of(context).size.width - 60) / 2,
                  child: const Text(
                    'Make Offer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 25 / 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                highlightColor: Colors.white10,
                splashColor: Colors.white10,
              ),
            ),
            const SizedBox(width: 20),
            Material(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(18),
              child: InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  height: 67,
                  width: (MediaQuery.of(context).size.width - 60) / 2,
                  child: const Text(
                    'Place Bid',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 25 / 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  final String id;
  bool isInactive;
  bool dark;

  _LikeButton({
    Key? key,
    required this.id,
    required this.isInactive,
    this.dark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius buttonRadius = BorderRadius.circular(12);

    return Consumer<AppStateManager>(
      builder: (context, manager, child) {
        final bool isLiked = manager.isLikedPostPresent(id);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 145),
          curve: Curves.easeOutSine,
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isLiked
                ? dark
                    ? AppColors.black
                    : AppColors.main
                : Colors.white,
            borderRadius: buttonRadius,
            border: Border.all(
              color: dark
                  ? isLiked
                      ? Colors.white.withOpacity(0)
                      : AppColors.black.withOpacity(0.75)
                  : Colors.white.withOpacity(0.0),
              width: dark
                  ? isLiked
                      ? 0
                      : 1.5
                  : isLiked
                      ? 0
                      : 0,
            ),
          ),
          child: Material(
            borderRadius: buttonRadius,
            color: Colors.transparent,
            child: InkWell(
              borderRadius: buttonRadius,
              onTap: () {
                if (isInactive) {
                  return;
                }

                if (isLiked) {
                  manager.removeLikedPost(id);
                } else {
                  manager.addLikedPost(id);
                }
              },
              child: Container(
                constraints: const BoxConstraints.expand(),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  dark
                      ? 'assets/images/heart_filled.svg'
                      : 'assets/images/heart.svg',
                  color: isLiked ? Colors.white : AppColors.black,
                  width: 22,
                  height: 22,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
