import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class NfcService {
  String _nfcData = 'Scan an NFC tag to read its data';
  bool _isScanning = false;

  /// Reads data from an NFC tag if available
  Future<String> readNfc() async {
    _isScanning = true;
    try {
      NFCTag tag = await FlutterNfcKit.poll();
      if (tag.ndefAvailable!) {
        var ndef = await FlutterNfcKit.readNDEFRecords();
        _nfcData = ndef.isNotEmpty
            ? ndef.map((e) => e.payload).join(', ')
            : 'No NDEF data found';
      } else {
        _nfcData = 'NDEF not available';
      }
    } catch (e) {
      _nfcData = 'Error: $e';
    } finally {
      _isScanning = false;
      await FlutterNfcKit.finish();
    }
    return _nfcData;
  }

  /// Shows an error message in a snackbar
  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    _nfcData = message;
    _isScanning = false;
    FlutterNfcKit.finish();
  }

  /// Returns the current scanning status
  bool get isScanning => _isScanning;

  /// Returns the latest NFC data
  String get nfcData => _nfcData;

  /// Disposes the NFC resources
  void dispose() {
    FlutterNfcKit.finish();
  }
}
