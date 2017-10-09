# coding=utf-8
from fundeps.find_keys import Relation, compute_closure


# Расщепляем правые части
def split_right_part(relations):
    splitted = set()
    for relation in relations:
        for right_elem in relation.right:
            splitted.add(Relation(relation.left, {right_elem}))
    return splitted


# Удаляем атрибуты из левых частей
def delete_left_attributes(relations):
    return set([reduce_left(relation, relations) for relation in relations])


# Удаляем из правила все 'лишние' атрибуты
def reduce_left(rule, relations):
    result_left = set()
    if len(rule.left) == 1:
        return rule
    for attr in rule.left:
        without_attr = rule.left.difference({attr})
        prev_closure = compute_closure(relations, without_attr)  # считаем старое замыкание
        new_relations = relations.difference({rule}).union({Relation(without_attr, rule.right)})
        new_closure = compute_closure(new_relations, without_attr)  # считаем замыкание после замены правила
        if prev_closure != new_closure:
            result_left.add(attr)
    return Relation(result_left, rule.right)


# Удаляем ненужные правила
def delete_rules(relations):
    return filter(lambda x: not is_rule_removable(x, relations), relations)


# Проверяем правило на 'ненужность'
def is_rule_removable(rule, relations):
    closure = compute_closure(relations.difference({rule}), rule.left)
    return rule.right.issubset(closure)  # проверяем, что правая часть остается в замыкании после удаления


# Вычисляем НМФЗ
def find_irreducible(relations):
    irreducible_set = split_right_part(relations)
    irreducible_set = delete_left_attributes(irreducible_set)
    irreducible_set = delete_rules(irreducible_set)
    return irreducible_set


if __name__ == "__main__":
    relation1 = Relation({"StudentId"}, {"StudentName"})
    relation2 = Relation({"GroupId"}, {"GroupName"})
    relation3 = Relation({"LecturerId"}, {"LecturerName"})
    relation4 = Relation({"CourseId"}, {"CourseName"})
    relation5 = Relation({"StudentId"}, {"GroupId"})
    relation6 = Relation({"GroupId", "CourseId"}, {"LecturerId"})
    relation7 = Relation({"StudentId", "CourseId"}, {"Mark"})
    irr_set = find_irreducible({relation7, relation6, relation5, relation4, relation3, relation2, relation1})
    for relation in irr_set:
        print(relation)
