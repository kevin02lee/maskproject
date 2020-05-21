from django.urls import path
from . import views

urlpatterns = [
    path('<name>/<password>/login', views.login, name="login"),
    path('<int:group>/<name>/<password>/join', views.join, name="join"),
    path('<name>/mypage', views.get_info, name="mypage"),
    path('<name>/rank', views.rank, name="rank"),
    path('<name>/quiz', views.quiz, name="quiz"),
    path('<name>/<int:number>/<question>/<answer>/problem', views.edit_quiz, name="edit_quiz"),
    path('<name>/chatstart', views.start_chat, name="chat_start"),
    path('<name>/receive', views.receive_chat, name="chat_receive"),
    path('<name>/<to>/<text>/send', views.send_chat, name="chat_send"),
    path('<name>/chatend', views.close_chat, name="chat_end"),
    path('<name>/<int:correct>/submit', views.score_quiz, name="quiz_score")
]
