import 'package:flutter/material.dart';

import 'TextStyle_utils.dart';
import 'colorUtils.dart';

class Custom_Header extends StatefulWidget {
  final Widget body;

  const Custom_Header({Key? key, required this.body}) : super(key: key);

  @override
  State<Custom_Header> createState() => _Custom_HeaderState();
}

class _Custom_HeaderState extends State<Custom_Header> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: NestedScrollView(
        floatHeaderSlivers: true,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
                    SliverAppBar(
                      backgroundColor: Colors.black,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: ColorUtils.primary_gold,
                        ),
                      ),
                      title: Text(
                        'Payment',
                        style: FontStyleUtility.h16(
                            fontColor: ColorUtils.primary_gold, family: 'PM'),
                      ),
                      centerTitle: true,
                      pinned: true,
                      floating: true,
                      // forceElevated: innerBoxIsScrolled,
                    )
                  ],
          body: widget.body),
    );
  }
}
