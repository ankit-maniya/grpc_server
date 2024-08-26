import 'package:grpc/grpc.dart';
import 'package:grpc_server/gen/helloword.pbgrpc.dart';
import 'package:grpc_server/utils/util.dart';

class GreeterService extends GreeterServiceBase {
  @override
  Future<HelloReply> sayHello(ServiceCall call, HelloRequest request) {
    print("Request ${request.name}");

    return Future.value(HelloReply()..message = 'Hello, ${request.name} 😎!');
  }

  @override
  Future<QRScanResponse> invokeQRCodeScan(
      ServiceCall call, QRScanRequest request) {
    print('Server requested QR code scan with ID: ${request.requestId}');
    return Future.value(QRScanResponse()..status = 'SCAN_STARTED');
  }

  @override
  Future<QRCodeResponse> sendQRCodeData(ServiceCall call, QRCodeData request) {
    print(
        'Received QR code: ${request.qrCode} for request ID: ${request.requestId}');
    return Future.value(QRCodeResponse()..status = 'DATA_RECEIVED');
  }
}

void main(List<String> args) async {
  final greeterService = GreeterService();
  Util util = Util();
  await util.startServer(greeterService);
}
