% найти количество предложений в строке и количество слов в каждом предложении
 

count_words_and_sentences(St, RNum, RList):-
    split_string(St, ".?!", "~n~w?!., ", L),
    length(L, RNum),
    count_words_in_list(L, R),
    reverse(R, RList).


count_words_in_list([], _).
count_words_in_list([H|T], RList):-
    split_string(H, " ", ",- ", L),
    length(L, Num),
    count_words_in_list(T, [Num|RList]).
