import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCReadPage extends StatefulWidget {
  const NFCReadPage({super.key});

  @override
  _NFCReadPageState createState() => _NFCReadPageState();
}

class _NFCReadPageState extends State<NFCReadPage> {
  String _nfcData = 'Scan an NFC tag to read its data';
  bool _isScanning = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _startNFCSession();
  // }

  void _startNFCSession() {
    setState(() {
      _isScanning = true;
    });

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      await _handleNFCDiscovered(tag);
    });
  }

  Future<void> _handleNFCDiscovered(NfcTag tag) async {
    var ndef = Ndef.from(tag);

    if (ndef == null) {
      _showErrorMessage('NFC tag is not NDEF formatted');
      return;
    }

    NdefMessage? ndefMessage = ndef.cachedMessage;

    if (ndefMessage == null) {
      _showErrorMessage('NDEF message is empty');
      return;
    }

    String tagData = ndefMessage.records.map((record) {
      return String.fromCharCodes(record.payload);
    }).join(', ');

    setState(() {
      _nfcData = tagData;
      _isScanning = false;
    });

    NfcManager.instance.stopSession();
  }

  void _showErrorMessage(String message) {
    setState(() {
      _nfcData = message;
      _isScanning = false;
    });

    NfcManager.instance.stopSession();
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
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
                _startNFCSession();
              },
              child: const Text('Start Scanning'),
            ),
          ],
        ),
      ),
    );
  }
}
