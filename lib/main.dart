import 'package:belajar_api/add-users.dart';
import 'package:belajar_api/model.dart';
import 'package:belajar_api/repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => MyHomePage(title: 'Belajar API'),
        '/add-users': (context) => AddUsers(),
      },
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Belajar API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Users> listBlog = [];
  Repository repository = Repository();

  getData() async {
    listBlog = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).popAndPushNamed('/add-users'),
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .popAndPushNamed('/add-users', arguments: [
                    listBlog[index].id,
                    listBlog[index].title,
                    listBlog[index].content
                  ]),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listBlog[index].title,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(listBlog[index].content),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      bool response =
                          await repository.deleteData(listBlog[index].id);
                      if (response) {
                        print('Sukses bro');
                      } else {
                        print('Coba Lagi!');
                      }
                      getData();
                    },
                    icon: Icon(Icons.delete))
              ],
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: listBlog.length),
    );
  }
}
