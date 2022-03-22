import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nft_market/screens/screens.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';
import '../models/models.dart';

class NFTViewCard extends StatelessWidget {
  final NFTView view;

  const NFTViewCard({
    Key? key,
    required this.view,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius containerRadius = BorderRadius.circular(40);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
            alignment: Alignment.centerLeft,
            constraints: BoxConstraints(
              maxWidth: 360,
              minWidth: 326,
              maxHeight: 415,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: containerRadius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Hero(
                    tag: view.pieceName,
                    child: ClipRRect(
                      borderRadius: containerRadius,
                      child: Image.asset(
                        view.imageSrc,
                        width: double.infinity,
                        height: 310,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'By ${view.authorName}',
                            style: const TextStyle(
                              color: Color(0xFF848484),
                              fontSize: 14,
                              height: 19 / 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 24),
                          const Text(
                            'Current Price',
                            style: TextStyle(
                              color: Color(0xFF848484),
                              fontSize: 14,
                              height: 19 / 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            view.pieceName,
                            style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              height: 25 / 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Text(
                            '${view.currentPrice} ETH',
                            style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              height: 25 / 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 42),
              ],
            ),
          ),
          onTap: () {
            Provider.of<AppStateManager>(context, listen: false)
                .changeSelectedPost(view);
          },
        ),
        _CardButtonsContainer(id: view.id),
      ],
    );
  }
}

class _CardButtonsContainer extends StatelessWidget {
  final String id;

  const _CardButtonsContainer({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius buttonRadius = BorderRadius.circular(18);

    return Container(
      constraints: const BoxConstraints(maxWidth: 227, maxHeight: 58),
      alignment: Alignment.center,
      //means transform container 26 logical pixels up
      transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, -26, 0, 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 159,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: buttonRadius,
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: buttonRadius,
              child: InkWell(
                borderRadius: buttonRadius,
                onTap: () {},
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  alignment: Alignment.center,
                  child: const Text(
                    "Place bid",
                    style: TextStyle(
                      fontSize: 16,
                      height: 22 / 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _LikeButton(id: id),
        ],
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  final String id;

  const _LikeButton({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius buttonRadius = BorderRadius.circular(18);

    return Consumer<AppStateManager>(
      builder: (context, manager, child) {
        final bool isLiked = manager.isLikedPostPresent(id);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 175),
          curve: Curves.easeOutSine,
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: isLiked ? AppColors.main : AppColors.black,
            borderRadius: buttonRadius,
          ),
          child: Material(
            borderRadius: buttonRadius,
            color: Colors.transparent,
            child: InkWell(
              borderRadius: buttonRadius,
              onTap: () {
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
                  isLiked
                      ? 'assets/images/heart.svg'
                      : 'assets/images/heart_filled.svg',
                  color: isLiked ? Colors.white : const Color(0xFF8D8D8D),
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
