from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ForumViewSet, TopicViewSet, CommentViewSet, LoginView, RegisterView

router = DefaultRouter()
router.register(r'forums', ForumViewSet)
router.register(r'topics', TopicViewSet)
router.register(r'comments', CommentViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('auth/login/', LoginView.as_view(), name='login'),
    path('auth/register/', RegisterView.as_view({'post': 'create'}), name='register'),
]
