import 'package:api_sqflite/src/providers/db_provider.dart';
import 'package:api_sqflite/src/providers/question_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  var isLoading = false;

  String miladiToShamsi(String d) {
    DateTime parseDt = DateTime.parse(d);
    // https://pub.dev/packages/shamsi_date/example
    Jalali j1 = parseDt.toJalali();
    final f = j1.formatter;
    return '${f.wN} ${f.d} ${f.mN} ${f.yyyy == Jalali.now().year.toString() ? '' : f.yyyy}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api to sqlite Questions'),
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
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: () async {
              await _deleteDb();
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildQuestionListView(),
    );
  }

  _deleteDb() async {
    await DBProvider.db.deleteDb();
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });
    //DBProvider.db.getAllEmployees();
    var apiProvider = QuestionApiProvider();
    await apiProvider.getAllQuestionApi();

    setState(() => isLoading = false);
    // wait for 2 seconds to simulate loading of data
    // await Future.delayed(const Duration(seconds: 2));
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllQuestions().then((value) {
      print('deleted ${value.toString()} items.');
      setState(() {
        isLoading = false;
      });
    });

    // wait for 1 second to simulate loading of data
    //await Future.delayed(const Duration(seconds: 1));

    print('All question deleted');
  }

  _buildQuestionListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllQuestions(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print('count in listView: ${snapshot.data.length}');

          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black12,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(
                  snapshot.data[index].faqId.toString(), //"${index + 1}",
                  style: const TextStyle(fontSize: 20.0),
                ),
                title: Text(snapshot.data[index].question),
                subtitle: Text(miladiToShamsi(
                    snapshot.data[index].creationTime.toString())),
              );
            },
          );
        }
      },
    );
  }
}
