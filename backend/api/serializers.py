from django.contrib.auth.models import User
from rest_framework import serializers
from .models import Forum, Topic, Comment
from rest_framework.authtoken.models import Token

# User Serializer
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'password')
        extra_kwargs = {'password': {'write_only': True, 'required': True}}

# Register Serializer
class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User  # Remove the parentheses
        fields = ('id', 'username', 'password')
        extra_kwargs = {'password': {'write_only': True, 'required': True}}

    def create(self, validated_data):
        user = User.objects.create_user(validated_data['username'], validated_data['password'])  # Remove the parentheses
        return user

class ForumSerializer(serializers.ModelSerializer):
    class Meta:
        model = Forum
        fields = '__all__'

class TopicSerializer(serializers.ModelSerializer):
    class Meta:
        model = Topic
        fields = '__all__'

class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = '__all__'
