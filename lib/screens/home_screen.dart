import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

import '../theme/colors.dart';
import '../ui/ui.dart';
import '../models/models.dart';
import '../data/data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return const MaterialPage(
      name: "/",
      key: ValueKey("/"),
      child: HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 56),
              _ScreenHeading(),
              SizedBox(height: 44),
              _ScreenSectionHeading(label: 'Categories'),
              SizedBox(height: 23),
              _CategoryList(),
              SizedBox(height: 49),
              _ScreenSectionHeading(label: 'Featured NFTs'),
              SizedBox(height: 24),
              _FeaturedPostsList(),
              SizedBox(height: 14),
              _ScreenSectionHeading(label: 'Top Sellers'),
              SizedBox(height: 21),
              _SellerList(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScreenHeading extends StatelessWidget {
  const _ScreenHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 33,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.main,
                ),
                child: SvgPicture.asset(
                  "assets/images/cryptocurrency.svg",
                  width: 9.29,
                  height: 15.75,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "8.42 ETH",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          Row(
            children: const [
              AppIconButton(
                imageSrc: "assets/images/search.svg",
                border: true,
              ),
              SizedBox(width: 15),
              AppIconButton(
                imageSrc: "assets/images/notification.svg",
                border: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScreenSectionHeading extends StatelessWidget {
  final String label;
  final void Function()? onTap;

  const _ScreenSectionHeading({
    Key? key,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          GestureDetector(
            child: Column(
              children: [
                Text(
                  'View all',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                //fixes baseline of text
                const SizedBox(height: 2),
              ],
            ),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 37),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        primary: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoryChip(label: categories[index]),
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemCount: categories.length,
      ),
    );
  }
}

class _FeaturedPostsList extends StatelessWidget {
  const _FeaturedPostsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 473,
        maxWidth: double.infinity,
      ),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: <Widget>[
            const SizedBox(width: 20),
            for (NFTView post in posts) ...[
              NFTViewCard(view: post),
              const SizedBox(width: 28)
            ]
          ],
        ),
      ),
    );
  }
}

class _SellerList extends StatelessWidget {
  const _SellerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = <Widget>[];

    for (SellerProfile profile in profiles) {
      widgetList.add(SellerProfileCard(
        price: profile.price,
        name: profile.name,
        icon: profile.icon,
      ));

      //if it's not the last element, place a divider
      if (profile.name != profiles[profiles.length - 1].name) {
        widgetList.add(const SizedBox(height: 12));
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: widgetList,
      ),
    );
  }
}
