import 'package:gold11/helper/network/network_api_services.dart';
import 'package:gold11/model/notification_model.dart';
import '../res/app_url_const.dart';

class NotificationApiService{
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<NotificationModel> fetchNotification(String userToken, String notificationType) async {
    try {
      final response = await _apiServices.getGetApiResponse("${AppApiUrls.notificationApiEndPoint}$userToken/$notificationType");
      return NotificationModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> viewNotification(String userToken, String notificationId) async {
    final data ={
      "userid":userToken,
      "notification_id":notificationId
    };
    try {
      final response = await _apiServices.getPostApiResponse(AppApiUrls.viewNotificationApiEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}