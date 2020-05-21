// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatus _$UserStatusFromJson(Map<String, dynamic> json) {
  return UserStatus(
    nickname: json['nick'] as String,
    tier: json['tier'] as String,
    coin: json['coin'] as int,
    score: json['score'] as int,
    chatCount: json['count'] as int,
    chatTime: json['time'] as int,
    wordCount: json['word'] as int,
    quizCorrect: json['quiz'] as int,
  );
}

Map<String, dynamic> _$UserStatusToJson(UserStatus instance) =>
    <String, dynamic>{
      'nick': instance.nickname,
      'tier': instance.tier,
      'coin': instance.coin,
      'score': instance.score,
      'count': instance.chatCount,
      'time': instance.chatTime,
      'word': instance.wordCount,
      'quiz': instance.quizCorrect,
    };

QuizData _$QuizDataFromJson(Map<String, dynamic> json) {
  return QuizData(
    question: json['question'] as String,
    answer: json['answer'] as String,
  );
}

Map<String, dynamic> _$QuizDataToJson(QuizData instance) => <String, dynamic>{
      'question': instance.question,
      'answer': instance.answer,
    };

QuizList _$QuizListFromJson(Map<String, dynamic> json) {
  return QuizList(
    quizList: (json['quiz_list'] as List)
        ?.map((e) =>
            e == null ? null : QuizData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuizListToJson(QuizList instance) => <String, dynamic>{
      'quiz_list': instance.quizList,
    };

RankData _$RankDataFromJson(Map<String, dynamic> json) {
  return RankData(
    rank: json['rank'] as int,
    tier: json['tier'] as String,
    username: json['name'] as String,
    score: json['score'] as int,
  );
}

Map<String, dynamic> _$RankDataToJson(RankData instance) => <String, dynamic>{
      'rank': instance.rank,
      'tier': instance.tier,
      'name': instance.username,
      'score': instance.score,
    };

RankList _$RankListFromJson(Map<String, dynamic> json) {
  return RankList(
    total: json['total'] as int,
    myrank: json['myrank'] as int,
    mytier: json['mytier'] as String,
    myscore: json['myscore'] as int,
    rankList: (json['rank_list'] as List)
        ?.map((e) =>
            e == null ? null : RankData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RankListToJson(RankList instance) => <String, dynamic>{
      'total': instance.total,
      'myrank': instance.myrank,
      'mytier': instance.mytier,
      'myscore': instance.myscore,
      'rank_list': instance.rankList,
    };

MateInfo _$MateInfoFromJson(Map<String, dynamic> json) {
  return MateInfo(
    username: json['name'] as String,
    nickname: json['nick'] as String,
  );
}

Map<String, dynamic> _$MateInfoToJson(MateInfo instance) => <String, dynamic>{
      'name': instance.username,
      'nick': instance.nickname,
    };

ReceivedMessage _$ReceivedMessageFromJson(Map<String, dynamic> json) {
  return ReceivedMessage(
    fromname: json['from'] as String,
    toname: json['to'] as String,
    timestamp: json['time'] as String,
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$ReceivedMessageToJson(ReceivedMessage instance) =>
    <String, dynamic>{
      'from': instance.fromname,
      'to': instance.toname,
      'time': instance.timestamp,
      'text': instance.text,
    };
