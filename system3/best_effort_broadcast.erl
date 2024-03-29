% Paul Vidal (pv14)

-module(best_effort_broadcast).
-export([start/1]).

start(App) ->
  receive
    {bind, Pl, N, Pls} ->
      App ! {bind, N, self()},
      next(App, Pl, Pls)
  end.

next(App, Pl, Pls) ->
  receive
    {broadcast, M} ->
      [Pl ! {pl_send, Pl_send, M} || Pl_send <- Pls];

    {pl_deliver, M} ->
      App ! M
  end,
  next(App, Pl, Pls).
