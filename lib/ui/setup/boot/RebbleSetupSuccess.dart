import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fossil/infrastructure/datasources/WebServices.dart';
import 'package:fossil/ui/home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RebbleSetupSuccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RebbleSetupSuccessState();
}

class _RebbleSetupSuccessState extends State<RebbleSetupSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activate Rebble services"),
      ),
      body: Column(
        children: <Widget>[
          Text(
            "All set and ready to Rebble!",
            style: Theme.of(context).textTheme.headline3,
          ),
          FutureBuilder<WSAuthUser>(
            future: WSAuthUser.get(),
            builder:
                (BuildContext context, AsyncSnapshot<WSAuthUser> snapshot) {
              if (snapshot.hasData) {
                return Text("Welcome back, ${snapshot.data.name}!");
              } else {
                return Text(" ");
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            SharedPreferences.getInstance()
                .then((value) => {
                      value.setBool("firstRun", false),
                      value.setBool("bootSetup", true)
                    })
                .then((value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) =>
                        false // it has to be this or a back button shows on the main page
                    ));
          },
          label: Text("ON TO REBBLE!")),
    );
  }
}
