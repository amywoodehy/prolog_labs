% поменять местами максимальный и минимальный элементы в списке

:- module(lab_list, [replace_min_max/2]). 

%% replace_min_max(+List, -Result).
% возвращает список, где максимальный элемент и минимальный элемент поменяты местами 
replace_min_max(List, Result):-
    min_member(Min, List),
    max_member(Max, List),
    format('Min = ~f and Max = ~f', [Min, Max]),
    swap(Max, Min, List, Result).


%% swap(+Value1, +Value2, +List, -Result) is nondet
swap(E1, E2, List, Result):-
    replace(E1, temp__, List, L),
    replace(E2, E1, L, L2),
    replace(temp__, E2, L2, Result).


%% replace(+Value1, +Value2, ?List, ?Result)
replace(_, _, [], []).
replace(O, R, [O|T], [R|T2]):- replace(O, R, T, T2).
replace(O, R, [H|T], [H|T2]):- H \= O, replace(O, R, T, T2).


%%	max_member(-Max, +List) is semidet.
max_member(Max, [H|T]) :-
	max_member_(T, H, Max).

max_member_([], Max, Max).
max_member_([H|T], Max0, Max) :-
	(   H @=< Max0
	->  max_member_(T, Max0, Max)
	;   max_member_(T, H, Max)
	).


%%	min_member(-Min, +List) is semidet.
min_member(Min, [H|T]) :-
	min_member_(T, H, Min).

min_member_([], Min, Min).
min_member_([H|T], Min0, Min) :-
	(   H @>= Min0
	->  min_member_(T, Min0, Min)
	;   min_member_(T, H, Min)
	).
