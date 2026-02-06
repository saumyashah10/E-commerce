import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../widgets/food_card.dart';
import '../models/food_model.dart';
import '../providers/cart_provider.dart';
import 'food_detail_screen.dart';
import 'cart_screen.dart';
import '../models/category_model.dart';
import 'category_products_screen.dart'; // ✅ NEW IMPORT

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFoods();
    _loadCategories();
  }

  // ---------------- CATEGORIES ----------------
  List<CategoryModel> _categories = [];
  bool _isCategoryLoading = true;

  Future<void> _loadCategories() async {
    try {
      final data = await ApiService.fetchCategories();
      setState(() {
        _categories = data;
        _isCategoryLoading = false;
      });
    } catch (e) {
      setState(() {
        _isCategoryLoading = false;
      });
    }
  }

  // ---------------- PRODUCTS ----------------
  List<FoodModel> _allFoods = [];
  List<FoodModel> _filteredFoods = [];
  bool _isLoading = true;
  bool _hasError = false;

  Future<void> _loadFoods() async {
    try {
      final products = await ApiService.fetchProducts();
      setState(() {
        _allFoods = products;
        _filteredFoods = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  // ---------------- SEARCH ----------------
  void _search(String query) {
    setState(() {
      _filteredFoods = _allFoods
          .where(
            (food) => food.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryCarousel(), // ✅ UPDATED
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  // ---------------- BODY ----------------
  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return const Center(child: Text("Something went wrong"));
    }

    return _buildFoodGrid();
  }

  // ---------------- APP BAR ----------------
  AppBar _buildAppBar(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return AppBar(
      backgroundColor: const Color(0xFF1C2E4A),
      foregroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        "ShopEasy",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
            ),
            if (cart.totalItems > 0)
              Positioned(
                right: 6,
                top: 6,
                child: CircleAvatar(
                  radius: 9,
                  backgroundColor: Colors.red,
                  child: Text(
                    cart.totalItems.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // ---------------- SEARCH BAR ----------------
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: _search,
          decoration: const InputDecoration(
            hintText: "Search products",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  // ---------------- CATEGORY CAROUSEL (UPDATED) ----------------
  Widget _buildCategoryCarousel() {
    if (_isCategoryLoading) {
      return const SizedBox(
        height: 60,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        physics: const BouncingScrollPhysics(),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryProductsScreen(
                    categoryId: category.id,
                    categoryName: category.name,
                  ),
                ),
              );
            },
            child: Container(
              width: 90,
              // margin: const EdgeInsets.only(right: ),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.network(
                        category.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- PRODUCT GRID ----------------
  Widget _buildFoodGrid() {
    if (_filteredFoods.isEmpty) {
      return const Center(child: Text("No products found"));
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.64,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _filteredFoods.length,
      itemBuilder: (context, index) {
        final food = _filteredFoods[index];

        return FoodCard(
          food: food,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FoodDetailScreen(
                  food: food,
                  suggestions: _allFoods.where((f) => f.id != food.id).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
