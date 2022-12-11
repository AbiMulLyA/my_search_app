import 'package:injectable/injectable.dart';

import '../../config/injector/injector.dart';
import 'api.dart';

@Environment(Env.dev)
@Injectable(as: MySearchApi)
class DevMySearchApi implements MySearchApi {
  @override
  String apiKeyOneSignal() => '';

  @override
  String baseUrl() =>
      'https://627e360ab75a25d3f3b37d5a.mockapi.io/api/v1/accurate';

  @override
  String environment() => 'Development';
}
