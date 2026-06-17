import 'package:flutter/material.dart';

import '../../core/constants/delivery_zones.dart';
import '../../domain/entities/delivery.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/user.dart';
import 'ui_models.dart';

abstract class FakeData {

  static final User currentUser = User(
    id: 'u-001',
    fullName: 'Aminata Ngo',
    phone: '+237 6 78 12 34 56',
    avatarUrl: 'https://i.pravatar.cc/150?img=47',
    role: UserRole.buyer,
    isCourier: false,
    isPhoneVerified: true,
    walletBalance: 25000,
    createdAt: DateTime(2025, 11, 10),
  );

  static final List<Product> products = [
    Product(
      id: 'p-001',
      sellerId: 'u-002',
      sellerName: 'Fatou B.',
      sellerAvatarUrl: 'https://i.pravatar.cc/150?img=48',
      title: 'Regular Fit Slogan',
      description:
          "The name says it all, the right size slightly snugs the body leaving "
          "enough room for comfort in the sleeves and waist. Premium cotton blend "
          "fabric keeps you cool on warmer days. Machine-washable, holds its shape "
          "even after multiple washes. Perfect as an everyday staple.",
      price: 8500,
      category: 'tshirts',
      size: 'M',
      brand: 'H&M',
      color: 'Navy',
      condition: ProductCondition.veryGood,
      imageUrls: const [
        'https://images.unsplash.com/photo-1581655353564-df123a1eb820?w=800',
        'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=800',
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800',
        'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=800',
      ],
      createdAt: _daysAgo(9),
    ),
    Product(
      id: 'p-002',
      sellerId: 'u-003',
      sellerName: 'Marc D.',
      title: 'Regular Fit Polo',
      description:
          "Premium cotton polo with a classic two-button placket. Barely worn — "
          "still feels brand new to the touch. The fit is relaxed without being "
          "baggy, making it a great pick for both casual outings and smart-casual "
          "looks. Ribbed collar and cuffs hold their shape.",
      price: 11000,
      category: 'tshirts',
      size: 'L',
      brand: 'Lacoste',
      color: 'Teal',
      condition: ProductCondition.veryGood,
      imageUrls: const [
        'https://images.unsplash.com/photo-1586790170083-2f9ceadc732d?w=800',
        'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=800',
        'https://images.unsplash.com/photo-1571945153237-4929e783af4a?w=800',
      ],
      createdAt: _daysAgo(11),
    ),
    Product(
      id: 'p-003',
      sellerId: 'u-004',
      sellerName: 'Sarah K.',
      sellerAvatarUrl: 'https://i.pravatar.cc/150?img=49',
      title: 'Regular Fit Black',
      description:
          "Essential black tee made from a soft cotton blend. Keeps its shape "
          "after washing and barely fades with time. Crewneck, regular fit, "
          "medium-weight fabric suitable for year-round wear. A reliable staple "
          "you can layer under anything.",
      price: 6900,
      category: 'tshirts',
      size: 'M',
      brand: 'Uniqlo',
      color: 'Black',
      condition: ProductCondition.good,
      imageUrls: const [
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800',
        'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=800',
        'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=800',
      ],
      createdAt: _daysAgo(14),
    ),
    Product(
      id: 'p-004',
      sellerId: 'u-005',
      sellerName: 'Léa M.',
      title: 'Regular Fit V-Neck',
      description:
          "V-neck tee with subtle ribbed trim. Great for layering under a blazer "
          "or worn alone for a clean minimalist look. Slightly tapered at the "
          "waist for a flattering silhouette. Soft, breathable cotton.",
      price: 7500,
      category: 'tshirts',
      size: 'S',
      brand: 'Zara',
      color: 'Black',
      condition: ProductCondition.veryGood,
      imageUrls: const [
        'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=800',
        'https://images.unsplash.com/photo-1581655353564-df123a1eb820?w=800',
        'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=800',
      ],
      createdAt: _daysAgo(17),
    ),
    Product(
      id: 'p-005',
      sellerId: 'u-006',
      sellerName: 'Ibrahim S.',
      title: 'Slim Fit Blue Jeans',
      description:
          "Slim-cut jeans in a classic mid-blue wash. Comfortable 2% elastane "
          "stretch so they move with you throughout the day. Five-pocket "
          "construction, reinforced stitching, authentic denim feel. Ideal for "
          "casual weekends and laid-back office days.",
      price: 12500,
      category: 'jeans',
      size: '32',
      brand: "Levi's",
      color: 'Blue',
      condition: ProductCondition.good,
      imageUrls: const [
        'https://images.unsplash.com/photo-1542272604-787c3835535d?w=800',
        'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=800',
        'https://images.unsplash.com/photo-1584370848010-d7fe6bc767ec?w=800',
      ],
      createdAt: _daysAgo(21),
    ),
    Product(
      id: 'p-006',
      sellerId: 'u-007',
      sellerName: 'Priscille N.',
      sellerAvatarUrl: 'https://i.pravatar.cc/150?img=45',
      title: 'Straight Cut Black Jeans',
      description:
          "Versatile straight-leg black jeans that transition easily between "
          "casual and smart-casual looks. Medium-weight denim with a clean finish "
          "— no distressing, no rips. Fits true to size. Zip fly with button "
          "closure, belt loops.",
      price: 9800,
      category: 'jeans',
      size: '30',
      brand: 'Mango',
      color: 'Black',
      condition: ProductCondition.good,
      imageUrls: const [
        'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=800',
        'https://images.unsplash.com/photo-1584370848010-d7fe6bc767ec?w=800',
        'https://images.unsplash.com/photo-1542272604-787c3835535d?w=800',
      ],
      createdAt: _daysAgo(23),
    ),
    Product(
      id: 'p-007',
      sellerId: 'u-008',
      sellerName: 'Jean P.',
      title: 'Nike Air Force 1 White',
      description:
          "Iconic low-top sneakers in all-white leather. Light signs of wear on "
          "the outsole, uppers are still crisp. Professionally cleaned before "
          "listing. Comes with original laces plus a spare pair. Timeless pair "
          "that goes with everything.",
      price: 28500,
      category: 'shoes',
      size: '42',
      brand: 'Nike',
      color: 'White',
      condition: ProductCondition.good,
      imageUrls: const [
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
        'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800',
        'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=800',
      ],
      createdAt: _daysAgo(26),
    ),
    Product(
      id: 'p-008',
      sellerId: 'u-009',
      sellerName: 'Mireille T.',
      title: 'Adidas Ultraboost',
      description:
          "Lightweight running shoes with responsive Boost cushioning. Lightly "
          "used — mostly for light jogging around the neighborhood. Still plenty "
          "of bounce left. Primeknit upper hugs the foot comfortably. Perfect "
          "for daily runs or gym sessions.",
      price: 22000,
      category: 'shoes',
      size: '40',
      brand: 'Adidas',
      color: 'Gray',
      condition: ProductCondition.veryGood,
      imageUrls: const [
        'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=800',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800',
        'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=800',
      ],
      createdAt: _daysAgo(28),
    ),
    Product(
      id: 'p-009',
      sellerId: 'u-010',
      sellerName: 'Chloé A.',
      title: 'Floral Summer Dress',
      description:
          "Light floral dress, perfect for warm summer days. Worn only twice — "
          "still smells of fresh laundry. Flowing A-line cut with short "
          "sleeves, fully lined. Pairs beautifully with sandals or light "
          "sneakers. Small floral print on cream background.",
      price: 9500,
      category: 'dresses',
      size: 'M',
      brand: 'Zara',
      color: 'Multi',
      condition: ProductCondition.veryGood,
      imageUrls: const [
        'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=800',
        'https://images.unsplash.com/photo-1583496661160-fb5886a13d44?w=800',
        'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=800',
      ],
      createdAt: _daysAgo(30),
    ),
    Product(
      id: 'p-010',
      sellerId: 'u-011',
      sellerName: 'Yasmine K.',
      title: 'Little Black Dress',
      description:
          "The classic LBD every wardrobe needs. Tailored silhouette that hugs "
          "in the right places without being tight. Medium-weight fabric with "
          "just enough structure. Can be dressed up for evenings or down with a "
          "denim jacket. Zippered back.",
      price: 14000,
      category: 'dresses',
      size: 'S',
      brand: 'H&M',
      color: 'Black',
      condition: ProductCondition.veryGood,
      imageUrls: const [
        'https://images.unsplash.com/photo-1551232864-3f0890e580d9?w=800',
        'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=800',
        'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=800',
      ],
      createdAt: _daysAgo(34),
    ),
    Product(
      id: 'p-011',
      sellerId: 'u-012',
      sellerName: 'Robert M.',
      title: 'Leather Brown Watch',
      description:
          "Classic dress watch with genuine leather strap. Recently serviced — "
          "new battery installed, crown and crystal inspected. Quartz movement "
          "keeps accurate time. Clean minimalist dial, perfect for professional "
          "settings or formal events.",
      price: 16500,
      category: 'accessories',
      brand: 'Fossil',
      color: 'Brown',
      condition: ProductCondition.veryGood,
      imageUrls: const [
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
        'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=800',
        'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=800',
      ],
      createdAt: _daysAgo(38),
    ),
    Product(
      id: 'p-012',
      sellerId: 'u-013',
      sellerName: 'Inès W.',
      title: 'Brown Leather Handbag',
      description:
          "Genuine leather handbag in excellent condition. Spacious main "
          "compartment with zip closure, plus interior zip pocket and two slip "
          "pockets. Adjustable shoulder strap. Used a handful of times — looks "
          "almost new. Perfect for work or weekend trips.",
      price: 18000,
      category: 'accessories',
      brand: 'Mango',
      color: 'Brown',
      condition: ProductCondition.veryGood,
      imageUrls: const [
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800',
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800',
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800',
      ],
      createdAt: _daysAgo(41),
    ),
    Product(
      id: 'p-013',
      sellerId: 'u-014',
      sellerName: 'Karim B.',
      title: 'Beige Linen Shirt',
      description:
          "Lightweight linen shirt, brand-new with tags still attached. Natural "
          "slubby weave gives it a refined textured look. Breathable for hot "
          "weather, wrinkles in a way that feels intentional. Button-front, "
          "classic collar, one chest pocket.",
      price: 8200,
      category: 'tshirts',
      size: 'L',
      brand: 'H&M',
      color: 'Beige',
      condition: ProductCondition.neuf,
      imageUrls: const [
        'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=800',
        'https://images.unsplash.com/photo-1603252109612-24fa03d145c8?w=800',
        'https://images.unsplash.com/photo-1602810319428-019690571b5b?w=800',
      ],
      createdAt: _daysAgo(45),
    ),
    Product(
      id: 'p-014',
      sellerId: 'u-015',
      sellerName: 'Aïcha D.',
      title: 'Oversized Denim Jacket',
      description:
          "Vintage-inspired oversized denim jacket. Great layering piece for "
          "cooler evenings or air-conditioned interiors. Medium-weight denim, "
          "button-front, two chest pockets with flap closures. Drops past the "
          "hip for a relaxed silhouette.",
      price: 11500,
      category: 'tshirts',
      size: 'S',
      brand: "Levi's",
      color: 'Blue',
      condition: ProductCondition.good,
      imageUrls: const [
        'https://images.unsplash.com/photo-1611312449412-6cefac5dc3e4?w=800',
        'https://images.unsplash.com/photo-1551537482-f2075a1d41f2?w=800',
        'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=800',
      ],
      createdAt: _daysAgo(49),
    ),
    Product(
      id: 'p-015',
      sellerId: 'u-016',
      sellerName: 'Thomas R.',
      title: 'White Canvas Sneakers',
      description:
          "Fresh white canvas sneakers, comfortable for all-day wear. Rubber "
          "toe cap, classic laced front, clean white canvas upper. Lightly worn "
          "— a few scuffs on the toe caps that add character. Great casual "
          "all-rounder.",
      price: 7800,
      category: 'shoes',
      size: '41',
      brand: 'Converse',
      color: 'White',
      condition: ProductCondition.good,
      imageUrls: const [
        'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=800',
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
        'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=800',
      ],
      createdAt: _daysAgo(51),
    ),
    Product(
      id: 'p-016',
      sellerId: 'u-017',
      sellerName: 'Fanta L.',
      title: 'Pleated Midi Skirt',
      description:
          "Elegant pleated midi skirt that falls just below the knee. Smooth "
          "silky lining prevents cling. Elasticated waistband for a comfortable "
          "fit. Dresses up beautifully with heels or keeps it relaxed with "
          "sneakers. Great for office or dinner plans.",
      price: 6800,
      category: 'dresses',
      size: '38',
      brand: 'Zara',
      color: 'Black',
      condition: ProductCondition.good,
      imageUrls: const [
        'https://images.unsplash.com/photo-1583496661160-fb5886a13d44?w=800',
        'https://images.unsplash.com/photo-1551232864-3f0890e580d9?w=800',
        'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=800',
      ],
      createdAt: _daysAgo(55),
    ),
  ];

