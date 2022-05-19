import 'package:belajar_api/repository.dart';
import 'package:flutter/material.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({Key? key}) : super(key: key);

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  Repository repository = Repository();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    if (args[1].isNotEmpty) {
      _titleController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      _contentController.text = args[2];
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Tambah Data Users'),
        ),
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Title'),
              ),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(hintText: 'Content'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    bool response = await repository.postData(
                        _titleController.text, _contentController.text);

                    if (response) {
                      Navigator.of(context).popAndPushNamed('/home');
                    } else {
                      print('Sorry, Post yang anda input salah :)');
                    }
                  },
                  child: Text('Submit')),
              ElevatedButton(
                  onPressed: () async {
                    bool response = await repository.putData(int.parse(args[0]),
                        _titleController.text, _contentController.text);

                    if (response) {
                      Navigator.of(context).popAndPushNamed('/home');
                    } else {
                      print('Sorry, Post yang anda input salah :)');
                    }
                  },
                  child: Text('Update')),
            ],
          ),
        ));
  }
}
