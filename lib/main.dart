import 'package:flutter/material.dart';
import 'package:personal_expense/widgets/new_transaction.dart';
import 'package:personal_expense/widgets/transaction_list.dart';
import './models/transaction.dart';
import 'widgets/chart.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(title:
        TextStyle(fontFamily: 'OpenSans',fontSize: 18,fontWeight: FontWeight.bold) ),
        //button : TextStyle(color: Colors.white),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(title:
          TextStyle(fontFamily: 'OpenSans',fontSize: 20) ),
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


//  String titleInput,amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransaction = [
//    Transaction(
//      id: 't1',
//      title: 'New Shoes',
//      amount: 69.99,
//      date: DateTime.now(),
//    ),
//    Transaction(
//      id: 't2',
//      title: 'Weekly Groceries',
//      amount: 16.53,
//      date: DateTime.now(),
//    ),
  ];
  List<Transaction> get _recentTransactions{
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7)
      ));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount,DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

void _startAddNewTransaction(BuildContext ctx){
  showModalBottomSheet(context: ctx ,builder: (bCtx) {
   return GestureDetector(
     onTap: () {},
       child: NewTransaction(_addNewTransaction),
   behavior: HitTestBehavior.opaque,);
  });
}

void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
      });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.add,),
                onPressed: () => _startAddNewTransaction(context),
            ),
          ],
          title: Text('Personal Expenses',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold
            ),),
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                child: Chart(_recentTransactions),
              ),
              TransactionList(_userTransaction,_deleteTransaction),
            ],
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
