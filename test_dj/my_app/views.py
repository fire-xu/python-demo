from django.views.generic import View
from django.views.generic.base import ContextMixin, TemplateResponseMixin


class TemplateView(TemplateResponseMixin, ContextMixin, View):

    def get(self, request, *args, **kwargs):
        context = self.get_context_data(**kwargs)
        return self.render_to_response(context)


class TestView(TemplateView):
    template_name = 'my_app/test.html'



