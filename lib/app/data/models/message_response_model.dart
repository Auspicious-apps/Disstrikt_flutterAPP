

/*
 * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 * @author     : Gaurav Negi
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of Henceforth Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */

class MessageResponseModel {
  bool? success;
  String? message;
  String? copyrighths;

  MessageResponseModel({this.success, this.message, this.copyrighths});

  MessageResponseModel.fromJson(Map json) {
    success = json['success'];
    message = json['message'];
    copyrighths = json['copyrighths'];
  }

  Map toJson() {
    final Map data = {};
    data['success'] = success;
    data['message'] = message;
    data['copyrighths'] = copyrighths;
    return data;
  }
}