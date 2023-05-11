import 'package:flutter/material.dart';
import '../staffdrawer.dart';


class NewsStaffPage extends StatelessWidget {
  const NewsStaffPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: MyStaffDrawer(),
      body: buildContainer(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu),
        color: Colors.black,
        onPressed: () {

        },
      ),
      title: Text('News'),
      centerTitle: true,
      titleTextStyle:
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: Colors.black,
          onPressed: () {},
        ),
      ],
    );

  }

  Container buildContainer() {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: TextButton.icon(
              icon: Icon(Icons.add),
              onPressed: () {

              },
              label: Text('Create'),
            ),
          ),

          ListTile(
            leading: Image.asset('assets/images/Screenshot1.png'),
            title: Text("Make sure to clean your room"),
            textColor: Colors.black,
            subtitle: Text("23/1/2023"),
            tileColor: Colors.grey[300],
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/Screenshot1.png'),
            title: Text("Maintenance is coming"),
            textColor: Colors.black,
            subtitle: Text("21/1/2023"),
            tileColor: Colors.grey[300],
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/Screenshot1.png'),
            title: Text("Maintenance is coming"),
            textColor: Colors.black,
            subtitle: Text("21/1/2023"),
            tileColor: Colors.grey[300],
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/Screenshot1.png'),
            title: Text("Make sure to clean your room"),
            textColor: Colors.black,
            subtitle: Text("23/1/2023"),
            tileColor: Colors.grey[300],
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets//images/Screenshot1.png'),
            title: Text("Maintenance is coming"),
            textColor: Colors.black,
            subtitle: Text("21/1/2023"),
            tileColor: Colors.grey[300],
          ),
          //Image: image(AssetImage('Screenshot (1).png')),
          //Text("Make sure to clean your room\n"),
          //Subtitle("23/1/2023"),
        ],
      ),
      //decoration: BoxDecoration(color: Colors.blueGrey),
    );
  }
}