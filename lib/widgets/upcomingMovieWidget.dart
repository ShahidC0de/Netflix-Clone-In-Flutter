import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommingSoonWidget extends StatelessWidget {
  final String overview;
  final String month;
  final String day;
  final String logoUrl;
  final String imageUrl;
  const CommingSoonWidget(
      {super.key,
      required this.month,
      required this.day,
      required this.logoUrl,
      required this.imageUrl,
      required this.overview});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  month,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  day,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 5,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(imageUrl: imageUrl),
                Row(
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                      width: size.width * 0.3,
                      child: CachedNetworkImage(
                        imageUrl: logoUrl,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    const Spacer(),
                    const Column(
                      children: [
                        Icon(
                          Icons.notification_add_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          'remind me',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      children: [
                        Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        Text(
                          'info',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Coming On $month $day'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      overview,
                      maxLines: 4,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
