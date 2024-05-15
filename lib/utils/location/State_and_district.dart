// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: file_names
import 'dart:convert';

import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:ui_sdk/props/ApiResponse.dart';

import 'package:lokal/utils/network/ApiRepository.dart';

class StateData {
  String stateName;
  int stateCode;

  StateData({
    required this.stateName,
    required this.stateCode,
  });

  StateData copyWith({
    String? stateName,
    int? stateCode,
  }) {
    return StateData(
      stateName: stateName ?? this.stateName,
      stateCode: stateCode ?? this.stateCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stateName': stateName,
      'stateCode': stateCode,
    };
  }

  factory StateData.fromMap(Map<String, dynamic> map) {
    return StateData(
      stateName: UiUtils.capitalizeFirstLetter(map['stateName'] as String),
      stateCode: map['stateCode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StateData.fromJson(String source) =>
      StateData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'State(stateName: $stateName, stateCode: $stateCode)';

  @override
  bool operator ==(covariant StateData other) {
    if (identical(this, other)) return true;

    return other.stateName == stateName && other.stateCode == stateCode;
  }

  @override
  int get hashCode => stateName.hashCode ^ stateCode.hashCode;
}

class DisctrictData {
  String districtName;
  int districtCode;
  DisctrictData({
    required this.districtName,
    required this.districtCode,
  });

  DisctrictData copyWith({
    String? districtName,
    int? districtCode,
  }) {
    return DisctrictData(
      districtName: districtName ?? this.districtName,
      districtCode: districtCode ?? this.districtCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'districtName': districtName,
      'districtCode': districtCode,
    };
  }

  factory DisctrictData.fromMap(Map<String, dynamic> map) {
    String districtname = map['districtName'] as String;
    return DisctrictData(
      districtName: UiUtils.capitalizeFirstLetter(districtname),
      districtCode: map['districtCode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DisctrictData.fromJson(String source) =>
      DisctrictData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Disctrict(districtName: $districtName, districtCode: $districtCode)';

  @override
  bool operator ==(covariant DisctrictData other) {
    if (identical(this, other)) return true;

    return other.districtName == districtName &&
        other.districtCode == districtCode;
  }

  @override
  int get hashCode => districtName.hashCode ^ districtCode.hashCode;
}

class BlockData {
  String blockName;
  int blockCode;
  BlockData({
    required this.blockName,
    required this.blockCode,
  });

  BlockData copyWith({
    String? blockName,
    int? blockCode,
  }) {
    return BlockData(
      blockName: blockName ?? this.blockName,
      blockCode: blockCode ?? this.blockCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'districtName': blockName,
      'districtCode': blockCode,
    };
  }

  factory BlockData.fromMap(Map<String, dynamic> map) {
    return BlockData(
      blockName: UiUtils.capitalizeFirstLetter(map['blockName'] as String),
      blockCode: map['blockCode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BlockData.fromJson(String source) =>
      BlockData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Block(blockName: $blockName, blockCode: $blockCode)';

  @override
  bool operator ==(covariant BlockData other) {
    if (identical(this, other)) return true;

    return other.blockName == blockName && other.blockCode == blockCode;
  }

  @override
  int get hashCode => blockName.hashCode ^ blockCode.hashCode;
}

class StateDataList {
  List<String> stateNameList = [];
  List<StateData> list = [];
  dynamic args;

  StateDataList({
    required this.args,
  });

  Future<void> initialize() async {
    list = await getStateList(args);
    stateNameList = list.map((e) => e.stateName).toList();
  }

  static Future<List<StateData>> getStateList(dynamic args) async {
    ApiResponse response = await ApiRepository.getStateList(args);
    if (response.isSuccess!) {
      List<dynamic> stateList = response.data as List<dynamic>;
      List<StateData> list =
          stateList.map((e) => StateData.fromMap(e)).toList();
      return list;
    } else {
      throw Exception("Failed to fetch state list");
    }
  }
}

class DistrictDataList {
  List<String> districtNameList = [];
  List<DisctrictData> list = [];
  dynamic args;

  DistrictDataList();

  Future<void> initialize({required int stateCode}) async {
    args = {"stateCode": stateCode};
    list = await getDistrictList(args);
    districtNameList = list.map((e) => e.districtName).toList();
  }

  static Future<List<DisctrictData>> getDistrictList(dynamic args) async {
    ApiResponse response = await ApiRepository.getDistrictByStateCode(args);
    if (response.isSuccess!) {
      List<dynamic> stateList = response.data as List<dynamic>;
      List<DisctrictData> list =
          stateList.map((e) => DisctrictData.fromMap(e)).toList();
      return list;
    } else {
      throw Exception("Failed to fetch state list");
    }
  }
}

class BlockDataList {
  List<String> blockNameList = [];
  List<BlockData> list = [];
  dynamic args;

  BlockDataList();

  Future<void> initialize({required int district}) async {
    args = {"districtCode": district};
    list = await getBlockList(args);
    blockNameList = list.map((e) => e.blockName).toList();
  }

  static Future<List<BlockData>> getBlockList(dynamic args) async {
    ApiResponse response = await ApiRepository.getBlockByDistrictCode(args);
    if (response.isSuccess!) {
      List<dynamic> stateList = response.data as List<dynamic>;
      List<BlockData> list =
          stateList.map((e) => BlockData.fromMap(e)).toList();
      return list;
    } else {
      throw Exception("Failed to fetch state list");
    }
  }
}
