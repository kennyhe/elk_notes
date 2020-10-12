class Property:
    def __init__(self):
        self._a = 1
        self.b = 2

    def __getattr__(self, name):
        print(f"__getattr__({name})")
        if name == "c":
            setattr(self, name, 3)
            return 3
        return None

    def __getattribute__(self, name):
        print(f"__getattribute__({name})")
        return super().__getattribute__(name)

    def __setattr__(self, name, value):
        print(f"__setattr__({name}, {value})")
        super().__setattr__(name, value)

    @property
    def a(self):
        print("a")
        return self._a

    @a.setter
    def a(self, param):
        print(f"a={param}")
        self._a = param
        self.b = param


p = Property()
print("get c?", getattr(p, "c"))
print("")
print("has c?", hasattr(p, "c"))

print(p.a, p.b, p.c)
p.a = 3
print(p.a, p.b)
p.c = 5
print(p.c)