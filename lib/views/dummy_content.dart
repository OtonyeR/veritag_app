import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';


class DummyScreen extends StatelessWidget {
  const DummyScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBgW,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: colorBgW,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: colorBgW,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('./assets/logo.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Jejelove Doe', // Replace with actual user name
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorSec,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'jejelovesolutions@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: colorBl,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(IconsaxPlusLinear.receipt_item,
                  color: colorPrimary),
              title: const Text('Order History'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => OrderHistoryPage(
                //             orderHistory: const [],
                //           )),
                // );
                // Handle navigation to order history screen
              },
            ),
           const Divider(),
          ],
        ),
      ),
    );
  }
}
