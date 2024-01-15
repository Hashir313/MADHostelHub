import 'package:flutter/material.dart';

class BookingDialog extends StatefulWidget {
  @override
  _BookingDialogState createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  String selectedRoomType = 'Ac';
  TextEditingController roomController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Hashir Hostel',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('Room:'),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: roomController,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text('Room type:'),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: selectedRoomType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRoomType = newValue!;
                  });
                },
                items: <String>['Ac', 'Non Ac'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text('Price:'),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Handle the confirm booking action here
            // You can access entered values using roomController.text, selectedRoomType, and priceController.text
            Navigator.of(context).pop();
          },
          child: Text('Confirm Booking'),
        ),
      ],
    );
  }
}
