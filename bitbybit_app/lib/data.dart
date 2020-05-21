// import 'dart:async';
// import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
// import 'package:http/http.dart' as http;

part 'data.g.dart';

const List<String> censorText = [
  '비속어',
  '시베리아',
  '십장생',
  '쌍화차',
  '귤까라그래',
];
const List<String> tierList = [
  '티어', // 바꾸지 말것
  '밀림의 씨앗',
  '밀림의 새싹',
  '밀림의 이파리',
  '밀림의 꽃봉오리',
  '밀림의 왕',
];
const List<String> nickList = [
  '닉네임', // 바꾸지 말것
  '기대하는 수달',
  '깜짝 놀란 호랑이',
  '나른한 여우',
  '낭만적인 토끼',
  '노래하는 핑크돌고래',
  '눈치보는 카멜레온',
  '도도한 기린',
  '멋쟁이 청둥오리',
  '멍한 사자',
  '배부른 다람쥐',
  '불량한 판다',
  '소심한 고슴도치',
  '소심한 친칠라',
  '슬픈 라쿤',
  '신난 랫서판다',
  '심통난 앵무새',
  '애쓰는 극락조',
  '어리둥절한 반달가슴곰',
  '언짢은 부엉이',
  '예의바른 미어캣',
  '의기양양한 족제비',
  '졸린 표범',
  '총명한 사막여우',
  '추운 펭귄',
  '춤추는 캥거루',
  '침착한 공작',
  '평온한 나무늘보',
  '행복한 쿼카',
  '흥겨운 악어',
  '희망찬 안경원숭이',
];
const List<String> schoolList = [
  '학교', // 바꾸지 말것
  '정글고',
  '화산고',
  '아미고',
  '렛잇고',
  '플라밍고',
];
const List<String> yearList = [
  "학년", // 바꾸지 말것
  "1",
  "2",
  "3",
];
const List<String> classList = [
  "반", // 바꾸지 말것
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15"
];

@JsonSerializable()
class UserStatus {
  @JsonKey(name: "nick")
  final String nickname;
  @JsonKey(name: "tier")
  final String tier;
  @JsonKey(name: "coin")
  final int coin;
  @JsonKey(name: "score")
  final int score;
  @JsonKey(name: "count")
  final int chatCount;
  @JsonKey(name: "time")
  final int chatTime;
  @JsonKey(name: "word")
  final int wordCount;
  @JsonKey(name: "quiz")
  final int quizCorrect;

  UserStatus(
      {this.nickname = "깜짝 놀란 호랑이",
      this.tier = "밀림의 왕",
      this.coin = 1250,
      this.score = 1250,
      this.chatCount = 12,
      this.chatTime = 345,
      this.wordCount = 6789,
      this.quizCorrect = 20});

  factory UserStatus.fromJson(Map<String, dynamic> json) =>
      _$UserStatusFromJson(json);
  Map<String, dynamic> toJson() => _$UserStatusToJson(this);
}

@JsonSerializable()
class QuizData {
  final String question;
  final String answer;

  QuizData({this.question = "", this.answer = ""});

  factory QuizData.fromJson(Map<String, dynamic> json) =>
      _$QuizDataFromJson(json);
  Map<String, dynamic> toJson() => _$QuizDataToJson(this);
}

@JsonSerializable()
class QuizList {
  @JsonKey(name: "quiz_list")
  final List<QuizData> quizList;

  QuizList({List<QuizData> quizList}) : quizList = quizList ?? <QuizData>[];

  factory QuizList.fromJson(Map<String, dynamic> json) =>
      _$QuizListFromJson(json);
  Map<String, dynamic> toJson() => _$QuizListToJson(this);
}

@JsonSerializable()
class RankData {
  final int rank;
  final String tier;
  @JsonKey(name: "name")
  final String username;
  final int score;

  RankData(
      {this.rank = 0,
      this.tier = "밀림의 씨앗",
      this.username = "someone",
      this.score = 1250});

  factory RankData.fromJson(Map<String, dynamic> json) =>
      _$RankDataFromJson(json);
  Map<String, dynamic> toJson() => _$RankDataToJson(this);
}

@JsonSerializable()
class RankList {
  final int total;
  final int myrank;
  final String mytier;
  final int myscore;
  @JsonKey(name: "rank_list")
  final List<RankData> rankList;

  RankList(
      {this.total = 0,
      this.myrank = 0,
      this.mytier = "밀림의 씨앗",
      this.myscore = 1250,
      List<RankData> rankList})
      : rankList = rankList ?? <RankData>[];

  factory RankList.fromJson(Map<String, dynamic> json) =>
      _$RankListFromJson(json);
  Map<String, dynamic> toJson() => _$RankListToJson(this);
}

@JsonSerializable()
class MateInfo {
  @JsonKey(name: "name")
  final String username;
  @JsonKey(name: "nick")
  final String nickname;

  MateInfo({
    this.username = "someone",
    this.nickname = "기대하는 수달",
  });

  factory MateInfo.fromJson(Map<String, dynamic> json) =>
      _$MateInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MateInfoToJson(this);
}

@JsonSerializable()
class ReceivedMessage {
  @JsonKey(name: "from")
  final String fromname;
  @JsonKey(name: "to")
  final String toname;
  @JsonKey(name: "time")
  final String timestamp;
  @JsonKey(name: "text")
  final String text;

  ReceivedMessage({
    this.fromname = "someone",
    this.toname = "you",
    this.timestamp = "2002-02-22 22:22:22.222222",
    this.text = "안녕안녕",
  });

  factory ReceivedMessage.fromJson(Map<String, dynamic> json) =>
      _$ReceivedMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ReceivedMessageToJson(this);
}
