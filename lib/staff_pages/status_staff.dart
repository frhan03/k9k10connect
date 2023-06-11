import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k9k10connect/drawer.dart';

class StatusStaffPage extends StatefulWidget {
  final Map<String, dynamic> report;
  final String displayName;

  const StatusStaffPage({
    required this.report,
    required this.displayName,
  });

  @override
  _StatusStaffPageState createState() => _StatusStaffPageState();
}

class _StatusStaffPageState extends State<StatusStaffPage> {
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }

 void _submitStatus() {
  if (widget.report['status'] != 'Resolved') {
    // Perform action on button click
    String selectedDate = dateController.text;
    String status = 'In-action'; // Change the status to 'In-action'
    // Update the status in the report
    widget.report['status'] = status;
    // You can perform any additional logic or API calls here
    Navigator.of(context).pop(widget.report); // Return the updated report to the previous page
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Action'),
          content: Text('The status is already "Resolved".'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: _buildAppBar(),
    drawer: MyDrawer(),
    body: Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: 20.0),
                ListTile(
                  title: Text('Name: ${widget.displayName}'),
                ),
                ListTile(
                  title: Text('Location: ${widget.report['location']}'),
                ),
                ListTile(
                  title: Text('Civil Damage: ${widget.report['category']}'),
                ),
                ListTile(
                  title: Text('Description: ${widget.report['description']}'),
                ),
                ListTile(
                  title: Text('Status: ${widget.report['status']}'),
                ),
                ListTile(
                  title: Text('In action: ${widget.report['inAction']}'),
                ),
                SizedBox(
                  child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Enter Date",
                    ),
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _submitStatus,
                      child: Text('Submit'),
                    ),
                    SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: _finishStatus,
                      child: Text('Finish'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void _finishStatus() {
  // Perform action on "Finish" button click
  String status = 'Resolved'; // Change the status to 'Resolved'
  // Update the status in the report
  widget.report['status'] = status;
  // You can perform any additional logic or API calls here
  Navigator.of(context).pop(widget.report); // Return the updated report to the previous page
}

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('Status'),
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
      ],
    );
  }
}
