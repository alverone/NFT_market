import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';
import '../models/models.dart';

class SellerProfileCard extends StatelessWidget {
  final double price;
  final String name;
  final String icon;

  const SellerProfileCard({
    Key? key,
    required this.price,
    required this.name,
    required this.icon,
  }) : super(key: key);

  String _beautifyPrice(double price) {
    String stringPrice = price.toInt().toString();
    stringPrice = stringPrice.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
    stringPrice = '\$' + stringPrice;

    return stringPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 28, 10),
      decoration: BoxDecoration(
        color: AppColors.sellerProfileGrey,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  icon,
                  width: 54,
                  height: 54,
                ),
              ),
              const SizedBox(width: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 22 / 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _beautifyPrice(price),
                    style: TextStyle(
                      fontSize: 16,
                      height: 22 / 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ],
          ),
          _FollowButton(name: name),
        ],
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  final String name;

  const _FollowButton({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, manager, child) {
        final bool isProfileFollowed = manager.isFollowedProfilePresent(name);

        return Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 175),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                'Follow',
                style: TextStyle(
                  fontSize: 16,
                  height: 22 / 16,
                  color: isProfileFollowed ? AppColors.main : AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            onTap: () {
              if (isProfileFollowed) {
                manager.removeFollowedProfile(name);
              } else {
                manager.addFollowedProfile(name);
              }
            },
          ),
        );
      },
    );
  }
}
