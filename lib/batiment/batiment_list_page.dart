import 'package:flutter/material.dart';
import 'package:immo/batiment/batiment_item.dart';

import 'batiment_model.dart';
import 'create_batiment.dart';



class BatimentListPage extends StatelessWidget {
  BatimentListPage(this.function, {Key? key}) : super(key: key);
  late Function function;


  @override
  Widget build(BuildContext context) {
    return MyBatimentListPage(function);
  }

}
class MyBatimentListPage extends StatefulWidget {
  MyBatimentListPage( this.function,{Key? key}) : super(key: key);
  late Function function;


  @override
  _MyBatimentListPage createState() => _MyBatimentListPage(function);
}

class _MyBatimentListPage extends State<MyBatimentListPage> {

  late Function function;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes batiments'),
      ),
      body: Container(
        child: getBatimentListItem(context, (){
          setState(() {});
        }),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(

                    content: MyCreateBatimentPage(
                        BatimentModel('', '', '', '', '', ''), () {
                      setState(() {});
                    }));
              });
        },
        tooltip: '',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _MyBatimentListPage(this.function);
}