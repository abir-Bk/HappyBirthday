import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Elegant Singer App'),
        ),
        body: SplitScreen(),
      ),
    );
  }
}

class SplitScreen extends StatefulWidget {
  @override
  _SplitScreenState createState() => _SplitScreenState();
}

class _SplitScreenState extends State<SplitScreen> {
  List<String> singers = ['Adele', 'Ed Sheeran', 'Beyoncé', 'Taylor Swift'];
  List<String> likedSingers = [];
  List<String> displayedSingers = [];

  void _showMore() {
    setState(() {
      displayedSingers = singers;
    });
  }

  void _showLiked() {
    setState(() {
      displayedSingers = likedSingers;
    });
  }

  void _likeSinger(String singer) {
    if (!likedSingers.contains(singer)) {
      setState(() {
        likedSingers.add(singer);
      });
    }
  }

  void _unlikeSinger(String singer) {
    setState(() {
      likedSingers.remove(singer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left side with buttons
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.teal.withOpacity(0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _showLiked,
                  icon: Icon(Icons.favorite),
                  label: Text('Liked'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _showMore,
                  icon: Icon(Icons.queue_music),
                  label: Text('More Singers'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right side with the list
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: displayedSingers.length,
              itemBuilder: (context, index) {
                String singer = displayedSingers[index];
                bool isLiked = likedSingers.contains(singer);
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isLiked ? Colors.pinkAccent : Colors.grey,
                      child: isLiked ? Icon(Icons.favorite) : Icon(Icons.music_note),
                    ),
                    title: Text(singer),
                    trailing: ElevatedButton(
                      onPressed: () {
                        isLiked ? _unlikeSinger(singer) : _likeSinger(singer);
                      },
                      child: Text(isLiked ? 'Unlike' : 'Like'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLiked ? Colors.redAccent : Colors.teal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
