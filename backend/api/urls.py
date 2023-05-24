# api/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ForumViewSet, TopicViewSet, CommentViewSet, AuthViewSet

auth_viewset = AuthViewSet.as_view({'post': 'login', 'put': 'signup'})

router = DefaultRouter()
router.register(r'forums', ForumViewSet)
router.register(r'topics', TopicViewSet)
router.register(r'comments', CommentViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('api/login/', auth_viewset, name='login'),
    path('api/signup/', auth_viewset, name='signup'),
]

