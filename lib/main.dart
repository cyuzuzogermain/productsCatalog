import 'package:flutter/material.dart';

void main() {
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFF6366F1),
          foregroundColor: Colors.white,
        ),
      ),
      home: const ProductListPage(),
    );
  }
}

// Product Model
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final int rating;
  final String features;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.features,
  });
}

// Sample Product Data
class ProductData {
  static final List<Product> products = [
    Product(
      id: '1',
      name: 'Wireless Headphones',
      description: 'Premium wireless headphones with active noise cancellation and 30-hour battery life. Experience immersive sound quality with deep bass and crystal-clear highs.',
      price: 149.99,
      imageUrl: '🎧',
      category: 'Electronics',
      rating: 4,
      features: '• Noise Cancellation\n• 30hr Battery\n• Bluetooth 5.0\n• Comfort Fit',
    ),
    Product(
      id: '2',
      name: 'Smart Watch',
      description: 'Advanced smartwatch with health monitoring, GPS tracking, and seamless smartphone connectivity. Stay connected and track your fitness goals.',
      price: 299.99,
      imageUrl: '⌚',
      category: 'Wearables',
      rating: 5,
      features: '• Heart Rate Monitor\n• GPS Tracking\n• Water Resistant\n• 7 Day Battery',
    ),
    Product(
      id: '3',
      name: 'Laptop Stand',
      description: 'Ergonomic aluminum laptop stand with adjustable height and angle. Improve your posture and reduce neck strain during long work sessions.',
      price: 49.99,
      imageUrl: '💻',
      category: 'Accessories',
      rating: 4,
      features: '• Adjustable Height\n• Aluminum Build\n• Foldable Design\n• Anti-slip Base',
    ),
    Product(
      id: '4',
      name: 'Mechanical Keyboard',
      description: 'Premium mechanical keyboard with RGB backlighting and customizable keys. Enjoy tactile feedback and enhanced typing experience.',
      price: 89.99,
      imageUrl: '⌨️',
      category: 'Electronics',
      rating: 5,
      features: '• RGB Lighting\n• Mechanical Switches\n• USB-C Connection\n• Detachable Cable',
    ),
    Product(
      id: '5',
      name: 'Wireless Mouse',
      description: 'Slim wireless mouse with ergonomic design and silent clicks. Perfect for productivity and gaming with precise tracking.',
      price: 39.99,
      imageUrl: '🖱️',
      category: 'Accessories',
      rating: 4,
      features: '• Silent Clicks\n• Ergonomic Design\n• 16000 DPI\n• 12 Month Battery',
    ),
    Product(
      id: '6',
      name: 'USB-C Hub',
      description: 'Universal USB-C hub with multiple ports including HDMI, USB 3.0, and SD card reader. Expand your connectivity options.',
      price: 59.99,
      imageUrl: '🔌',
      category: 'Accessories',
      rating: 4,
      features: '• HDMI 4K Output\n• 3x USB 3.0\n• SD Card Reader\n• 100W Power Delivery',
    ),
  ];
}

// Product List Page
class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All', true, context),
                  const SizedBox(width: 8),
                  _buildFilterChip('Electronics', false, context),
                  const SizedBox(width: 8),
                  _buildFilterChip('Wearables', false, context),
                  const SizedBox(width: 8),
                  _buildFilterChip('Accessories', false, context),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Products Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: ProductData.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: ProductData.products[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            product: ProductData.products[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {},
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,              child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
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

// Product Details Page
class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Back Button
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // Share functionality
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.shopping_bag,
                    size: 64,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Info Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Price
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const Spacer(),
                              // Rating
                              Row(
                                children: List.generate(
                                  5,
                                  (index) {
                                    return Icon(
                                      index < product.rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 20,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Category
                          Chip(
                            avatar: const Icon(Icons.category, size: 18),
                            label: Text(product.category),
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceContainerHighest,
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          // Description
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          // Features
                          Text(
                            'Features',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.features,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  height: 1.6,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to cart!'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor:
                            Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100), // Space for scrolling
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
