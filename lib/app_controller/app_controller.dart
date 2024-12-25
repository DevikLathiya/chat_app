import 'dart:convert';
import 'package:get/get.dart';
import '../core/utils/storage/storage_constants.dart';
import '../core/utils/storage/storage_service.dart';

class AppController extends GetxController {

  Rx<LoginResponse> loginResponse = Rx<LoginResponse>(LoginResponse());

  @override
  void onInit() {
    navigateToPredictedRoute();
    super.onInit();
  }

  void navigateToPredictedRoute() async {
    await getLoginResponse();
    if (loginResponse.value.id != null) {
      // Get.offAllNamed(RoutesStrings.bottomNavigationRoute);
      return;
    }
    // Get.offAllNamed(RoutesStrings.loginRoute);
  }

  void storeUserInfo(Map<String, dynamic> map) {
    StorageService.setMap(key: StorageConstants.userDetails, value: map);
    loginResponse.value = LoginResponse.fromMap(map);
    loginResponse.refresh();
  }

  Future<void> getLoginResponse() async {
    StorageService.getKeyAny(key: StorageConstants.userDetails).then((value) {
      if (value != null) {
        loginResponse.value = LoginResponse.fromMap(value as Map<String, dynamic>);
        loginResponse.refresh();
      }
    });
  }

  Future<void> removeAllKeysAndLogout() async {
    await StorageService.removeAllKeysAtOnce();
    loginResponse.value = LoginResponse();
    loginResponse.refresh();
    // Get.offAllNamed(RoutesStrings.loginRoute);
    return;
  }

  Map<String, String> getHeader() {
    return {
      "Content-Type": "application/json",
      if (loginResponse.value.token != null) "Authorization": "${loginResponse.value.token}",
    };
  }


}
class LoginResponse {
  String? id;
  String? email;
  String? trainerId;
  String? userType;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? token;
  String? role;
  List<TrainerDetail>? trainerDetails;

  LoginResponse({
    this.id,
    this.email,
    this.trainerId,
    this.userType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.token,
    this.role,
    this.trainerDetails,
  });

  factory LoginResponse.fromJson(String str) => LoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
    id: json["_id"],
    email: json["email"],
    trainerId: json["trainerId"],
    userType: json["userType"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    token: json["token"],
    role: json["role"],
    trainerDetails: json["trainerDetails"] == null ? [] : List<TrainerDetail>.from(json["trainerDetails"]!.map((x) => TrainerDetail.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "email": email,
    "trainerId": trainerId,
    "userType": userType,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "token": token,
    "role": role,
    "trainerDetails": trainerDetails == null ? [] : List<dynamic>.from(trainerDetails!.map((x) => x.toMap())),
  };
}

class TrainerDetail {
  String? id;
  String? firstName;
  String? lastName;
  String? profilePic;
  String? url;
  String? instaLink;
  String? workingFor;
  List<Program>? programs;
  String? revenue;
  String? marketingAffiliation;
  String? userId;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? telegramId;
  String? whatsappNumber;
  String? fullProfilePicture;

  TrainerDetail(
      {this.id,
        this.firstName,
        this.lastName,
        this.profilePic,
        this.url,
        this.instaLink,
        this.workingFor,
        this.programs,
        this.revenue,
        this.marketingAffiliation,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.telegramId,
        this.whatsappNumber,
        this.fullProfilePicture});

  factory TrainerDetail.fromJson(String str) => TrainerDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrainerDetail.fromMap(Map<String, dynamic> json) => TrainerDetail(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    profilePic: json["profilePic"],
    url: json["url"],
    instaLink: json["instaLink"],
    workingFor: json["workingFor"],
    programs: json["programs"] == null ? [] : List<Program>.from(json["programs"]!.map((x) => Program.fromMap(x))),
    revenue: json["revenue"],
    marketingAffiliation: json["marketingAffiliation"],
    userId: json["userId"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    telegramId: json["telegramId"],
    whatsappNumber: json["whatsappNumber"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "profilePic": profilePic,
    "url": url,
    "instaLink": instaLink,
    "workingFor": workingFor,
    "programs": programs == null ? [] : List<dynamic>.from(programs!.map((x) => x.toMap())),
    "revenue": revenue,
    "marketingAffiliation": marketingAffiliation,
    "userId": userId,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "telegramId": telegramId,
    "whatsappNumber": whatsappNumber,
  };
}

class Program {
  String? name;
  int? priceAed;
  int? priceEur;
  int? priceUsd;
  int? priceGbp;
  String? id;

  Program({
    this.name,
    this.priceAed,
    this.priceEur,
    this.priceUsd,
    this.priceGbp,
    this.id,
  });

  factory Program.fromJson(String str) => Program.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Program.fromMap(Map<String, dynamic> json) => Program(
    name: json["name"],
    priceAed: json["priceAED"],
    priceEur: json["priceEUR"],
    priceUsd: json["priceUSD"],
    priceGbp: json["priceGBP"],
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "priceAED": priceAed,
    "priceEUR": priceEur,
    "priceUSD": priceUsd,
    "priceGBP": priceGbp,
    "_id": id,
  };
}