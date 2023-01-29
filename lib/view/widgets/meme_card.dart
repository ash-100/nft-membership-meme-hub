import 'package:flutter/material.dart';

class MemeCard extends StatelessWidget {
  const MemeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blue,
      ),
      child: AspectRatio(
        aspectRatio: 1.2,
        child: Column(
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 100,
                child: Text('Image'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.thumb_up),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.thumb_down),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
