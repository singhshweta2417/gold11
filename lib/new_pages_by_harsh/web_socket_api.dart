import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late WebSocketChannel _channel;

  void connect(String url, Function(dynamic) onDataReceived) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _channel.stream.listen(
          (event) {
        final data = json.decode(event);
        onDataReceived(data);
      },
      onError: (error) {
      },
      onDone: () {
      },
    );
  }

  void disconnect() {
    _channel.sink.close();
  }
}
