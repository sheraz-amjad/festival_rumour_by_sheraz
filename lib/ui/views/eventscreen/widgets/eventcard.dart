import 'package:flutter/material.dart';

import '../event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onBack;
  final VoidCallback? onTap;
  final VoidCallback? onNext;

  const EventCard({
    super.key,
    required this.event,
    this.onBack,
    this.onTap,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // tap works for entire card
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
        children: [
          // Main Event Card
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              image: DecorationImage(
                image: AssetImage(event.imagepath),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                children: [
                  // Overlay
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),

                  // NOW badge
                  if (event.isLive)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "NOW",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),

                  // Back icon
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                        onPressed: onNext,
                      ),
                    ),
                  ),

                  // Bottom Info
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          event.location,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.date,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Left button container
          // Positioned(
          //   left: 10,
          //   top: 100,
          //   child: GestureDetector(
          //     onTap: onTap,
          //     child: SizedBox(
          //       width: 40,
          //       height: 100,
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: Colors.red,
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //         child: const Center(
          //           child: Text(
          //             "L",
          //             style: TextStyle(color: Colors.white),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          //
          // // Right button container
          // Positioned(
          //   right: 10,
          //   top: 100,
          //   child: GestureDetector(
          //     onTap: onTap,
          //     child: SizedBox(
          //       width: 40,
          //       height: 100,
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: Colors.blue,
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //         child: const Center(
          //           child: Text(
          //             "R",
          //             style: TextStyle(color: Colors.white),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
        ),
      ),
    );
  }
}
