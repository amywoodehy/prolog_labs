% построить график косинусоиды

:- use_module(library('plot/plotter')).
:- use_module(library(autowin)).

plot_function :-
	plot_function(X:cos(X)).

plot_function(Template) :-
	From is -2*pi,
	To is 2*pi,
	PlotStep is To/100,
	Step is pi/4,
	new(W, auto_sized_picture('Plotting')),
	send(W, display, new(P, plotter)),
	send(P, axis, new(X, plot_axis(x, From, To, Step, 700))),
	send(P, axis, plot_axis(y, -1.3, 1.3, @default, 300)),
	send(X, format, '%.2f'),
	send(P, graph, new(G, plot_graph)),
	plot_function(From, To, PlotStep, Template, G),
	send(W, open).

plot_function(X, To, _, _, _) :-
	X >= To, !.
plot_function(X, To, Step, Template, G) :-
	copy_term(Template, X:Func),
	Y is Func,
	send(G, append, X, Y),
	NewX is X + Step,
	plot_function(NewX, To, Step, Template, G).