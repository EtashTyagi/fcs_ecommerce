# TODO: FILE VALIDATION, ALSO CHECK IF FILE ALREADY EXISTS
import errno
import os
import magic
from django.core.exceptions import ValidationError
from django.utils.deconstruct import deconstructible
from django.template.defaultfilters import filesizeformat


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
            raise ValidationError(f"File should be < {self.max_size/1024}kB.")

        if self.min_size is not None and data.size < self.min_size:
            params = {
                'min_size': filesizeformat(self.min_size),
                'size': filesizeformat(data.size)
            }
            raise ValidationError(f"File should be > {self.min_size/1024}kB.")

        if self.content_types:
            content_type = magic.from_buffer(data.read(), mime=True)
            data.seek(0)

            if content_type not in self.content_types:
                params = { 'content_type': content_type }
                raise ValidationError(f"File should be: {self.content_types}.")

    def __eq__(self, other):
        return (
            isinstance(other, FileValidator) and
            self.max_size == other.max_size and
            self.min_size == other.min_size and
            self.content_types == other.content_types
        )


def upload_prod_image_file(f, seller_id, prod_title):
    fp = 'media/'+str(seller_id)+"/"+str(prod_title)+"/"+f.name
    if not os.path.exists(os.path.dirname(fp)):
        try:
            os.makedirs(os.path.dirname(fp))
        except OSError as exc:  # Guard against race condition
            if exc.errno != errno.EEXIST:
                raise
    with open(fp, 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)
