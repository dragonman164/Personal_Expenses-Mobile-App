import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense/models/transaction.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

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
         const SizedBox(height: 20,),
          Container(
            height: constraints.maxHeight*0.6,
            child: Image.asset('assets/images/waiting.png',
              fit: BoxFit.cover,),
      )
      ],
      );
    }):ListView.builder(
      itemBuilder: (ctx,index) {
        return TransactionItem(transaction: transactions[index], deletetx: deletetx);
      },

        itemCount: transactions.length,
       );
  }
}

