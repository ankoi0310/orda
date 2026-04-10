import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/config/gen/assets.gen.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:orda/features/shop/domain/entities/shop.dart';
import 'package:orda/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:orda/features/shop/presentation/widgets/category_dropdown.dart';
import 'package:orda/features/shop/presentation/widgets/menu_item_card.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ShopDetailPage extends StatefulWidget {
  const ShopDetailPage({super.key});

  @override
  State<ShopDetailPage> createState() => _ShopDetailPageState();
}

class _ShopDetailPageState extends State<ShopDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _shopInfoKey = GlobalKey();

  bool _showTitle = false;
  double _shopInfoHeight = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _shopInfoKey.currentContext;
      if (context != null) {
        final box = context.findRenderObject()! as RenderBox;
        _shopInfoHeight = box.size.height;
      }
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset >= _shopInfoHeight && !_showTitle) {
      setState(() => _showTitle = true);
    } else if (_scrollController.offset < _shopInfoHeight &&
        _showTitle) {
      setState(() => _showTitle = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemScrollController = ItemScrollController();

    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ShopLoaded) {
          final shop = state.shop;
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 150,
                  title: Text(
                    shop.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  shadowColor: context.colors.outline.withValues(
                    alpha: .7,
                  ),
                  leading: BackButton(onPressed: context.pop),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.zero,
                    background: Image.network(
                      shop.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  bottom: AppBar(
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          spacing: 16,
                          children: [
                            Expanded(
                              child: CategoryDropdown(
                                categories: shop.categories,
                              ),
                            ),
                            Container(
                              height: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Iconsax.search_normal_copy,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.71,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(16),
                                    child: Assets.images.blankItem
                                        .image(fit: BoxFit.cover),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                        4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: context.colors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Iconsax.add_copy,
                                        color:
                                            context.colors.onPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),

                            /// NAME (max 2 lines)
                            const Text(
                              'Cà phê sữa đá rất rất ngon luôn nè',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            /// PRICE (luôn nằm dưới cùng)
                            const Text(
                              '30.000',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                      childCount: 8, // Number of grid items
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList.list(
                    children: shop.categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              category.name.toUpperCase(),
                              style: context.textTheme.titleLarge,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics:
                                  const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = category.items[index];
                                return Stack(
                                  children: [
                                    MenuItemCard(item: item),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<CartBloc>()
                                              .add(
                                                AddToCart(item: item),
                                              );
                                        },
                                        child: Container(
                                          padding:
                                              const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: context
                                                .colors
                                                .primary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Iconsax.add_copy,
                                            color: context
                                                .colors
                                                .onPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              itemCount: category.items.length,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );

    // return Scaffold(
    //   body: CustomScrollView(
    //     controller: _scrollController,
    //     slivers: [
    //       _buildSliverAppBar(),
    //
    //       /// 🏪 Shop info
    //       SliverToBoxAdapter(
    //         child: Container(
    //           key: _shopInfoKey,
    //           child: BlocBuilder<ShopBloc, ShopState>(
    //             buildWhen: (previous, current) {
    //               return current is ShopLoaded;
    //             },
    //             builder: (context, state) {
    //               return _buildShopInfo(
    //                 shop: (state as ShopLoaded).shop,
    //               );
    //             },
    //           ),
    //         ),
    //       ),
    //
    //       /// 📌 Sticky dropdown
    //       const CategoryStickyDropdown(),
    //
    //       /// 🍜 Menu list
    //       SliverList(
    //         delegate: SliverChildBuilderDelegate((context, index) {
    //           return Column(
    //             children: [MenuItemCard(item: MenuItem.test())],
    //           );
    //         }, childCount: 20),
    //       ),
    //     ],
    //   ),
    // );

    // return Scaffold(
    //   appBar: AppBar(),
    //   body: SafeArea(
    //     child: Column(
    //       children: [
    //         MenuCategoryHorizontalList(
    //           controller: itemScrollController,
    //         ),
    //         MenuItemScrollableList(
    //           itemScrollController: itemScrollController,
    //           categories: fakeCategories,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  /// 🔥 SliverAppBar
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 120,
      elevation: 0,
      leading: BackButton(
        style: _showTitle
            ? null
            : ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  context.colors.onSurface.withValues(alpha: 0.5),
                ),
                foregroundColor: WidgetStatePropertyAll(
                  context.colors.surface,
                ),
              ),
      ),
      flexibleSpace: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopLoaded) {
            final shop = state.shop;
            return FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 56,
                vertical: 12,
              ),
              title: _showTitle
                  ? Text(
                      shop.name,
                      style: context.textTheme.titleLarge,
                    )
                  : null,
              background: shop.imageUrl.isEmpty
                  ? null
                  : Image.network(shop.imageUrl, fit: BoxFit.cover),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  /// 🏪 Shop info
  Widget _buildShopInfo({Shop? shop}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(shop?.name ?? 'Quán trà sữa ngon 123'),
          const SizedBox(height: 8),
          Text(
            shop?.description ??
                'Quán trà sữa cực ngon, bổ, rẻ dành cho sinh viên',
          ),
          const SizedBox(height: 4),
          Text(shop?.address ?? '123 Đường ABC, Quận 1'),
        ],
      ),
    );
  }
}
