import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda/config/gen/assets.gen.dart';
import 'package:orda/config/router/app_router.dart';
import 'package:orda/core/extensions/build_context_extension.dart';
import 'package:orda/core/extensions/number_extension.dart';
import 'package:orda/features/cart/domain/entities/cart_item.dart';
import 'package:orda/features/cart/presentation/bloc/cart_cubit.dart';
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
    final cartState = context.watch<CartCubit>().state;
    final itemScrollController = ItemScrollController();

    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ShopLoaded) {
          final shop = state.shop;
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                buildSliverAppBar(shop, context),

                buildGridView(),

                buildListView(shop, context),
              ],
            ),
            bottomNavigationBar: cartState.items.isNotEmpty
                ? SafeArea(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 2,
                            color: context.colors.outlineVariant,
                          ),
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () => context.push(
                          AppRouter.checkout,
                          extra: shop.id,
                        ),
                        child: Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Giỏ hàng • ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${cartState.itemCount} món',
                                  ),
                                ],
                                style: context.textTheme.titleMedium!
                                    .copyWith(
                                      color: context.colors.onPrimary,
                                    ),
                              ),
                            ),
                            Text(cartState.total.toVND()),
                          ],
                        ),
                      ),
                    ),
                  )
                : null,
          );
        }

        return const SizedBox();
      },
    );
  }

  SliverAppBar buildSliverAppBar(Shop shop, BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 150,
      title: Text(shop.name, overflow: TextOverflow.ellipsis),
      shadowColor: context.colors.outline.withValues(alpha: .7),
      leading: BackButton(onPressed: context.pop),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        background: Image.network(shop.imageUrl, fit: BoxFit.cover),
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
    );
  }

  SliverPadding buildListView(Shop shop, BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList.list(
        children: shop.categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  category.name.toUpperCase(),
                  style: context.textTheme.titleLarge,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
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
                              context.read<CartCubit>().addItem(
                                CartItem(
                                  menuItemId: item.id,
                                  name: item.name,
                                  price: item.price,
                                  imageUrl: item.imageUrl,
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: context.colors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Iconsax.add_copy,
                                color: context.colors.onPrimary,
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
    );
  }

  SliverPadding buildGridView() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.71,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Assets.images.blankItem.image(
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: context.colors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Iconsax.add_copy,
                            color: context.colors.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                const Text(
                  'Cà phê sữa đá rất rất ngon luôn nè',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const Text(
                  '30.000',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
          childCount: 8, // Number of grid items
        ),
      ),
    );
  }
}
