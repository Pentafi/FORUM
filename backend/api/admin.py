from django.contrib import admin
from .models import Forum, Topic, Comment

admin.site.register(Forum)
admin.site.register(Topic)
admin.site.register(Comment)
