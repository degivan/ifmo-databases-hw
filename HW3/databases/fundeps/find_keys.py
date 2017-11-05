# coding=utf-8


# Класс функциональной зависимости
class Relation(object):
    def __init__(self, left, right):
        self.left = left
        self.right = right

    def __str__(self):
        return str(self.left) + " --> " + str(self.right)


# Считаем замыкание множества аттрибутов над множеством функциональных зависимостей
def compute_closure(relations, base):
    closure = base
    closure_size = len(closure)
    while True:
        for relation in relations:
            if relation.left <= closure:
                closure = closure.union(relation.right)
        if closure_size == len(closure):
            break
        closure_size = len(closure)
    return closure


# Находим надключи размера на один меньше среди подмножеств надключа
def find_subkeys(superkey, relations, all_attributes):
    subkeys = set()
    for attribute in superkey:
        potential_subkey = superkey.difference({attribute})  # удаляем атрибут из надключа
        if compute_closure(relations, potential_subkey) == all_attributes:  # если в замыкании все атрибуты
            subkeys.add(superkey.difference({attribute}))
    return subkeys


# Находим все ключи среди множеств аттрибутов
def find_keys(attributes, relations):
    full_superkey = frozenset(attributes)
    superkeys = {full_superkey}
    keys = set()
    while len(superkeys) > 0:
        new_superkeys = set()
        for superkey in superkeys:
            subkeys = find_subkeys(superkey, relations, full_superkey)
            if len(subkeys) == 0:  # если среди подмножеств нет надключей
                keys.add(superkey)
            else:
                new_superkeys = new_superkeys.union(subkeys)
        superkeys = new_superkeys  # переходим к надключам размером на один меньше
    return keys


if __name__ == "__main__":
    relation1 = Relation({"StudentId"}, {"StudentName"})
    relation2 = Relation({"GroupId"}, {"GroupName"})
    relation3 = Relation({"LecturerId"}, {"LecturerName"})
    relation4 = Relation({"CourseId"}, {"CourseName"})
    relation5 = Relation({"StudentId"}, {"GroupId"})
    relation6 = Relation({"GroupId", "CourseId"}, {"LecturerId"})
    relation7 = Relation({"StudentId", "CourseId"}, {"Mark"})
    attributes = {"StudentId", "StudentName", "GroupId", "GroupName", "LecturerId", "LecturerName", "CourseId",
                  "CourseName", "Mark"}
    print(find_keys(attributes, {relation1, relation2, relation3, relation4, relation5, relation6, relation7}))
