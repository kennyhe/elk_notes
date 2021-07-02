from functools import wraps

def trace(func):
    count = 0
    @wraps(func)
    def wrapper(*args, **kwargs):
        nonlocal count
        count += 1
        print(count, args, kwargs)
        result = func(args, kwargs)
        return result
    return wrapper

@trace
def abc(a, /, b=1, *, c=2):
    print(a, b, c)
    return a+b+c

