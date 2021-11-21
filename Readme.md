# Added Django Hoster 
- <b>Database:</b> MySQL
- <b>Database Name:</b> fcs_ecommerce
- <b>Before Run:</b>
- - Start MySQL
- - In Main -> settings.py, fill in retracted fields
- - In Main -> settings.py, change MySQL username and password
- <b>Environment variables:</b> PYTHONUNBUFFERED=1;DJANGO_SETTINGS_MODULE=Main.settings
- <b>Run From Command Line:</b> python3 manage.py runserver 0.0.0.0:443
- Update ALLOWED_HOSTS in settings.py for running on server, allowing others to access
s
