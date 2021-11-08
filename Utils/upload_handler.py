# TODO: FILE VALIDATION, ALSO CHECK IF FILE ALREADY EXISTS
import errno
import os
from django.conf import settings
from django.http import HttpResponse, Http404
import magic
from django.core.exceptions import ValidationError
from django.utils.deconstruct import deconstructible
from django.template.defaultfilters import filesizeformat

from Main import settings


@deconstructible
class FileValidator(object):
    error_messages = {
        'max_size': (),
        'min_size': (),
        'content_type': (),
    }

    def __init__(self, max_size=None, min_size=None, content_types=()):
        self.max_size = max_size
        self.min_size = min_size
        self.content_types = content_types

    def __call__(self, data):
        if self.max_size is not None and data.size > self.max_size:
            params = {
                'max_size': filesizeformat(self.max_size),
                'size': filesizeformat(data.size),
            }
            raise ValidationError(f"File should be < {self.max_size / 1024}kB.")

        if self.min_size is not None and data.size < self.min_size:
            params = {
                'min_size': filesizeformat(self.min_size),
                'size': filesizeformat(data.size)
            }
            raise ValidationError(f"File should be > {self.min_size / 1024}kB.")

        if self.content_types:
            content_type = magic.from_buffer(data.read(), mime=True)
            data.seek(0)

            if content_type not in self.content_types:
                params = {'content_type': content_type}
                raise ValidationError(f"File should be: {self.content_types}.")

    def __eq__(self, other):
        return (
                isinstance(other, FileValidator) and
                self.max_size == other.max_size and
                self.min_size == other.min_size and
                self.content_types == other.content_types
        )


def upload_request_pdf_file(f, user_id):
    fp = settings.MEDIA_ROOT + "/" + str(user_id) + "/" + str(user_id) + ".pdf"
    if not os.path.exists(os.path.dirname(fp)):
        try:
            os.makedirs(os.path.dirname(fp))
        except OSError as exc:  # Guard against race condition
            if exc.errno != errno.EEXIST:
                raise OSError
    with open(fp, 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)


def download_request_pdf_file(user_id):
    file_path = settings.MEDIA_ROOT + "/" + str(user_id) + "/" + str(user_id) + ".pdf"
    if os.path.exists(file_path):
        with open(file_path, 'rb') as fh:
            response = HttpResponse(fh.read(), content_type="application/vnd.ms-excel")
            response['Content-Disposition'] = 'inline; filename=' + os.path.basename(file_path)
            return response
    raise Http404


def delete_request_pdf_file(user_id):
    fp = settings.MEDIA_ROOT + "/" + str(user_id) + "/" + str(user_id) + ".pdf"
    if not os.path.exists(os.path.dirname(fp)):
        try:
            os.makedirs(os.path.dirname(fp))
        except OSError as exc:  # Guard against race condition
            if exc.errno != errno.EEXIST:
                raise OSError
    os.remove(fp)