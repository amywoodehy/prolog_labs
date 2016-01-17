count__(St, N, R):-
	split_string(St, ".?!", "~n~w?!., ", L),
	length(L, N),
	count__(L, R).

count__([], []).
count__([H|T], [N|R]):-
	split_string(H, " ", ",- ", L),
	length(L, N),
	count__(T, R).
