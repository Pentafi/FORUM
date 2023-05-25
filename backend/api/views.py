from django.contrib.auth import authenticate, login
from rest_framework import viewsets, status
from rest_framework.response import Response
from .models import Forum, Topic, Comment
from .serializers import ForumSerializer, TopicSerializer, CommentSerializer
from django.contrib.auth.models import User
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from .serializers import UserSerializer, RegisterSerializer
from rest_framework.permissions import AllowAny
from rest_framework.authtoken.serializers import AuthTokenSerializer

class LoginView(ObtainAuthToken):
    serializer_class = AuthTokenSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user_id': user.pk,
            'username': user.username
        })

class RegisterView(viewsets.ModelViewSet):
    queryset = User.objects.all()
    permission_classes = [AllowAny]  
    serializer_class = RegisterSerializer
    
class ForumViewSet(viewsets.ModelViewSet):
    queryset = Forum.objects.all()
    serializer_class = ForumSerializer

class TopicViewSet(viewsets.ModelViewSet):
    queryset = Topic.objects.all()
    serializer_class = TopicSerializer

class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer
