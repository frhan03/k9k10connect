import 'package:flutter/material.dart';


class NewsDetailPage extends StatefulWidget {
  final Map<String, dynamic> newsData; // The data of the selected news item
  final String formattedDate;
  final String documentId;

  NewsDetailPage({
    required this.newsData, 
    required this.formattedDate, 
    required this.documentId
  });

   @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage>{
  late Map<String, dynamic> newsData;

  @override
  void initState(){
    super.initState();
    newsData = widget.newsData;
  }

  // handle the updated news data
  void _handleNewsUpdate(Map<String, dynamic> updatedNewsData){
    setState(() {
      newsData = updatedNewsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsData['title']),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            if (newsData.containsKey('image'))
              Image.network(newsData['image']),
            SizedBox(height: 20),
            Text(
              newsData['title'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ), 
            Text(
              widget.formattedDate,
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),        
            SizedBox(height: 10),
            Text(
              newsData['description'],
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
