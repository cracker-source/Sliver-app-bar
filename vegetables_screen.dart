import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/colors.dart';
import '../../../bloc/products/vegetables/user_veetables/user_vegetables_bloc.dart';

class VegetablesScreen extends StatefulWidget {
  final Map<String, String> vegetableData;

  const VegetablesScreen({
    super.key,
    required this.vegetableData,
  });

  @override
  State<VegetablesScreen> createState() => _VegetablesScreenState();
}

class _VegetablesScreenState extends State<VegetablesScreen> {
  // final GlobalKey _sliverKey = GlobalKey(debugLabel: "SliverListKey");

  @override
  void initState() {
    super.initState();
    context.read<UserVegetablesBloc>().add(UserVegetablesLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/products/vegetables/select-vegetables'),
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        // center: _sliverKey,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            // floating: true,
            delegate: CustomSliverDelegate(
              expandedHeight: MediaQuery.of(context).size.height / 4.5,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          BlocBuilder<UserVegetablesBloc, UserVegetablesState>(
            builder: (context, state) {
              if (state is UserVegetablesLoadedState) {
                final userVegetables = state.userVegetables;
                return SliverList(
                  // key: _sliverKey,
                  delegate: SliverChildBuilderDelegate(childCount: 100,
                      (context, index) {
                    return Text("$index");
                    //  ListTile(
                    //   leading: Image.network(
                    //     userVegetables[index]["vegetableId"]
                    //         ["vegetableImage"],
                    //     height: 45,
                    //     width: 45,
                    //   ),
                    //   titleTextStyle: const TextStyle(
                    //     fontSize: 18,
                    //     color: Colors.black,
                    //   ),
                    //   title: Text(
                    //     userVegetables[index]["vegetableId"]["vegetableName"],
                    //   ),
                    //   subtitle: Text(
                    //     userVegetables[index]["status"],
                    //     style: TextStyle(
                    //       color: Colors.grey.shade600,
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    //   trailing: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       Text(
                    //           "\u{20B9} ${userVegetables[index]["price"]["\$numberDecimal"]} / ${userVegetables[index]["units"]}",
                    //           style: const TextStyle(
                    //               // fontSize: 14,
                    //               // color: ,
                    //               )),
                    //       Text("Updated on 2days"),
                    //     ],
                    //   ),
                    // );
                  }),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;

  CustomSliverDelegate({
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight + expandedHeight / 1,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight
                ? kToolbarHeight + 40
                : appBarSize + 40,
            child: AppBar(
              backgroundColor:
                  cardTopPosition <= 0 ? Colors.white : AppColors.primaryColor,
              elevation: 0.0,
              title: Opacity(
                opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                child: const Text(
                  "Vegetables",
                ),
              ),
            ),
          ),
          cardTopPosition <= 0
              ? const SizedBox.shrink()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Positioned(
                      left: 0.0,
                      right: 0.0,
                      top: cardTopPosition > 0 ? cardTopPosition : 0,
                      bottom: 0.0,
                      child: Opacity(
                        opacity: percent,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8 * percent),
                          child: Card(
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Vegetables",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  SizedBox(height: 10),
                                  Text("Click on '+' to add more vegetables"),
                                  SizedBox(height: 10),
                                  Wrap(
                                    spacing: 6,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          color: Colors.green,
                                          child: Text(
                                            "In Stock - 8",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          color: Color(0xFFf6631e),
                                          child: Text(
                                            "Few Left - 8",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          color: Color(0xFFe01e37),
                                          child: Text(
                                            "Out of Stock - 0",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration =>
      FloatingHeaderSnapConfiguration(
        curve: Curves.linear,
        duration: const Duration(milliseconds: 100),
      );
}
