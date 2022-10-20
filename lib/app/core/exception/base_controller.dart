import 'package:tekzee_test/app/core/exception/exception_handling.dart';
import 'package:tekzee_test/app/utils/themes/snackbar.util.dart';

class BaseController {
  void handleError(error) {
    if (error is BadRequestException) {
      SnackbarUtil.showError(message: error.message.toString());
    } else if (error is FetchDataException) {
      SnackbarUtil.showWarning(message: error.message.toString());
    } else if (error is ApiNotRespondingException) {
      SnackbarUtil.showError(message: error.message.toString());
    } else if (error is UnAuthorizedException) {
      SnackbarUtil.showError(message: error.message.toString());
    } else {
      SnackbarUtil.showError(message: error.message.toString());
    }
  }
}
