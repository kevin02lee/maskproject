from django.db import models
from jsonfield import JSONField
from django.conf import settings
from django.utils import timezone


class Student(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    name = models.CharField(max_length=200)
    group = models.SmallIntegerField()
    nick = models.CharField(max_length=200)
    tier = models.CharField(max_length=200)
    score = models.IntegerField(default=0)
    count = models.IntegerField(default=0)
    time = models.IntegerField(default=0)
    word = models.IntegerField(default=0)
    quiz = models.IntegerField(default=0)
    chat_state = models.BooleanField(default=False)
    chat_start = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return self.name


class Quiz(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    order = models.SmallIntegerField()
    question = models.CharField(max_length=200)
    answer = models.CharField(max_length=200)

    def __str__(self):
        return self.question


class Coin(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    coin = JSONField(default="{}")

    def __str__(self):
        return self.user.username


class Chat(models.Model):
    send = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='send')
    receive = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='receive')
    time = models.DateTimeField(default=timezone.now)
    text = models.CharField(max_length=200)

    def __str__(self):
        return self.text
