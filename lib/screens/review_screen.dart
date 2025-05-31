import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reviews & Ratings',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(primary: Colors.black),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const ReviewsScreen(),
    );
  }
}

class Review {
  final String author, avatarUrl, date, text;
  final double rating;
  bool expanded;
  Review({
    required this.author,
    required this.avatarUrl,
    required this.date,
    required this.text,
    required this.rating,
    this.expanded = false,
  });
}

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final List<Review> reviews = [
    Review(
      author: 'John Doe',
      avatarUrl: 'https://via.placeholder.com/40',
      date: '01 Nov, 2023',
      rating: 5,
      text:
      'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
    ),
    Review(
      author: 'Ts Store',
      avatarUrl: 'https://via.placeholder.com/40',
      date: '02 Nov, 2023',
      rating: 4.5,
      text:
      'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly...',
    ),
    // Thêm review nếu cần
  ];

  final int totalReviews = 12611;
  final Map<int, int> counts = {
    5: 8000,
    4: 3000,
    3: 1000,
    2: 400,
    1: 211,
  };

  @override
  Widget build(BuildContext context) {
    // final int maxCount = counts.values.reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Reviews & Ratings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('4.8',
                    style:
                    TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBarIndicator(
                      rating: 4.8,
                      itemBuilder: (_, __) =>
                      const Icon(Icons.star, color: Colors.amber),
                      itemSize: 20,
                    ),
                    const SizedBox(height: 4),
                    Text('$totalReviews reviews',
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            Column(
              children: counts.entries.map((entry) {
                final star = entry.key;
                final count = entry.value;
                final percent = count / totalReviews;
                final barWidth =
                    (MediaQuery.of(context).size.width - 100) * percent;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text('$star', style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 4),
                      const Icon(Icons.star,
                          size: 14, color: Colors.amber),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Container(
                              height: 8,
                              width: barWidth,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('${(percent * 100).toStringAsFixed(0)}%'),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            const Divider(),

            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: reviews.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, idx) {
                return _buildReviewCard(reviews[idx], idx);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(Review r, int idx) {
    final displayText = r.expanded || r.text.length < 100
        ? r.text
        : '${r.text.substring(0, 100)}...';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(r.avatarUrl)),
              const SizedBox(width: 8),
              Expanded(
                child:
                Text(r.author, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              RatingBarIndicator(
                rating: r.rating,
                itemBuilder: (_, __) =>
                const Icon(Icons.star, color: Colors.amber),
                itemSize: 16,
              ),
              const SizedBox(width: 4),
              Text(r.date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert, size: 20),
                itemBuilder: (_) => const [
                  PopupMenuItem(child: Text('Report')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Nội dung
          Text(displayText, style: const TextStyle(fontSize: 14)),
          if (!r.expanded && r.text.length >= 100)
            TextButton(
              onPressed: () {
                setState(() {
                  reviews[idx].expanded = true;
                });
              },
              child:
              const Text('show more', style: TextStyle(fontSize: 14)),
            ),
        ],
      ),
    );
  }
}
