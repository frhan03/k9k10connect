import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k9k10connect/staff_pages/createnews.dart';
import '../staffdrawer.dart';
import 'newsdetail_staff.dart';

class NewsStaffPage extends StatelessWidget {
   NewsStaffPage({Key? key}) : super(key: key){
    _stream = _reference.snapshots();
  }

  CollectionReference _reference = FirebaseFirestore.instance.collection('news');
  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: Color(0xff6750a4), 
        useMaterial3: true
      ),
      home: Scaffold(
      appBar: _buildAppBar(),
      drawer: MyStaffDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          //Check if data arrived
          if (snapshot.hasData) {
            //get the data
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            List<Map<String, dynamic>> items =
                documents.map((e) => e.data() as Map<String, dynamic>).toList();

            //Display the list
            return ListView.separated(
                itemCount: items.length,
                separatorBuilder: (BuildContext context, int index) {                      
                  // custom divider using Container
                  return Container(
                    height: 2,
                    color: Colors.transparent,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> thisItem = items[index];
                  DateTime? createdAt = thisItem['createdAt']?.toDate();
                  String formattedDate = createdAt != null
                      ? DateFormat('dd/MM/yyyy  HH:mm').format(createdAt)
                      : 'N/A';
                  //REturn the widget for the list items
                  return ListTile(
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      top: 5,
                      right: 10,
                      bottom: 5,
                    ),
                    title: Text('${thisItem['title']}'),
                    subtitle: Text('$formattedDate'),
                    textColor: Colors.black,
                    tileColor: Colors.grey[200],
                    // trailing: Text(formattedDate),
                    leading: Container(
                      height: 80,
                      width: 80,
                      child: thisItem.containsKey('image') ? Image.network(
                          '${thisItem['image']}') : Container(),
                    ),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsDetailStaffPage(
                              newsData: thisItem,
                              formattedDate: formattedDate,
                              documentId: documents[index].id,
                              )
                          ),
                      );
                    },
                  );
                });
                
          }

          //Show loader
          return Center(child: CircularProgressIndicator());
        },
      ), //Display a list // Add a FutureBuilder
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateNews()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        ),
        backgroundColor: Color.fromARGB(255, 232, 208, 180),
      ),
      
    )
    );
    
    
  }
}

    AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('News'),
      actions: <Widget>[
        IconButton(onPressed: null, icon: Icon(Icons.notifications)),
     ],);}