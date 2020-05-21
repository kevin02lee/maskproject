from django.shortcuts import render, HttpResponse
from django.contrib.auth import authenticate
from .models import Student, Coin, Quiz, Chat
from django.contrib.auth.models import User
from django.utils import timezone
from random import choice
from json import dumps

nick = ['기대하는 수달', '깜짝 놀란 호랑이', '나른한 여우', '낭만적인 토끼',
        '노래하는 핑크돌고래', '눈치보는 카멜레온', '도도한 기린',
        '멋쟁이 청둥오리', '멍한 사자', '배부른 다람쥐', '불량한 판다',
        '소심한 고슴도치', '소심한 친칠라', '슬픈 라쿤', '신난 랫서판다',
        '심통난 앵무새', '애쓰는 극락조', '어리둥절한 반달가슴곰', '언짢은 부엉이',
        '예의바른 미어캣', '의기양양한 족제비', '졸린 표범', '총명한 사막여우',
        '추운 펭귄', '춤추는 캥거루', '침착한 공작', '평온한 나무늘보',
        '행복한 쿼카', '흥겨운 악어', '희망찬 안경원숭이']


def join(request, group, name, password):
    try:
        User.objects.get_by_natural_key(name)
        return HttpResponse('no')
    except:
        user = User.objects.create_user(name, '', password)
        user.save()
        nickname = choice(nick)
        Student.objects.create(
            user=user,
            name=name,
            group=group,
            nick=nickname,
            tier="밀림의 씨앗"
        )
        return HttpResponse('ok')


def login(request, name, password):
    if authenticate(username=name, password=password):
        user = User.objects.get_by_natural_key(name)
        nickname = choice(nick)
        user.nick = nickname
        user.save()
        return HttpResponse('ok')
    else:
        return HttpResponse('no')


def get_info(request, name):
    user = Student.objects.filter(user=User.objects.get_by_natural_key(name))[0]
    print(user)
    info = dict()
    info["nick"] = user.nick
    info["tier"] = user.tier
    info["coin"] = len(Coin.objects.filter(user=User.objects.get_by_natural_key(name)).values_list('coin'))
    info["score"] = user.score
    info["count"] = user.count
    info["time"] = user.time
    info["word"] = user.word
    info["quiz"] = user.quiz
    return HttpResponse(dumps(info), content_type='application/json')


def rank(request, name):
    user = Student.objects.filter(user=User.objects.get_by_natural_key(name))[0]
    total_list = list(Student.objects.all().order_by('-score').values_list('name', flat=True))
    total = len(total_list)
    print(total_list)
    info = dict()
    info["total"] = total
    info["myrank"] = total_list.index(user.name) + 1
    info["mytier"] = user.tier
    info["myscore"] = user.score
    rank_list = []
    i = 1
    for stu in Student.objects.all().order_by('-score'):
        stu_info = dict()
        stu_info["rank"] = i
        stu_info["tier"] = stu.tier
        stu_info["name"] = stu.user.username
        stu_info["score"] = stu.score
        rank_list.append(stu_info)
        if i == 5:
            break
        i += 1
    info["rank_list"] = rank_list
    return HttpResponse(dumps(info), content_type='application/json')


def quiz(request, name):
    quiz_list = []
    for quiz_info in Quiz.objects.filter(user=User.objects.get_by_natural_key(name)).order_by('order'):
        info = dict()
        info["question"] = quiz_info.question
        info["answer"] = quiz_info.answer
        quiz_list.append(info)
    result = dict()
    result['quiz_list'] = quiz_list
    return HttpResponse(dumps(result), content_type='application/json')


def edit_quiz(request, name, number, question, answer):
    quiz_info = Quiz.objects.filter(user=User.objects.get_by_natural_key(name))
    # print(quiz_info)
    if len(quiz_info):
        for q in quiz_info:
            if q.order == number:
                print(number)
                q.question = question
                q.answer = answer
                q.save()
                break
        else:
            Quiz.objects.create(
                user=User.objects.get_by_natural_key(name),
                order=number,
                question=question,
                answer=answer
            )
    else:
        Quiz.objects.create(
            user=User.objects.get_by_natural_key(name),
            order=number,
            question=question,
            answer=answer
        )
    return HttpResponse('ok')


def start_chat(request, name):
    user = Student.objects.filter(user=User.objects.get_by_natural_key(name))[0]
    user.chat_state = True
    user.save()
    start = timezone.now()
    while True:
        seconds = int((timezone.now() - start).seconds)
        chat_list = Student.objects.exclude(name=name).filter(chat_state=True)
        if len(chat_list):
            link = choice(chat_list)
            info = dict()
            info["name"] = link.user.username
            info["nick"] = link.nick
            user.chat_start = timezone.now()
            user.chat_state = False
            user.save()
            return HttpResponse(dumps(info), content_type='application/json')
        if seconds > 120:
            break
    user.chat_state = False
    user.save()
    return HttpResponse("no")


def receive_chat(request, name):
    chatting = Chat.objects.filter(receive=User.objects.get_by_natural_key(name))
    if len(chatting):
        chatting = chatting.order_by('time')[0]
        print(chatting)
        info = dict()
        info["from"] = chatting.send.username
        info["to"] = chatting.receive.username
        info["time"] = chatting.time.strftime("%Y-%m-%d %H:%M:%S.%f")
        info["text"] = chatting.text
        chatting.delete()
        return HttpResponse(dumps(info), content_type='application/json')
    return HttpResponse("no")


def send_chat(request, name, to, text):
    Chat.objects.create(
        send=User.objects.get_by_natural_key(name),
        receive=User.objects.get_by_natural_key(to),
        text=text
    )
    user = Student.objects.filter(user=User.objects.get_by_natural_key(name))[0]
    user.word += len(text.split())
    user.score += len(text.split())*10
    user.save()
    return HttpResponse("ok")


def close_chat(request, name):
    user = Student.objects.filter(user=User.objects.get_by_natural_key(name))[0]
    user.chat_state = False
    user.count += 1
    start_time = Chat.objects.filter(send=User.objects.get_by_natural_key(name))
    if len(start_time):
        start_time = start_time.order_by('-time')[0].time
        for chat in Chat.objects.filter(send=User.objects.get_by_natural_key(name)):
            print(chat.time)
            chat.delete()
        total_time = timezone.now() - start_time
        total_time = total_time.total_seconds()
    else:
        total_time = 0
    user.score += total_time*10
    user.save()
    return HttpResponse("ok")


def score_quiz(request, name, correct):
    total = 100*correct
    user = Student.objects.filter(user=User.objects.get_by_natural_key(name))[0]
    user.quiz += correct
    user.score += total
    user.save()
    return HttpResponse("ok")
