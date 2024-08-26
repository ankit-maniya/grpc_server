import 'package:grpc/grpc.dart';
import 'package:grpc_server/gen/helloword.pbgrpc.dart';

class Util {
  Future<void> startServer(GreeterServiceBase greeterService) async {
    final server = Server.create(
      services: [greeterService],
      codecRegistry:
          CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    );

    await server.serve(port: 50051);

    print('Server listening on port ${server.port}...');
  }
}
