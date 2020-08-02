import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deletetx,
  }) : super(key: key);

  final  Transaction transaction;
  final Function deletetx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    // TODO: implement initState
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.black,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(leading: CircleAvatar(
        backgroundColor: _bgColor,
        radius: 30,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: FittedBox(child: Text('\$${widget.transaction.amount}')),
        ),
      ),
        title: Text(widget.transaction.title,
          style: Theme.of(context).textTheme.title ,),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width>360?FlatButton.icon(
          icon: const Icon(Icons.delete),
          label:const Text('Delete'),
          textColor: Colors.red,
          onPressed: () => widget.deletetx(widget.transaction.id),
        ):IconButton(
          icon: Icon(Icons.delete),
          color: Colors.red,
          onPressed: () => widget.deletetx(widget.transaction.id),
        ),
      ),
    );
  }
}
