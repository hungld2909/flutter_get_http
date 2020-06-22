import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://swapi.co/api/people"; //! đường link API
  List data; //! tạo 1 danh sách có tên là data.
  @override
  void initState() {//! sử dụng initState khi chạy ứng dụng nó sẽ load 1 lần duy nhất/
    super.initState();
    this.getJsonData(); //! tạo hàm getJsonData, dùng để add data và change data
  }

  Future<String> getJsonData() async {
    var response = await http.get( //! đọc file API
        //Encode the url
        Uri.encodeFull(url),
        //only accept json response
        headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body); //! convert file API thành file json
      data= convertDataToJson['results']; //! add data của json và danh sách data
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Retrieve Json via HTTP Get"),
      ),
      body: ListView.builder(//! khởi tạo listView
         itemCount: data == null ? 0 :data.length, //! nếu data = null k hiện thị, ngoài ra, nếu có data thì hiện thị
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: Container(
                      child: new Text(data[index]['name']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
//! trong bài này. trước tiên chúng ta sẽ đi add thư viện http
//! sau đó tạo giao diện trên ứng dụng/$RECYCLE.BIN
//! bước tiếp theo cấu hình cho API
//! bước cuối là kết hợp API vào trong giao diện