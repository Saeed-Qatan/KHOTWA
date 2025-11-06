import 'package:khotwa/core/constants/api_constants.dart';
import 'package:khotwa/model/register_model.dart';
import 'package:http/http.dart' as http;

class RegisterServices {
 
 Future<Map<String, dynamic>> registerUser(RegisterModel registerModel) async {
  final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.register);
  final response =  await http.post(
    url,
    body: {
      'email': registerModel.email,
      'password': registerModel.password.toString(),
      'confirmPassword': registerModel.confirmPassword.toString(),
      'firstName': registerModel.firstName,
      'fatherName': registerModel.fatherName,
      'familyName': registerModel.familyName,
      'phoneNumber': registerModel.phoneNumber.toString(),
    },
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    return {'success': true, 'data': response.body};
  } else {
    return {'success': false, 'error': response.body};
  }
    
 }
  
}