import 'package:tekzee_test/app/core/endpoint.dart';
import 'package:tekzee_test/app/core/exception/base_client.dart';
import 'package:tekzee_test/app/core/exception/base_controller.dart';
import 'package:tekzee_test/app/services/user/user.interface.dart';

class UserService with BaseController implements UserInterface {
  final BaseClient _client = BaseClient();

  @override
  getUserList(int pageNumber) async {
    final response = await _client
        .get("${Endpoint.user}?page=$pageNumber}")
        .catchError(handleError);
    // print(response);
    return response;
  }
}
