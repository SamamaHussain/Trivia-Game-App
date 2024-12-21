import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_game_app/ListProvider.dart';

class second extends StatefulWidget {
  const second({super.key});

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(
        builder: (context, ListProviderModel, child) =>Scaffold(
      appBar: AppBar(
        title: Text('Second Page',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: 
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Text(ListProviderModel.numbersList.last.toString(),style: TextStyle(fontSize: 20),),
              Expanded(
                child: ListView.builder(itemCount: ListProviderModel.numbersList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(ListProviderModel.numbersList[index].toString(),style: TextStyle(fontSize: 20),),
                    
                  );
                },),
              ),
              FloatingActionButton(onPressed: (){
                ListProviderModel.add();
              }, child: const Icon(Icons.add),),const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}