assert(max_hp(10)).
assert(damage(sword,4)).
assert(cost(sword,10)).

assert(init_tok),

assert(stage(init)).

%stage init = {
stagestep :-
  stage(init),
  \+ qui,
  init_tok,
  max_hp(N),
  !,
  assert(rule_name("init", "i")),
  % o-
  retract(init_tok),
  retract(max_hp(N),
  %
  assert(health(N)),
  assert(treasure(z)),
  assert(ndays(z),
  assert(weapon_damage(4)).  

stagestep :-
  stage(init),
  \+ qui,
  !,
  assert(rule_name("init", "final")),
  assert(qui).


%
step :-
    % guard
    qui,
    stage(init),
    % -o
    retract(qui),
    retract(stage(init)),
    %
    assert(stage(main)),
    assert(main_screen),
    !.


%% stage main = {
%%   do/rest : main_screen       -o  rest_screen.
%%   do/adventure : main_screen  -o  adventure_screen.
%%   do/shop : main_screen       -o  shop_screen.
%%   do/quit : main_screen       -o  quit.
%% }
%% #interactive main.

stagestep :-
    stage(main),
    \+ qui,
    \+ received(_),
    !,
    assert(rule_name("main", "interact")),
    interact.

stagestep :-
  % do/rest %
    stage(main),
    \+ qui,
    received(do_rest),
    !,
    % o-
    assert(rule_name("main", "do/rest")),
    retract(main_screen),
    retract(received(_)),
    %
    assert(rest_screen).

stagestep :-
  % do/adventure %
    stage(main),
    \+ qui,
    received(do_adventure),
    !,
    % o-
    assert(rule_name("main", "do/adventure")),
    retract(main_screen),
    retract(received(_)),
    %
    assert(adventure_screen).

stagestep :-
  % do/shop %
    stage(main),
    \+ qui,
    received(do_shop),
    !,
    % o-
    assert(rule_name("main", "do/shop")),
    retract(main_screen),
    retract(received(_)),
    %
    assert(shop_screen).

stagestep :-
  % do/quit %
    stage(main),
    \+ qui,
    received(do_quit),
    !,
    % o-
    assert(rule_name("main", "do/quit")),
    retract(main_screen),
    retract(received(_)),
    %
    quit.

stagestep :-
  stage(main),
  \+ qui,
  !,
  assert(rule_name("main", "final")),
  assert(qui).


%% qui * stage main * $rest_screen       -o  stage rest.
%% qui * stage main * $shop_screen       -o  stage shop.
%% qui * stage main * $adventure_screen  -o  stage adventure.
%% qui * stage main * quit               -o  ().

step :-
    qui,
    stage(main),
    rest_screen,
    !,
    % o-
    assert(rule_name("-", "-")),
    retract(qui),
    retract(main),
    retract(rest_screen),
    %
    assert(rest_screen),
    assert(stage(rest)).

step :-
    qui,
    stage(main),
    shop_screen,
    !,
    % o-
    assert(rule_name("-", "-")),
    retract(qui),
    retract(main),
    retract(shop_screen),
    %
    assert(shop_screen),
    assert(stage(shop)).

step :-
    qui,
    stage(main),
    adventure_screen,
    !,
    % o-
    assert(rule_name("-", "-")),
    retract(qui),
    retract(main),
    retract(adventure_screen),
    %
    assert(adventure_screen),
    assert(stage(adventure)).

step :-
    qui,
    stage(main),
    quit,
    !,
    % o-
    assert(rule_name("-", "-")),
    retract(qui),
    retract(main),
    retract(quit),
    %
    nothing.


%% stage rest = {
%%   recharge : rest_screen
%% 	* health HP * max_hp Max * recharge_hp Recharge 
%% 	* cplus HP Recharge Max N
%% 	* ndays NDAYS
%%      -o   health N * ndays (NDAYS + 1).
%% }

stagestep :-
    stage(rest),
    \+ qui,
    rest_screen,
    health(HP),
    max_hp(Max),
    recharge_hp(Recharge),
    cplus(HP,Recharge,Max,N),
    ndays(NDAYS),
    !,
    assert(rule_name("rest", "recharge")),
    % -o
    retract(rest_screen),
    retract(health(HP)),
    retract(max_hp(Max)),
    retract(recharge_hp(Recharge)),
    retract(cplus(HP,Recharge,Max,N)),
    retract(ndays(NDAYS)),
    %
    assert(health(N)),
    assert(ndays((NDAYS + 1))).

stagestep :-
    stage(rest),
    \+ qui,
    !,
    assert(rule_name("rest", "final")),
    assert(qui).


stage rest = {
  % recharge %
rest_screen
	* health HP * max_hp Max * recharge_hp Recharge 
	* cplus HP Recharge Max N
	* ndays NDAYS
     -o   health N * ndays (NDAYS + 1).
}

qui,
stage(rest ),
% o-
retract(qui),
retract(stage(rest )),

%
stage(main ),
assert(context(main_screen)).

stage shop = {
      % leave %
context(shop_screen),
% o-
retract(context(shop_screen)),

%
assert(context(main_screen)).
      % buy %
treasure T * cost W C * damage_of W D * weapon_damage _
      	        * subtract T C (some T')
             -o treasure T' * weapon_damage D.
}
#interactive shop.

qui,
stage(shop ),
context(main_screen),
% o-
retract(qui),
retract(stage(shop )),
retract(context(main_screen)),

%
assert(context(main_screen)),
assert(stage(main )).

stage adventure = {
  % init %
context(adventure_screen),
% o-
retract(context(adventure_screen)),

%
assert(spoils(z )).
}
qui,
stage(adventure ),
% o-
retract(qui),
retract(stage(adventure )),

%
stage(fight_init ),
assert(context(fight_screen)).

% drop_amount M N means a monster of size M can drop N coins
drop_amount nat nat : bwd.
drop_amount X X. % for now

stage fight_init = {
  % init %
context(fight_screen),
% o-
retract(context(fight_screen)),

%
context(gen_monster),
assert(context(fight_in_progress)).
  % gen_a_monster %
context(gen_monster),
monster_size(Size ),
% o-
retract(context(gen_monster)),
retract(monster_size(Size )),

%
monster(Size ),
assert(monster_hp(Size )).
}
qui,
stage(fight_init ),
% o-
retract(qui),
retract(stage(fight_init )),

%
stage(fight ),
assert(context(choice)).

try_fight : pred.
fight_in_progress : pred.
stage fight_auto = {
  % fight/hit %
try_fight * $fight_in_progress * monster_hp MHP * $weapon_damage D
                  * subtract MHP D (some MHP')
  	     -o monster_hp MHP'.
  % win %
context(fight_in_progress),
monster_hp(MHP ),
weapon_damage(D ),
subtract(MHP D none ),
% o-
retract(context(fight_in_progress)),
retract(monster_hp(MHP )),
retract(weapon_damage(D )),
retract(subtract(MHP D none )),

%
assert(weapon_damage(D )),
assert(context(win_screen)).
  % fight/miss %
try_fight * $fight_in_progress * $monster Size * health HP
                    * subtract HP Size (some HP')
	       -o health HP'.
  % die_from_damages %
health(z ),
context(fight_in_progress),
% o-
retract(health(z )),
retract(context(fight_in_progress)),

%
assert(context(die_screen)).
  % fight/die %
context(try_fight),
context(fight_in_progress),
monster(Size ),
health(HP ),
subtract(HP Size none ),
% o-
retract(context(try_fight)),
retract(context(fight_in_progress)),
retract(monster(Size )),
retract(health(HP )),
retract(subtract(HP Size none )),

%
assert(context(die_screen)).
}

choice : pred.

qui,
stage(fight_auto ),
context(fight_in_progress),
% o-
retract(qui),
retract(stage(fight_auto )),
retract(context(fight_in_progress)),

%
assert(context(fight_in_progress)),
stage(fight ),
assert(context(choice)).
qui,
stage(fight_auto ),
context(win_screen),
% o-
retract(qui),
retract(stage(fight_auto )),
retract(context(win_screen)),

%
assert(context(win_screen)),
assert(stage(win )).
qui,
stage(fight_auto ),
context(die_screen),
% o-
retract(qui),
retract(stage(fight_auto )),
retract(context(die_screen)),

%
assert(context(die_screen)),
assert(stage(die )).

stage fight = {
  % do_fight %
context(choice),
context(fight_in_progress),
% o-
retract(context(choice)),
retract(context(fight_in_progress)),

%
assert(context(fight_in_progress)),
assert(context(try_fight)). 
  % do_flee %
context(choice),
context(fight_in_progress),
% o-
retract(context(choice)),
retract(context(fight_in_progress)),

%
assert(context(flee_screen)).
}
#interactive fight.

qui,
stage(fight ),
context(fight_in_progress),
% o-
retract(qui),
retract(stage(fight )),
retract(context(fight_in_progress)),

%
assert(context(fight_in_progress)),
assert(stage(fight_auto )).
qui,
stage(fight ),
context(flee_screen),
% o-
retract(qui),
retract(stage(fight )),
retract(context(flee_screen)),

%
assert(context(flee_screen)),
assert(stage(flee )).

stage flee = {
  % lose spoils
  % do/flee %
flee_screen * spoils X * monster _ * monster_hp _
            -o ().
}

qui,
stage(flee ),
% o-
retract(qui),
retract(stage(flee )),

%
stage(main ),
assert(context(main_screen)).

go_home_or_continue : pred.
stage win = {
  % win %
context(win_screen),
monster(Size ),
drop_amount(Size Drop ),
% o-
retract(context(win_screen)),
retract(monster(Size )),
retract(drop_amount(Size Drop )),

%
assert(drop(Drop )).
  % collect_spoils %
drop(X ),
spoils(Y ),
plus(X Y Z ),
% o-
retract(drop(X )),
retract(spoils(Y )),
retract(plus(X Y Z )),

%
spoils(Z ),
assert(context(go_home_or_continue)).
  % go_home %
context(go_home_or_continue),
spoils(X ),
treasure(Y ),
plus(X Y Z ),
% o-
retract(context(go_home_or_continue)),
retract(spoils(X )),
retract(treasure(Y )),
retract(plus(X Y Z )),

%
treasure(Z ),
assert(context(main_screen)).
  % continue %
context(go_home_or_continue),
% o-
retract(context(go_home_or_continue)),

%
assert(context(fight_screen)).
}
#interactive win.

qui,
stage(win ),
context(main_screen),
% o-
retract(qui),
retract(stage(win )),
retract(context(main_screen)),

%
assert(context(main_screen)),
assert(stage(main )).
qui,
stage(win ),
context(fight_screen),
% o-
retract(qui),
retract(stage(win )),
retract(context(fight_screen)),

%
assert(context(fight_screen)),
assert(stage(fight_init )).
end : pred.
stage die = {
  % quit %
context(die_screen),
% o-
retract(context(die_screen)),

%
assert(context(end)).
  % restart %
context(die_screen),
monster_hp(_),
spoils(_),
ndays(_),
treasure(_),
weapon_damage(_),
% o-
retract(context(die_screen)),
retract(monster_hp(_)),
retract(spoils(_)),
retract(ndays(_)),
retract(treasure(_)),
retract(weapon_damage(_)),

%
assert(context(init_tok)).
}
#interactive die.

qui * stage die * end  -o  ().
qui,
stage(die ),
context(init_tok),
% o-
retract(qui),
retract(stage(die )),
retract(context(init_tok)),

%
assert(context(init_tok)),
assert(stage(init )).




step :-
    substep.

