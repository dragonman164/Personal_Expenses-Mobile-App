import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense/models/transaction.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';


class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deletetx;
  TransactionList(this.transactions,this.deletetx);


  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? LayoutBuilder(builder: (ctx,constraints)
    {
      return Column(
        children: [
          Text(
            'No transactions added yet!',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(height: 20,),
          Container(
            height: constraints.maxHeight*0.6,
            child: Image.asset('assets/images/waiting.png',
              fit: BoxFit.cover,),
      )
      ],
      );
    }):ListView.builder(
      itemBuilder: (ctx,index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: FittedBox(child: Text('\$${transactions[index].amount}')),
            ),
          ),
            title: Text(transactions[index].title,
              style: Theme.of(context).textTheme.title ,),
            subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
           trailing: MediaQuery.of(context).size.width>360?FlatButton.icon(
             icon: Icon(Icons.delete),
               label: Text('Delete'),
               textColor: Colors.red,
               onPressed: () => deletetx(transactions[index].id),
           ):IconButton(
             icon: Icon(Icons.delete),
             color: Colors.red,
             onPressed: () => deletetx(transactions[index].id),
           ),
          ),
        );
      },

        itemCount: transactions.length,
       );
  }
}
