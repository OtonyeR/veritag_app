import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;

class NFCReadPage extends StatefulWidget {
  const NFCReadPage({super.key});

  @override
  _NFCReadPageState createState() => _NFCReadPageState();
}

class _NFCReadPageState extends State<NFCReadPage> {
  String _nfcData = 'Scan an NFC tag to read its data';
  bool _isScanning = false;

  Future<void> _readNfc() async {
    setState(() {
      _isScanning = true;
    });
    try {
      NFCTag tag = await FlutterNfcKit.poll();
      if (tag.ndefAvailable!) {
        var ndef = await FlutterNfcKit.readNDEFRecords();
        setState(() {
          _nfcData = ndef.isNotEmpty
              ? ndef.map((e) => e).join(', ')
              : 'No NDEF data found';
          _isScanning = false;
        });
      } else {
        _showErrorMessage('NDEF not available');
      }
    } catch (e) {
      _showErrorMessage('Error: $e');
    } finally {
      await FlutterNfcKit.finish();
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    setState(() {
      _nfcData = message;
      _isScanning = false;
    });
    FlutterNfcKit.finish();
  }

  @override
  void dispose() {
    FlutterNfcKit.finish();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC Reader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isScanning)
              const CircularProgressIndicator()
            else
              Text(
                _nfcData,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _readNfc();
              },
              child: const Text('Start Scanning'),
            ),
          ],
        ),
      ),
    );
  }
}
