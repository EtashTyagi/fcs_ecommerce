# TODO: FILE VALIDATION, ALSO CHECK IF FILE ALREADY EXISTS
import errno
import os


def is_valid_file(file):
    return True


def upload_request_file(f, seller_id):
    fp = 'media/'+str(seller_id)+"/"+f.name
    if not os.path.exists(os.path.dirname(fp)):
        try:
            os.makedirs(os.path.dirname(fp))
        except OSError as exc:  # Guard against race condition
            if exc.errno != errno.EEXIST:
                raise
    with open(fp, 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)
