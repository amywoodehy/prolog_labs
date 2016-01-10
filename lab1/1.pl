:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % лимит в 8МБ на ОЗУ
:- set_prolog_stack(local,  limit(2 000 000)).  % лимит в 2МБ на ОЗУ в исполняемом скопе

% Задание
% имеется база данных
% 1. о студентах в виде: 
% 	фамилия, курс, факультет, группа, средний балл, имеет задолженности по предметам и 
% 	структура оплаты: бюджет или контракт
% 2. личная информация о студентах: 
% 	фамилия, место проживания, дата рождения, гражданство, семейный статус,
% 3. о факультетах в виде:
% 	наименование факультета, количество кафедр,
% 	количество студентов, количество задолжников по контракту, 
% 	количество задолжников по дисциплинам

% Предположим, что формат бд имеет вид:
% student(last_name, course, faculty, group, gpa, academy_debt[list of strings], debt[int]{0-N}, form{budget/contract})
% personal_information(last_name, address[string], birthdate(year, month, day), nationality, family_status{widow/married/single/relationship})
% faculty(name, ammount_of_departments, ammount_of_students, ammount_of_debtors, ammount_of_academy_deptors)

:- discontiguous student/7.
:- discontiguous personal_information/5.
:- discontiguous faculty/5.

student("Sulaimanov", 3, "ITF", 3.7, [], 0, budget).
student("Ivanov", 2, "ITF", 2.4, [abc, cde], 3000, contract).
student("Shikanami", 4, "WTF", 3.99, [], 0, contract).
student("Kouga", 4, "WTF", 3.99, [], 0, contract).
student("Sobolev", 2, "ITF", 2.3, [abc, cde], 4000, contract).
student("Juravlev", 2, "WTF", 2.5, [abc, cde], 5000, contract).
student("Damn", 2, "ACD", 2.7, [abc, cde], 6000, contract).

personal_information("Sulaimanov", address("Bishkek", "12-34-56"), birthdate(1995, 12, 23), "Kyrgyzstan", single).
personal_information("Shikanami", address("東京", "98-76-54"), birthdate(1995, 11, 12), "Japan", single).
personal_information("Kouga", address("東京", "2233-54"), birthdate(1995, 11, 12), "Japan", single).
personal_information("Ivanov", address("Bishkek", "lolo st., 12"), birthdate(1997, 11, 12), "Kyrgyzstan", single).
personal_information("Sobolev", address("Kant", "coca st., 23"), birthdate(1996, 11, 12), "Kyrgyzstan", single).
personal_information("Juravlev", address("Tokmok", "wasd st., 12"), birthdate(1995, 11, 12), "Kyrgyzstan", single).
personal_information("Damn", address("Kant", "cola st., 123"), birthdate(1994, 11, 12), "Kyrgyzstan", single).

faculty("ACD", 3, 200, 20, 200).
faculty("ITF", 4, 300, 70, 200).
faculty("WTF", 5, 400, 300, 200).


% 7. найти всех студентов иностранцев, которые учатся на факультете, количество кафедр которых меньше заданого
gaijin_department(DepartmentValue, StudentName):-
    faculty(FacultyName, D, _, _, _),
    D @< DepartmentValue,
    student(StudentName, _, FacultyName, _, _, _, _),
    personal_information(StudentName, _, _, Nationality, _),
    Nationality \= "Kyrgyzstan".

% gaijin_department(6, StudentName).
% StudentName = "Shikanami"
% StudentName = "Kouga"


% birthdate_gpa(+Gpa, -Birthdate) is nondet
% 12. Вывести дату рождения студентов, средний бал которых ниже заданного и учатся на факультете с задолжниками менее 50.
birthdate_gpa(Gpa, Birthdate):-
    faculty(FacultyName, _, _, Debtors, _),
    Debtors @< 50,
    student(StudentName, _, FacultyName, G, _, _, _),
    G @< Gpa, 
    personal_information(StudentName, _, Birthdate, _, _).


%% address_debtvalue(+DebtValue, -StudentAddress) is nondet
% 13. Вывести адреса всех студентов, у которых долги за оплаты превышают заданное число
address_debtvalue(DebtValue, StudentAddress):-
    student(StudentName, _, _, _, _, Debt, contract),
    Debt @> DebtValue,
    personal_information(StudentName, StudentAddress, _, _, _).