  static DateTime _daysAgo(int d) => DateTime.now().subtract(Duration(days: d));

  static final List<Order> myPurchases = [
    Order(
      id: 'o-001',
      orderNumber: 'ZLY-000001',
      buyerId: 'u-001',
      sellerId: 'u-003',
      productId: 'p-002',
      productTitle: 'Regular Fit Polo',
      productImageUrl: 'https://images.unsplash.com/photo-1586790170083-2f9ceadc732d?w=400',
      articlePrice: 11000,
      deliveryFee: 1000,
      totalAmount: 12000,
      zolyaCommission: 1650,
      sellerReceives: 9350,
      status: OrderStatus.inDelivery,
      deliveryAddress: const DeliveryAddress(
        neighborhood: 'Bonamoussadi',
        street: 'Rue des Palmiers',
        phone: '+237 6 78 12 34 56',
        zone: DeliveryZone.zone2,
      ),
      delivererName: 'Paul K.',
      delivererPhone: '+237 6 55 44 33 22',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    Order(
      id: 'o-002',
      orderNumber: 'ZLY-000002',
      buyerId: 'u-001',
      sellerId: 'u-008',
      productId: 'p-007',
      productTitle: 'Nike Air Force 1 White',
      productImageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
      articlePrice: 28500,
      deliveryFee: 1500,
      totalAmount: 30000,
      zolyaCommission: 4275,
      sellerReceives: 24225,
      status: OrderStatus.delivered,
      deliveryAddress: const DeliveryAddress(
        neighborhood: 'Akwa',
        street: 'Bd de la Liberté',
        phone: '+237 6 78 12 34 56',
        zone: DeliveryZone.zone1,
      ),
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      deliveredAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  static final List<Order> mySales = <Order>[];

  static void addPurchase(Order order) {
    myPurchases.insert(0, order);
  }

  static Product? productById(String id) {
    for (final p in products) {
      if (p.id == id) return p;
    }
    return null;
  }

  /// Met à jour les champs éditables d'une annonce existante (phase FakeData).
  static void updateProduct(
    String id, {
    required String title,
    required String description,
    required int price,
    required String category,
    required ProductCondition condition,
    String? size,
  }) {
    final index = products.indexWhere((p) => p.id == id);
    if (index == -1) return;
    products[index] = products[index].copyWith(
      title: title,
      description: description,
      price: price,
      category: category,
      condition: condition,
      size: size,
    );
  }

  static final List<Delivery> availableDeliveries = [
    Delivery(
      id: 'd-001',
      orderId: 'o-010',
      buyerName: 'Client test',
      buyerPhone: '+237 6 78 12 34 56',
      sellerName: 'Vendeur test',
      sellerPhone: '+237 6 55 44 33 22',
      pickupAddress: 'Bonapriso, rue 1.234',
      dropoffAddress: 'Akwa, Boulevard de la Liberté',
      dropoffNeighborhood: 'Akwa',
      fee: 500,
      status: DeliveryStatus.available,
      createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
    ),
  ];

  static const List<AddressUi> addresses = [
    AddressUi(
      id: 'a-1',
      label: 'Home',
      fullAddress: 'Bonamoussadi, Rue des Palmiers, face pharmacie centrale',
      isDefault: true,
    ),
    AddressUi(
      id: 'a-2',
      label: 'Office',
      fullAddress: 'Akwa, Boulevard de la Liberté, immeuble La Rotonde',
    ),
    AddressUi(
      id: 'a-3',
      label: 'Apartment',
      fullAddress: 'Makepe, Rue 3.045, résidence Les Jardins',
    ),
    AddressUi(
      id: 'a-4',
      label: "Parent's House",
      fullAddress: 'Bonapriso, Rue Njo-Njo, villa 12',
    ),
  ];

  static AddressUi get defaultAddress =>
      addresses.firstWhere((a) => a.isDefault, orElse: () => addresses.first);

  static const List<PaymentMethodUi> paymentMethods = [
    PaymentMethodUi(
      id: 'p-1',
      provider: MomoProvider.mtn,
      maskedNumber: '+237 6** *** *12',
      isDefault: true,
    ),
    PaymentMethodUi(
      id: 'p-2',
      provider: MomoProvider.orange,
      maskedNumber: '+237 6** *** *21',
    ),
  ];

  static PaymentMethodUi? get defaultPaymentMethod =>
      paymentMethods.where((p) => p.isDefault).firstOrNull ?? paymentMethods.firstOrNull;

  static const List<NotificationGroup> notifications = [
    NotificationGroup(
      title: 'Today',
      items: [
        NotificationItemData(
          icon: Icons.local_offer_outlined,
          title: '30% Special Discount!',
          subtitle: 'Special promotion only valid today.',
        ),
      ],
    ),
    NotificationGroup(
      title: 'Yesterday',
      items: [
        NotificationItemData(
          icon: Icons.account_balance_wallet_outlined,
          title: 'Top Up E-wallet Successfully!',
          subtitle: 'You have topped up your e-wallet.',
          isNew: true,
        ),
        NotificationItemData(
          icon: Icons.local_shipping_outlined,
          title: 'Order In Delivery!',
          subtitle: 'Your Nike Air Force is on the way.',
        ),
      ],
    ),
    NotificationGroup(
      title: 'This week',
      items: [
        NotificationItemData(
          icon: Icons.check_circle_outline,
          title: 'Order Delivered!',
          subtitle: 'Your order ZLY-000002 has been delivered.',
        ),
        NotificationItemData(
          icon: Icons.person_outline,
          title: 'Account Setup Successfully!',
          subtitle: 'Your account has been created.',
        ),
      ],
    ),
  ];

  static const List<String> recentSearches = [
    'Jeans',
    'Casual clothes',
    'Hoodie',
    'Nike shoes black',
    'V-neck tshirt',
    'Winter clothes',
  ];

  static const Map<String, ProductRatingSummary> _summaries = {
    'p-001': ProductRatingSummary(average: 4.4, totalRatings: 1034, breakdown: [720, 210, 60, 30, 14]),
    'p-002': ProductRatingSummary(average: 4.1, totalRatings: 612, breakdown: [360, 170, 45, 25, 12]),
    'p-003': ProductRatingSummary(average: 4.8, totalRatings: 890, breakdown: [790, 78, 12, 6, 4]),
    'p-004': ProductRatingSummary(average: 4.3, totalRatings: 420, breakdown: [260, 110, 30, 15, 5]),
    'p-005': ProductRatingSummary(average: 4.5, totalRatings: 780, breakdown: [520, 180, 50, 20, 10]),
    'p-006': ProductRatingSummary(average: 4.2, totalRatings: 540, breakdown: [330, 140, 40, 20, 10]),
    'p-007': ProductRatingSummary(average: 4.7, totalRatings: 1250, breakdown: [960, 220, 45, 15, 10]),
    'p-008': ProductRatingSummary(average: 4.4, totalRatings: 650, breakdown: [430, 150, 45, 15, 10]),
    'p-009': ProductRatingSummary(average: 4.6, totalRatings: 320, breakdown: [240, 60, 12, 5, 3]),
    'p-010': ProductRatingSummary(average: 4.5, totalRatings: 410, breakdown: [290, 85, 20, 10, 5]),
    'p-011': ProductRatingSummary(average: 4.3, totalRatings: 230, breakdown: [150, 55, 15, 7, 3]),
    'p-012': ProductRatingSummary(average: 4.6, totalRatings: 380, breakdown: [285, 70, 15, 7, 3]),
    'p-013': ProductRatingSummary(average: 4.8, totalRatings: 190, breakdown: [170, 15, 3, 1, 1]),
    'p-014': ProductRatingSummary(average: 4.1, totalRatings: 470, breakdown: [280, 120, 40, 20, 10]),
    'p-015': ProductRatingSummary(average: 4.2, totalRatings: 560, breakdown: [340, 150, 45, 18, 7]),
    'p-016': ProductRatingSummary(average: 4.4, totalRatings: 275, breakdown: [180, 65, 18, 8, 4]),
  };

  static const ProductRatingSummary _defaultSummary = ProductRatingSummary(
    average: 4.0,
    totalRatings: 120,
    breakdown: [70, 30, 12, 5, 3],
  );

  static ProductRatingSummary ratingSummaryFor(String productId) =>
      _summaries[productId] ?? _defaultSummary;

  static const List<ReviewItemData> _reviewPool = [
    ReviewItemData(
      rating: 5,
      comment: "Quality is way better than I expected for the price. Fabric "
          "feels premium and the cut is flattering. Will definitely buy from "
          "this seller again.",
      author: 'Wade Warren',
      timeAgo: '6 days ago',
    ),
    ReviewItemData(
      rating: 5,
      comment: "The seller shipped super fast — ordered in the morning, "
          "arrived the next day. Item matches the description exactly.",
      author: 'Guy Hawkins',
      timeAgo: '1 week ago',
    ),
    ReviewItemData(
      rating: 4,
      comment: "Really happy with this purchase. Only minor complaint is the "
          "sizing runs slightly small — size up if you're between sizes.",
      author: 'Robert Fox',
      timeAgo: '2 weeks ago',
    ),
    ReviewItemData(
      rating: 4,
      comment: "Great quality and matches the photos. Very satisfied with "
          "the overall experience. Shipping took a bit longer than expected.",
      author: 'Cameron Williamson',
      timeAgo: '3 weeks ago',
    ),
    ReviewItemData(
      rating: 5,
      comment: "Exceeded my expectations! The photos don't even do it "
          "justice. Feels like buying brand new for half the price.",
      author: 'Esther Howard',
      timeAgo: '1 month ago',
    ),
    ReviewItemData(
      rating: 3,
      comment: "Item is good overall but arrived a bit wrinkled. Nothing a "
          "quick iron couldn't fix, just wanted to mention it.",
      author: 'Jenny Wilson',
      timeAgo: '1 month ago',
    ),
    ReviewItemData(
      rating: 5,
      comment: "I've been looking for this exact piece for months. So glad I "
          "found it on Zolya. Seller was responsive and helpful throughout.",
      author: 'Brooklyn Simmons',
      timeAgo: '1 month ago',
    ),
    ReviewItemData(
      rating: 4,
      comment: "Good value for money. The item has very light signs of wear "
          "as described. Would recommend to friends.",
      author: 'Leslie Alexander',
      timeAgo: '5 weeks ago',
    ),
    ReviewItemData(
      rating: 5,
      comment: "Beautiful piece, exactly as pictured. The color is spot on "
          "and the fit is perfect. Super happy!",
      author: 'Jacob Jones',
      timeAgo: '5 weeks ago',
    ),
    ReviewItemData(
      rating: 3,
      comment: "Decent quality but a bit smaller than I expected based on "
          "the measurements. Still wearable but not my favorite.",
      author: 'Theresa Webb',
      timeAgo: '6 weeks ago',
    ),
    ReviewItemData(
      rating: 5,
      comment: "Incredibly soft fabric and the cut is really flattering. "
          "Going to be one of my new favorites for sure.",
      author: 'Savannah Nguyen',
      timeAgo: '6 weeks ago',
    ),
    ReviewItemData(
      rating: 4,
      comment: "Solid purchase. Arrived well-packaged and the item looks "
          "barely worn. Happy to give it a second life.",
      author: 'Kathryn Murphy',
      timeAgo: '7 weeks ago',
    ),
    ReviewItemData(
      rating: 5,
      comment: "Amazing condition for the price, almost like new. The "
          "seller is really trustworthy and communicative.",
      author: 'Devon Lane',
      timeAgo: '7 weeks ago',
    ),
    ReviewItemData(
      rating: 2,
      comment: "Item was a bit different from the photos — colors were off. "
          "Still usable but not what I hoped for.",
      author: 'Marvin McKinney',
      timeAgo: '2 months ago',
    ),
    ReviewItemData(
      rating: 5,
      comment: "Perfect! Exactly what I was looking for. Fast delivery, "
          "well-packaged, great communication. Five stars all around.",
      author: 'Dianne Russell',
      timeAgo: '2 months ago',
    ),
    ReviewItemData(
      rating: 4,
      comment: "Good quality for the price. A couple of very minor marks "
          "that are barely noticeable. Overall happy with the purchase.",
      author: 'Kristin Watson',
      timeAgo: '2 months ago',
    ),
    ReviewItemData(
      rating: 5,
      comment: "Highly recommend! The seller was kind enough to ship the "
          "same day I placed my order. Item is in pristine condition.",
      author: 'Eleanor Pena',
      timeAgo: '2 months ago',
    ),
    ReviewItemData(
      rating: 4,
      comment: "Nice piece, fits well. Color is slightly different in "
          "natural light but still looks great. No complaints really.",
      author: 'Darrell Steward',
      timeAgo: '3 months ago',
    ),
    ReviewItemData(
      rating: 5,
      comment: "Can't believe this was second-hand — looks and feels "
          "brand new. Will definitely shop from this seller again.",
      author: 'Floyd Miles',
      timeAgo: '3 months ago',
    ),
    ReviewItemData(
      rating: 3,
      comment: "It's okay. The description was accurate but I expected the "
          "fabric to feel a bit more substantial. Good for the price.",
      author: 'Arlene McCoy',
      timeAgo: '3 months ago',
    ),
  ];

  static List<ReviewItemData> reviewsFor(String productId) {
    final seed = productId.codeUnits.fold<int>(0, (a, b) => a + b);
    const picks = 6;
    final result = <ReviewItemData>[];
    for (var i = 0; i < picks; i++) {
      result.add(_reviewPool[(seed + i * 3) % _reviewPool.length]);
    }
    return result;
  }

  static const _sizesByCategory = {
    'tshirts': ['XS', 'S', 'M', 'L', 'XL'],
    'dresses': ['XS', 'S', 'M', 'L'],
    'jeans': ['28', '30', '32', '34', '36'],
    'shoes': ['38', '39', '40', '41', '42', '43'],
    'accessories': <String>[],
  };

  static List<String> availableSizesFor(Product product) {
    return _sizesByCategory[product.category] ?? const ['S', 'M', 'L'];
  }

  static SellerProfileUi sellerFor(String sellerId) {
    final seedProduct = products.firstWhere(
      (p) => p.sellerId == sellerId,
      orElse: () => products.first,
    );
    final hash = sellerId.codeUnits.fold<int>(0, (a, b) => a + b);
    final cities = ['Douala', 'Yaoundé', 'Bafoussam', 'Kribi', 'Limbé'];
    final bios = [
      'Passionnée de mode, je revends mes pièces avec amour et soin.',
      "Vendeur sérieux, j'expédie rapidement et emballe avec soin.",
      'Je donne une seconde vie aux beaux articles. À votre disposition !',
      'Adepte de la mode durable depuis 2 ans. Réponse rapide.',
    ];
    return SellerProfileUi(
      id: sellerId,
      fullName: seedProduct.sellerName,
      avatarUrl: seedProduct.sellerAvatarUrl,
      bio: bios[hash % bios.length],
      city: cities[hash % cities.length],
      memberSince: DateTime.now().subtract(Duration(days: 90 + (hash % 720))),
      totalSales: 12 + (hash % 80),
      totalListings: products.where((p) => p.sellerId == sellerId).length +
          (hash % 5),
      followersCount: 24 + (hash % 250),
      followingCount: 8 + (hash % 50),
      averageRating: 4.0 + ((hash % 10) / 10.0),
      totalReviews: 18 + (hash % 120),
      ratingBreakdown: [
        80 + (hash % 40),
        25 + (hash % 20),
        8 + (hash % 8),
        3 + (hash % 4),
        1 + (hash % 2),
      ],
      languages: const ['Français', 'English'],
      isVerified: (hash % 3) == 0,
    );
  }

  static List<Product> productsBySeller(String sellerId) {
    final list = products.where((p) => p.sellerId == sellerId).toList();
    if (list.isEmpty) {
      final hash = sellerId.codeUnits.fold<int>(0, (a, b) => a + b);
      return [products[hash % products.length]];
    }
    return list;
  }

  static List<Product> similarProducts(Product product, {int limit = 8}) {
    final sameCategory = products
        .where((p) => p.id != product.id && p.category == product.category)
        .toList();
    final others =
        products.where((p) => p.id != product.id && p.category != product.category);
    return [...sameCategory, ...others].take(limit).toList();
  }

  static List<ReviewItemData> sellerReviews(String sellerId) {
    final seed = sellerId.codeUnits.fold<int>(0, (a, b) => a + b);
    final result = <ReviewItemData>[];
    for (var i = 0; i < 8; i++) {
      result.add(_reviewPool[(seed + i * 5) % _reviewPool.length]);
    }
    return result;
  }

  static const List<FaqSection> faq = [
    FaqSection(
      title: 'Acheter',
      items: [
        FaqItem(
          question: 'Comment passer une commande ?',
          answer:
              "Sélectionnez l'article, choisissez votre adresse de livraison, "
              'puis votre moyen de paiement Mobile Money (MTN ou Orange). '
              'Validez : le paiement est sécurisé en escrow jusqu\'à réception.',
        ),
        FaqItem(
          question: 'Quels sont les modes de paiement acceptés ?',
          answer:
              'Zolya accepte MTN Mobile Money et Orange Money. '
              "Le paiement est bloqué jusqu'à ce que vous confirmiez "
              "la bonne réception de l'article.",
        ),
        FaqItem(
          question: 'Comment fonctionne la protection acheteur ?',
          answer:
              "Votre paiement reste en séquestre chez Zolya jusqu'à confirmation "
              'de réception. Si l\'article n\'arrive pas ou ne correspond pas, '
              'vous êtes remboursé sous 48h.',
        ),
        FaqItem(
          question: 'Puis-je faire une proposition de prix ?',
          answer:
              "Oui ! Sur chaque fiche article, le bouton « Faire une offre » "
              'permet de proposer un prix au vendeur (minimum 50% du prix '
              "affiché). Le vendeur a 24h pour accepter ou refuser.",
        ),
      ],
    ),
    FaqSection(
      title: 'Vendre',
      items: [
        FaqItem(
          question: 'Comment publier un article ?',
          answer:
              'Appuyez sur le bouton « + » au centre de la barre de navigation, '
              'ajoutez vos photos, décrivez l\'article (marque, taille, état) '
              'et fixez votre prix. La publication est instantanée et gratuite.',
        ),
        FaqItem(
          question: 'Quelle commission Zolya prélève-t-il ?',
          answer:
              'Zolya prélève 15% du prix de vente, déduits automatiquement '
              'après confirmation de livraison. Aucun frais à la mise en vente.',
        ),
        FaqItem(
          question: 'Quand suis-je payé ?',
          answer:
              "Dès que l'acheteur confirme la réception, le montant net "
              '(prix de vente - 15%) est crédité sur votre portefeuille Zolya. '
              'Vous pouvez retirer à tout moment vers votre Mobile Money.',
        ),
      ],
    ),
    FaqSection(
      title: 'Livraison',
      items: [
        FaqItem(
          question: 'Comment se passe la livraison ?',
          answer:
              "Un livreur Zolya récupère l'article chez le vendeur et "
              "l'apporte à votre adresse. Délai moyen : 24 à 48h selon la zone.",
        ),
        FaqItem(
          question: 'Quels sont les frais de livraison ?',
          answer:
              "Zone 1 (Akwa, Bonapriso) : 1 500 FCFA. "
              "Zone 2 (Bonamoussadi, Logbessou) : 1 000 FCFA. "
              'Zone 3 (Yassa, PK) : 2 000 FCFA. Les frais sont affichés au '
              'checkout selon votre adresse.',
        ),
      ],
    ),
    FaqSection(
      title: 'Compte & Sécurité',
      items: [
        FaqItem(
          question: 'Comment vérifier mon compte ?',
          answer:
              'Validez votre numéro de téléphone via le code OTP reçu par SMS. '
              "Un compte vérifié inspire plus confiance et augmente vos chances "
              'de vendre.',
        ),
        FaqItem(
          question: 'Comment changer mon mot de passe ?',
          answer:
              'Dans Paramètres → Sécurité → Mot de passe. '
              'Si vous l\'avez oublié, utilisez « Mot de passe oublié » sur '
              "l'écran de connexion.",
        ),
      ],
    ),
  ];

  static List<DiscountUi> myDiscounts() {
    return [
      DiscountUi(
        id: 'd-1',
        productId: 'p-001',
        productTitle: 'Regular Fit Slogan',
        productImageUrl:
            'https://images.unsplash.com/photo-1581655353564-df123a1eb820?w=400',
        originalPrice: 8500,
        discountedPrice: 6800,
        discountPercent: 20,
        startedAt: DateTime.now().subtract(const Duration(days: 3)),
        endsAt: DateTime.now().add(const Duration(days: 4)),
      ),
      DiscountUi(
        id: 'd-2',
        productId: 'p-007',
        productTitle: 'Nike Air Force 1 White',
        productImageUrl:
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
        originalPrice: 28500,
        discountedPrice: 22800,
        discountPercent: 20,
        startedAt: DateTime.now().subtract(const Duration(days: 1)),
        endsAt: DateTime.now().add(const Duration(days: 6)),
      ),
    ];
  }
}
