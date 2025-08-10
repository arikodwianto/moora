# middleware.py di app-mu

from django.shortcuts import redirect
from django.conf import settings

EXEMPT_URLS = [
    '/login/',
    '/register/',
    '/admin/',
    '/static/',
]

class LoginRequiredMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        path = request.path_info
        if not request.user.is_authenticated:
            if not any(path.startswith(url) for url in EXEMPT_URLS):
                return redirect(settings.LOGIN_URL)
        response = self.get_response(request)
        return response
