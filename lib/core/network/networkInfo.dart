import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class Networkinfo {
  Future<bool> get isConnected;
}

class NetworkinfoImpl implements Networkinfo {
  final InternetConnectionChecker connectionChecker;

  NetworkinfoImpl(this.connectionChecker);
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
