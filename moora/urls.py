from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),  # kalau mau aktifin admin
    path('', include('core.urls')),  # arahkan semua URL ke app_moora
]
