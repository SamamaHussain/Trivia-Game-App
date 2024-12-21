import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_game_app/ListProvider.dart';
import 'package:trivia_game_app/second.dart';

class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(
        builder: (context, ListProviderModel, child) =>Scaffold(
      appBar: AppBar(
        title: Text('First Page',style: TextStyle(color: Colors.white),),
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
              }, child: const Icon(Icons.add),),
              const SizedBox(height: 20,),
              FloatingActionButton(onPressed: (){
                ListProviderModel.remove();
              }, child: const Icon(Icons.remove_circle_outline),),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => second()));
              }, child: Text('Second Page',style: TextStyle(fontSize: 20),),),const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}