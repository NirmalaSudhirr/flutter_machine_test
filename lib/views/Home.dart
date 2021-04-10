

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    fetchProducts();
  }

  bool loading = true;
  List products = [];
  fetchProducts() async {
    setState(() {
      loading = true;
    });


    Map<String, String> loginHeaders = {'Content-Type': 'application/json'};

      var productsUrl = "https://reqres.in/api/users?page=2";
      var response = await http.get(Uri.parse(productsUrl), headers: loginHeaders);

       var responseBody = json.decode(response.body)['data'];
       print("RRRRRRRRRRRRR,$responseBody");

      if (response.statusCode == 200) {
        var items = json.decode(response.body)['data'];
        setState(() {
          products = items;
          Future.delayed(Duration(milliseconds: 2), () {
            setState(() {
              loading = false;
            });
          });
          //loading = false;
        });
      } else {
        products = [];
        //   isLoading = false;
        await Future.delayed(Duration(milliseconds: 2), () {
          setState(() {
            loading = false;
          });
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users ListView"),
      ),
      body: getAllProductsContainer()
    );
  }
  Widget getAllProductsContainer() {

    return Container(
      // color: Colors.red[400],
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [

            Container(
                height: MediaQuery.of(context).size.height - 150,
                // constraints: BoxConstraints(minHeight: 3.6 * SizeConfig.widthMultiplier, maxHeight: 7.1 * SizeConfig.widthMultiplier),

                // width: 600,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    // itemCount: 1,
                    itemCount: products.length,
                    itemBuilder: (_, index) {
                      return  getAllProductsCard(products[index]);
                    })),
          ],
        ),
      ),
    );
  }


  Widget getAllProductsCard(item) {
    var userId = item['id'];
    var email = item['email'];
    var first_name = item['first_name'];
    var last_name = item['last_name'];
    var image = item['avatar'];
    print("USER,$email");


    return SingleChildScrollView(
      child: Container(
        //  height: 160,

        child: Card(
          elevation: 1.5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Row(children: <Widget>[

                SizedBox(
                  width: 20,
                ),

                Container(


                    child: Image.network(image)
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 120,
                              child: Text(
                                email,
                                style: TextStyle(
                                  fontSize: 15,
                                  //  fontSize: 17
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "First Name: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                                TextSpan(
                                    text: "$first_name\n",
                                    style: TextStyle(
                                      fontSize: 15,
                                    )),
                                TextSpan(
                                    text: "Last Name: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                                TextSpan(
                                    text:
                                    "$last_name \n",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300)),
                              ], style: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );

  }
}

