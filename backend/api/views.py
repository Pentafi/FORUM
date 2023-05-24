from django.contrib.auth import authenticate, login
from rest_framework import viewsets, status
from rest_framework.response import Response
from .models import Forum, Topic, Comment
from .serializers import ForumSerializer, TopicSerializer, CommentSerializer
from django.contrib.auth.models import User

class ForumViewSet(viewsets.ModelViewSet):
    queryset = Forum.objects.all()
    serializer_class = ForumSerializer

class TopicViewSet(viewsets.ModelViewSet):
    queryset = Topic.objects.all()
    serializer_class = TopicSerializer

class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer

class AuthViewSet(viewsets.ViewSet):
    def login(self, request):
        username = request.data.get('username')
        password = request.data.get('password')

        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return Response({'detail': 'Login successful'})
        else:
            return Response({'error': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)

    def signup(self, request):
        username = request.data.get('username')
        password = request.data.get('password')

        # Perform any additional validations or checks here before creating the user
        user = User.objects.create_user(username=username, password=password)
        if user is not None:
            login(request, user)
            return Response({'detail': 'Signup successful'})
        else:
            return Response({'error': 'Signup failed'}, status=status.HTTP_400_BAD_REQUEST)
