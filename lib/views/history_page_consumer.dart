
import 'package:flutter/material.dart';
import 'package:veritag_app/widgets/veritag_appbar.dart';

class HistoryPageConsumer extends StatefulWidget {
  const HistoryPageConsumer({super.key});

  @override
  State<HistoryPageConsumer> createState() => _HistoryPageConsumerState();
}

class _HistoryPageConsumerState extends State<HistoryPageConsumer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VeritagAppbar(appbarTitle: 'History', arrowBackRequired: false,),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 24, top: 40),
            child: Text(
              'Recently Added',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),

          //TODO: Pull stored products from firebase DB.

          //Placeholder
          ListTile(
            leading: const Icon(Icons.check_box),
            title: const Text('Rolex Submariner'),
            subtitle: const Text('08-07-2024'),
            trailing: InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) =>
                  //           const ScanNfcResultPage(isProductAuthentic: false),
                  //     ));
                },
                child: const Icon(Icons.arrow_forward_ios)),
          )
        ],
      )),
    );
  }
}