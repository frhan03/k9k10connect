import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(), body: buildContainer());
  }

  Container buildContainer() {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          ListTile(
            leading: Image(image: AssetImage('assets/Screenshot (1).png')),
            title: Text("Maintenance is coming"),
            textColor: Colors.black,
            subtitle: Text("21/1/2023"),
            tileColor: Colors.grey[300],
          ),
          Divider(),
          ListTile(
            leading: Image(image: AssetImage('assets/Screenshot (1).png')),
            title: Text("Maintenance is coming"),
            textColor: Colors.black,
            subtitle: Text("21/1/2023"),
            tileColor: Colors.grey[300],
          ),
          Divider(),
          ListTile(
            leading: Image(image: AssetImage('assets/Screenshot (1).png')),
            title: Text("Make sure to clean your room"),
            textColor: Colors.black,
            subtitle: Text("23/1/2023"),
            tileColor: Colors.grey[300],
          ),
          Divider(),
          ListTile(
            leading: Image(image: AssetImage('assets/Screenshot (1).png')),
            title: Text("Maintenance is coming"),
            textColor: Colors.black,
            subtitle: Text("21/1/2023"),
            tileColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('News'),
      actions: <Widget>[
        IconButton(onPressed: null, icon: Icon(Icons.notifications)),
      ],
    );
  }
}
