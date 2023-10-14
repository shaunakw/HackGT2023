import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:watt_wizard/widgets/connected_device_tile.dart';
import 'package:watt_wizard/widgets/scan_result_tile.dart';
import 'package:watt_wizard/utils/extra.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.username});

  final String username;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<BluetoothDevice> _connectedDevices = [];
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  @override
  void initState() {
    super.initState();

    FlutterBluePlus.connectedSystemDevices.then((devices) {
      List<BluetoothDevice> device = [];
      for (BluetoothDevice d in devices) {
        if (d.platformName == "Light Control") {
          device.add(d);
        }
      }
      _connectedDevices = device;
      setState(() {});
    });

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      List<ScanResult> result = [];
      for (ScanResult r in results) {
        if (r.device.platformName == "Light Control" &&
            !_connectedDevices.contains(r.device)) {
          result.add(r);
        }
      }
      _scanResults = result;
      setState(() {});
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  Future onScanPressed() async {
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    setState(() {}); // force refresh of connectedSystemDevices
  }

  Future onStopPressed() async {
    FlutterBluePlus.stopScan();
  }

  void onConnectPressed(BluetoothDevice device) {
    device.connectAndUpdateStream();
    _connectedDevices.add(device);
    setState(() {});
  }

  Future onRefresh() {
    if (_isScanning == false) {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    }
    setState(() {});
    return Future.delayed(const Duration(milliseconds: 500));
  }

  List<Widget> _buildConnectedDeviceTiles(BuildContext context) {
    return _connectedDevices
        .map(
          (d) => ConnectedDeviceTile(
            device: d,
            onConnect: () => onConnectPressed(d),
          ),
        )
        .toList();
  }

  List<Widget> _buildScanResultTiles(BuildContext context) {
    return _scanResults
        .map(
          (r) => ScanResultTile(
            result: r,
            onTap: () {
              _scanResults.remove(r);
              setState(() {});
              onConnectPressed(r.device);
            },
          ),
        )
        .toList();
  }

  Widget buildScanButton(BuildContext context) {
    if (FlutterBluePlus.isScanningNow) {
      return FloatingActionButton(
        onPressed: onStopPressed,
        backgroundColor: Colors.red,
        child: const Icon(Icons.stop),
      );
    } else {
      return FloatingActionButton(
          onPressed: onScanPressed, child: const Text("SCAN"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.username),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          children: <Widget>[
            const Text("Connected Devices"),
            ..._buildConnectedDeviceTiles(context),
            const Text("Scanned Devices:"),
            ..._buildScanResultTiles(context),
          ],
        ),
      ),
      floatingActionButton: buildScanButton(context),
    );
  }
}
