import 'package:flutter/material.dart';
import 'package:wishy/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'wish.dart';

class WishItem extends StatelessWidget {
  final Wish wish;

  const WishItem({super.key, required this.wish});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        wish.title,
        style: TextStyle(color: headerTextColor, fontSize: 20),
        maxLines: 1,
        overflow: TextOverflow.ellipsis, // Limita y añade puntos suspensivos
      ),
      leading: const Icon(Icons.star, color: Colors.amber),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            wish.description,
            style: TextStyle(color: secondaryTextColor, fontSize: 16),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () async {
              final url = Uri.parse(wish.url);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            child: const Icon(
              Icons.open_in_browser, // O usa Icons.open_in_new, según prefieras
              color: Colors.blue,
              size: 30,
            ),
          ),
        ],
      ),
      //trailing: wish.date != null
        //  ? Text(
          //    wish.date.toString(),
            //  style: const TextStyle(fontSize: 12, color: Colors.grey),
            //)
          //: null,
    );
  }
// ...existing code...

/*
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Texto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wish.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827), // Gray 900
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    wish.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280), // Gray 500
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Corazón
            Icon(
              Icons.favorite,
              //color: isFavorite ? Color(0xFFF472B6) : Colors.grey[300], // Rose 400
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }*/
}