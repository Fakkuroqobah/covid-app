import 'package:covid/bloc/b_about.dart';
import 'package:covid/model/m_about.dart';
import 'package:covid/utils/appStyle.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final AboutBloc _aboutBloc = AboutBloc();

  @override
  void initState() {
    super.initState();
    _aboutBloc.add(AboutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tentang", style: TextStyle(
          fontFamily: 'ibm-regular'
        )),
        elevation: 0.0,
        backgroundColor: AppStyle.primary
      ),
      body: BlocProvider<AboutBloc>(
        create: (BuildContext context) => _aboutBloc,
        child: BlocBuilder<AboutBloc, AboutState>(
          builder: (BuildContext context, AboutState state) {
            if(state is AboutLoading) {
              return Center(child: CircularProgressIndicator());
            }else if(state is AboutFailure){
              return Center(child: Text("Terjadi kesalahan"));
            }else if(state is AboutLoaded){
              AboutModel data = state.aboutModel;

              return ListView(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 130.0,
                        decoration: BoxDecoration(
                          color: AppStyle.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0)
                          ),
                        ),
                      ),

                      Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 8.0),
                            Text("Developed by", style: TextStyle(
                              fontFamily: "ibm-medium",
                              fontSize: 20.0,
                              color: Colors.white
                            )),

                            SizedBox(height: 8.0),
                            Text(data.name, style: TextStyle(
                              fontFamily: "ibm-light",
                              fontSize: 20.0,
                              color: Colors.white
                            )),

                            SizedBox(height: 20.0),
                            CircleAvatar(backgroundImage: 
                              NetworkImage(data.avatarUrl), 
                              radius: 50.0
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () => _launchURL(data.htmlUrl),
                          title: Text("My Github"),
                          subtitle: Text(data.login),
                          leading: Icon(EvaIcons.githubOutline),
                          trailing: Icon(EvaIcons.arrowRightOutline),
                        ),

                        ListTile(
                          onTap: () => _launchURL("https://twitter.com/mathdroid"),
                          title: Text("Covid Data"),
                          subtitle: Text("Mathdroid"),
                          leading: Icon(EvaIcons.activityOutline),
                          trailing: Icon(EvaIcons.arrowRightOutline),
                        ),

                        ListTile(
                          onTap: () => _launchURL("https://covid19api.com/"),
                          title: Text("Daily Covid Data"),
                          subtitle: Text("Kyle Redelinghuys"),
                          leading: Icon(EvaIcons.barChart2Outline),
                          trailing: Icon(EvaIcons.arrowRightOutline),
                        ),

                        ListTile(
                          onTap: () => _launchURL("https://www.uplabs.com/simantoo"),
                          title: Text("Designed by"),
                          subtitle: Text("SimantOo"),
                          leading: Icon(EvaIcons.personOutline),
                          trailing: Icon(EvaIcons.arrowRightOutline),
                        ),

                        ListTile(
                          onTap: () => _launchURL("https://www.flaticon.com/"),
                          title: Text("Icon by"),
                          subtitle: Text("Flaticon"),
                          leading: Icon(EvaIcons.bulbOutline),
                          trailing: Icon(EvaIcons.arrowRightOutline),
                        ),
                        
                        ListTile(
                          onTap: () => _launchURL("https://rive.app/"),
                          title: Text("Splash screen by"),
                          subtitle: Text("Rive"),
                          leading: Icon(EvaIcons.dropletOutline),
                          trailing: Icon(EvaIcons.arrowRightOutline),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }else{
              return Container();
            }
          },
        )
      )
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}