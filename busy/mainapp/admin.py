from django.contrib import admin
from mainapp.models import BPoint, Bus, BusLoc, Route

class RouteAdmin(admin.ModelAdmin):
    pass

class BusAdmin(admin.ModelAdmin):
    pass

class BPointAdmin(admin.ModelAdmin):
    pass

class BusLocAdmin(admin.ModelAdmin):
    pass

admin.site.register(Route, RouteAdmin)
admin.site.register(BPoint , BPointAdmin)
admin.site.register(Bus, BusAdmin)
admin.site.register(BusLoc, BusLocAdmin)