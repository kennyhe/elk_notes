class Field:
    def __init__(self):
        self.name = None
        self.internal_name = None

    def __set_name__(self, owner, name):
        print("__set_name__", owner)
        print("__set_name__", owner.__dict__)
        self.name = name
        self.internal_name = "_" + name
        print("__set_name__", name)
        print("")

    def __set__(self, owner, value):
        if owner:
            print("__set__", owner)
            print("__set__", owner.__dict__)
            setattr(owner, self.internal_name, value)

    def __get__(self, owner, owner_type):
        if owner:
            print("__get__", owner)
            print("__get__", owner.__dict__)
            print("__get__", owner_type)
            return getattr(owner, self.internal_name)
        else:
            return self

print("before class is defined")

class Table:
    first_name = Field()
    last_name = Field()

print("after class is defined")


table = Table()
print("")
table.first_name = "aaa"
print("")
print(table.first_name)
print("table.__dict__", table.__dict__)


table2 = Table()
print("table2.__dict__", table2.__dict__)
table2.ppp = "bbb"
table2.last_name = "ccc"
print("table2.__dict__", table2.__dict__)
