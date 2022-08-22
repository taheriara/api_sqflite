import 'package:api_sqflite/src/providers/db_provider.dart';
import 'package:api_sqflite/src/providers/todo_api_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api to sqlite'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_input_antenna),
            onPressed: () async {
              await _loadFromApi();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _deleteData();
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildEmployeeListView(),
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = TodoApiProvider();
    await apiProvider.getAllEmployees();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllEmployees();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All employees deleted');
  }

  _buildEmployeeListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllEmployees(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black12,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(
                  "${index + 1}",
                  style: const TextStyle(fontSize: 20.0),
                ),
                title: Text(
                    "id: ${snapshot.data[index].id.toString()} - ${snapshot.data[index].userId.toString()} "),
                subtitle: Text('title: ${snapshot.data[index].title}'),
              );
            },
          );
        }
      },
    );
  }
}
