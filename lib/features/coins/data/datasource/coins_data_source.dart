import 'package:http/http.dart';
import 'package:prova_luis_honorato/api/coins_api_key.dart';

class CoinsDataSource {
  final Client client;

  const CoinsDataSource({required this.client});

  Future<Response> getCoinsValue({
    required String coinsQuery,
  }) async {
    final response =
        await client.get(Uri.parse('$coinsApiKey/last/$coinsQuery'));

    return response;
  }
}
