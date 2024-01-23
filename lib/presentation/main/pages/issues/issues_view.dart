import 'package:flutter/material.dart';

class IssuesView extends StatefulWidget {
  const IssuesView({Key? key}) : super(key: key);

  @override
  State<IssuesView> createState() => _IssuesViewState();
}

class _IssuesViewState extends State<IssuesView> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Issues',style: TextStyle(color: Colors.black),),);
  }
}
