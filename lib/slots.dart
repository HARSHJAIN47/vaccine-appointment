import 'package:flutter/material.dart';

class Slot extends StatefulWidget {
  final List slots;

  const Slot({Key? key, required this.slots}) : super(key: key);

  @override
  _SlotState createState() => _SlotState();
}

class _SlotState extends State<Slot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available slots'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: widget.slots.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              color: Colors.grey.shade800,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name - ' + widget.slots[index]['name'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Address - ' + widget.slots[index]['address'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'State - ' + widget.slots[index]['state_name'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Vaccine - ' + widget.slots[index]['vaccine'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Available Capacity - ' +
                          widget.slots[index]['available_capacity'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Fees - ' + widget.slots[index]['fee_type'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Minimum Age Limit - ' +
                          widget.slots[index]['min_age_limit'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          'Dose 1 - ' +
                              widget.slots[index]['available_capacity_dose1']
                                  .toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Dose 2 - ' +
                              widget.slots[index]['available_capacity_dose2']
                                  .toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
