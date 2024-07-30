import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class NFCReadPage extends StatefulWidget {
  const NFCReadPage({super.key});

  @override
  _NFCReadPageState createState() => _NFCReadPageState();
}

class _NFCReadPageState extends State<NFCReadPage> {
  String _nfcData = 'Scan an NFC tag to read its data';
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    // _startNFCSession();
  }

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

  // void _startNFCSession() async {
  //   bool isAvailable = await NfcManager.instance.isAvailable();
  //   if (isAvailable) {
  //     setState(() {
  //       _isScanning = true;
  //     });

  //     NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
  //       await _handleNFCDiscovered(tag);
  //     });
  //   } else {
  //     _showErrorMessage('Device not availabe for nfc');
  //   }
  // }

  // Future<void> _handleNFCDiscovered(NfcTag tag) async {
  //   var ndef = Ndef.from(tag);

  //   if (ndef == null) {
  //     _showErrorMessage('NFC tag is not NDEF formatted');
  //     return;
  //   }

  //   NdefMessage? ndefMessage = ndef.cachedMessage;

  //   if (ndefMessage == null) {
  //     _showErrorMessage('NDEF message is empty');
  //     return;
  //   }

  //   String tagData = ndefMessage.records.map((record) {
  //     return String.fromCharCodes(record.payload);
  //   }).join(', ');

  //   setState(() {
  //     _nfcData = tagData;
  //     _isScanning = false;
  //   });

  //   NfcManager.instance.stopSession();
  // }

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
