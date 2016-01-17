:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space

/* создать переводчик с русского на английский для 
 * существительных и прилагательных, 
 * так что окончания этих слов не имели значения */
% word(Word, MeanCount).
% пусть дано такое слово Word, где значащая часть без окончания равна Mean 
word("большой", 5).
word("окно", 3).
word("неявный", 5).
word("дом", 3).
word("в", 1).
word("маленький", 7).


ru_en("окно", "window").
ru_en("большой", "big").
ru_en("неявный", "implicit").
ru_en("маленький", "little").
ru_en("дом", "home").
ru_en("в", "in").

translate_text(Text, Tran):-
    split_string(Text," ", ",.-", L),
    tt(L, Tran).

tt([], []).
tt([H|T], [R|O]):-
    translate(H, R),
    tt(T, O).

translate(Word, Tran):-
    sub_string(Word, _, L, _, Sub),
    word(MW, L2),
    sub_string(MW, _, L, _, Sub),
    L = L2,
    ru_en(MW, Tran).

/** <examples> Your example queries go here, e.g.
?- translate_text("маленькое окно в большом доме", X).
*/
