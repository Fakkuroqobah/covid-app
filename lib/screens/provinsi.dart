import 'package:covid/bloc/b_provinsi.dart';
import 'package:covid/model/m_provinsi.dart';
import 'package:covid/utils/appStyle.dart';
import 'package:covid/widgets/buildCardProvinsi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Provinsi extends StatefulWidget {
  @override
  _ProvinsiState createState() => _ProvinsiState();
}

class _ProvinsiState extends State<Provinsi> {
  final ProvinsiBloc _provinsiBloc = ProvinsiBloc();

  @override
  void initState() {
    super.initState();
    _provinsiBloc.add(ProvinsiEvent());
  }

  Future<void> _refreshContent() async {
    _provinsiBloc.add(ProvinsiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.primary,
      appBar: AppBar(
        title: Text("Detail Provinsi", style: TextStyle(
          fontFamily: 'ibm-regular'
        )),
        elevation: 0.0,
        backgroundColor: AppStyle.primary
      ),
      body: RefreshIndicator(
        onRefresh: _refreshContent,
        child: BlocProvider<ProvinsiBloc>(
          create: (BuildContext context) => _provinsiBloc,
          child: BlocBuilder<ProvinsiBloc, ProvinsiState>(
            builder: (BuildContext context, ProvinsiState state) {
              if(state is ProvinsiLoading) {
                return Center(child: CircularProgressIndicator());
              }else if(state is ProvinsiFailure){
                return Center(child: Text("Terjadi kesalahan"));
              }else if(state is ProvinsiLoaded){
                List<ProvinsiModel> data = state.provinsiModel;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return BuildCardProvinsi(
                      provinsi: data[index].provinsi,
                      confirmed: data[index].kasusPosi,
                      recovered: data[index].kasusSemb,
                      deaths: data[index].kasusMeni,
                    );
                  },
                );
              }else{
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}