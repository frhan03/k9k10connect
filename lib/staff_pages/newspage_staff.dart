import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k9k10connect/staff_pages/createnews.dart';
import '../staffdrawer.dart';
import 'newsdetail_staff.dart';

class NewsStaffPage extends StatefulWidget {
  NewsStaffPage({Key? key}) : super(key: key);

  @override
  State<NewsStaffPage> createState() => _NewsStaffPageState();
}

class _NewsStaffPageState extends State<NewsStaffPage> {
  TextEditingController _searchController = TextEditingController();
  List _allResults = [];
  List _resultList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    getNewsStream();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    print(_searchController.text);
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var newsSnapShot in _allResults) {
        var title = newsSnapShot['title'].toString().toLowerCase();
        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(newsSnapShot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  getNewsStream() async {
    var data = await FirebaseFirestore.instance.collection('news').get();
    setState(() {
      _allResults = data.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: Color(0xff6750a4),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: _buildAppBar(),
        drawer: MyStaffDrawer(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search Here",
                ),
                onChanged: (query) {
                  searchResultList();
                },
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _resultList.length,
                separatorBuilder: (BuildContext context, int index) {                      
                  // custom divider using Container
                  return Container(
                    height: 2,
                    color: Colors.transparent,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> thisItem = _resultList[index].data();
                  DateTime? createdAt = thisItem['createdAt']?.toDate();
                  String formattedDate = createdAt != null
                      ? DateFormat('dd/MM/yyyy  HH:mm').format(createdAt)
                      : 'N/A';

                  return ListTile(
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      top: 5,
                      right: 10,
                      bottom: 5,
                    ),
                    title: Text(thisItem['title']),
                    subtitle: Text(formattedDate),
                    textColor: Colors.black,
                    tileColor: Colors.grey[200],
                    leading: Container(
                      height: 80,
                      width: 80,
                      child: thisItem.containsKey('image')
                          ? Image.network(thisItem['image'])
                          : Container(),
                    ),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailStaffPage(
                            newsData: thisItem,
                            formattedDate: formattedDate,
                            documentId: _resultList[index].id,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateNews(),
              ),
            );
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          backgroundColor: Color.fromARGB(255, 232, 208, 180),
        ),
      ),
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text('News'),
    actions: <Widget>[
      IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
    ],
  );
}
