import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// listview의 특정영역을 화면에 보여주는 거 - timewatch assignment
class NetworkTestPage extends StatefulWidget {
  const NetworkTestPage({Key? key}) : super(key: key);

  @override
  State<NetworkTestPage> createState() => _NetworkTestPageState();
}

class _NetworkTestPageState extends State<NetworkTestPage> {
  TextEditingController nameController = TextEditingController();
  Future? futureData;

  getData() {
    setState(() {
      //futureData = Dio().get('https://test.bbear.kr/attendance/delay');
      futureData = Dio().get('https://test.bbear.kr/attendance');
    });
  }

  Future putData() async {
    var name = nameController.text;
    await Dio().post(
      'https://test.bbear.kr/attendance',
      data: {
        'name': name,
      },
    );
    nameController.clear();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data?.toString() ?? '데이터 없음');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await putData();
                  getData();
                },
                child: Text('보내기'),
              ),
            ],
          ),
          // ElevatedButton(onPressed: (){
          //   getData();
          // }, child: Text('받아오기')),
        ],
      ),
    );
  }
}
