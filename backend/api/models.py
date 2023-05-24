from django.contrib.auth.models import User
from django.db import models

class Forum(models.Model):
    name = models.CharField(max_length=200)
    date = models.DateTimeField(auto_now_add = True)

class Topic(models.Model):
    title = models.CharField(max_length=200)
    content = models.TextField()
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    forum = models.ForeignKey(Forum, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add = True)

class Comment(models.Model):
    content = models.TextField()
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    topic = models.ForeignKey(Topic, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add = True)