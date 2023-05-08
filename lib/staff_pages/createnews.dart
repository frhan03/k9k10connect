import 'package:flutter/material.dart';
import 'package:k9k10connect/drawer.dart';

class CreateNews extends StatelessWidget {
  const CreateNews ({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Text(
              'Create news ',
              style: TextStyle(
                  fontStyle:
                  FontStyle
                      .normal,
                  fontWeight:
                  FontWeight
                      .bold,
                  fontSize: 25,
                  color:
                  Colors.black),
            ),
          ),


          Container(
            margin: _margin(),
            padding: EdgeInsets.symmetric(),
            child: TextFormField(
                enableInteractiveSelection: false, // will disable paste operation
                keyboardType: TextInputType.text,
                validator: (val) =>
                val!.isEmpty ? 'Invalid ' : null,
                decoration: kinputDecoration(
                    'Title',
                    null)),
          ),

          Container(
            margin: _margin(),
            child: TextFormField(
                enableInteractiveSelection: false, // will disable paste operation
                keyboardType: TextInputType.text,
                validator: (val) => val!.isEmpty ? 'Invalid ' : null,
                decoration: InputDecoration(
                  labelText: 'Description',
                  fillColor: Colors.white,
                  filled: true,
                    contentPadding: const EdgeInsets.only(left: 10, bottom: 150),
                    border: const OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                            color: Colors.black, width: 1, style: BorderStyle.solid))
                ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [OutlinedButton.icon(
              onPressed: (){

              },
              icon: Icon(
                color: Colors.brown,
                Icons.upload_file,
                size: 30,
              ),
              label: Text(
                  'Upload',
              ),


            ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 300),
            child: ElevatedButton(
                onPressed: () {},
              child: Text('POST'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange[100],
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}

InputDecoration kinputDecoration(String label,SuffixIcon) {
  return InputDecoration(
    //labelStyle: TextStyle(fontSize: 20),
      suffixIcon: SuffixIcon,
      labelText: label,
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.all(15),
      border: const OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              color: Colors.black, width: 1, style: BorderStyle.solid)));
}

EdgeInsetsGeometry _margin(){
  return EdgeInsets.only(left: 20, right: 20, top: 10);
}

EdgeInsetsGeometry _padding(){
  return EdgeInsets.only(left: 20,top: 20);
}



AppBar _buildAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text('News'),
    actions: <Widget>[
      IconButton(onPressed: null, icon: Icon(Icons.notifications)),
    ],
  );
}