class Meta(type):
    def __new__(meta, name, bases, class_dict):
        print(f'* Running {meta}.__new__ for {name}')
        print("Bases:", bases)
        print(class_dict)
        return type.__new__(meta, name, bases, class_dict)

class MyClass(metaclass=Meta):
    stuff = 123

    def foo(self):
        pass

class MySubClass(MyClass):
    ofther = 456

    def bar(self):
        pass

print("")

class MyClass2:
    stuff = 123

    def __init_subclass__(cls):
        super().__init_subclass__()
        print(f'* Running {cls.__name__}.__init_subclass__')
        print(cls.__dict__)
        print(cls.super().__dict__)


    def foo(self):
        pass

class MySubClass2(MyClass2):
    ofther = 456

    def bar(self):
        pass
