max_hp(10).
damage(sword,4).
cost(sword,10).

context(init_tok).
stage(init).

step :- % stage init : i
    stage(init),
    context(init_tok),
    max_hp(N),
    % -o
    retract(stage(init)),
    retract(context(init_tok)),
    retract(max_hp, N),
    assert(health,N),
    assert(treasure,0),
    assert(ndays,0),
    assert(weapon_damage,4),
    assert(context(qui)),
    !.

step :- % global
    context(qui),
    stage(init),
    % -o
    retract(context(qui)),
    retract(stage(init)),
    assert(stage(main)),
    assert(screen(main)),
    !.

step :- % stage main : do/rest
    stage(main),
    interactive(do_rest),
    screen(main),
    % -o
    retract(stage(main)),
    retract(interactive(do_rest)),
    retract(screen(main)),
    %
    assert(stage(rest)),
    assert(screen(rest)),
    !.

step :- % stage main : do/adventure
    stage(main),
    interactive(do_adventure),
    screen(main),
    % -o
    retract(stage(main)),
    retract(interactive(do_adventure)),
    retract(screen(main)),
    %
    assert(stage(adventure)),
    assert(screen(adventure)),
    !.

step :- % stage main : do/shop
    stage(main),
    interactive(do_shop),
    screen(main),
    % -o
    retract(stage(main)),
    retract(interactive(do_shop)),
    retract(screen(main)),
    %
    assert(stage(shop)),
    assert(screen(shop)),
    !.

step :- % stage main : do/quit
    stage(main),
    interactive(do_rest),
    screen(main),
    % -o
    retract(stage(main)),
    retract(interactive(do_rest)),
    retract(screen(main)),
    %
    assert(stage(rest)),
    assert(screen(rest)),
    !.

step :- % interactive main
    stage(main),
    screen(main),
    user_choose("1: rest, 2: adventure, 3: shop, 4:quit", Choice),
    (
	  Choice = 1 -> assert(interactive(do_rest)),
	; Choice = 2 -> assert(interactive(do_adventure)),
        ; Choice = 3 -> assert(interactive(do_shop)),
	; Choice = 4 -> assert(interactive(do_quit))
    ).

step :-
    context(qui),
    stage(main),
    screen(rest),
    % o-
    retract(context(qui)),
    retract(stage(main)),
    retract(screen(rest)),
    %
    assert(screen(rest)),
    assert(stage(rest)).

step :-
    context(qui),
    stage(main),
    screen(shop),
    % o-
    retract(context(qui)),
    retract(stage(main)),
    retract(screen(shop)),
    %
    assert(screen(shop)),
    assert(stage(rest)).

step :-
    context(qui),
    stage(main),
    screen(adventure),
    % o-
    retract(context(qui)),
    retract(stage(main)),
    retract(screen(adventure)),
    %
    assert(screen(adventure)),
    assert(stage(rest)).

step :-
    context(qui),
    stage(main),
    screen(quit),
    % o-
    retract(context(qui)),
    retract(stage(main)),
    retract(screen(quit)),
    %
    quit,
    !.

stage rest = {
  recharge : rest_screen
	* health HP * max_hp Max * recharge_hp Recharge 
	* cplus HP Recharge Max N
	* ndays NDAYS
     -o   health N * ndays (NDAYS + 1).
}

qui * stage rest  -o  stage main * main_screen.

stage shop = {
      leave :   shop_screen  -o  main_screen.
      buy   :   treasure T * cost W C * damage_of W D * weapon_damage _
      	        * subtract T C (some T')
             -o treasure T' * weapon_damage D.
}
#interactive shop.

qui * stage shop * $main_screen  -o  stage main.

stage adventure = {
  init : adventure_screen  -o  spoils z.
}
qui * stage adventure  -o  stage fight_init * fight_screen.

% drop_amount M N means a monster of size M can drop N coins
drop_amount nat nat : bwd.
drop_amount X X. % for now

stage fight_init = {
  init : fight_screen  -o  gen_monster * fight_in_progress.
  gen_a_monster : gen_monster * monster_size Size
    -o monster Size * monster_hp Size.
}
qui * stage fight_init  -o  stage fight * choice.

try_fight : pred.
fight_in_progress : pred.
stage fight_auto = {
  fight/hit :   try_fight * $fight_in_progress * monster_hp MHP * $weapon_damage D
                  * subtract MHP D (some MHP')
  	     -o monster_hp MHP'.
  win :    fight_in_progress * monster_hp MHP * $weapon_damage D * subtract MHP D none
        -o win_screen.
  fight/miss :    try_fight * $fight_in_progress * $monster Size * health HP
                    * subtract HP Size (some HP')
	       -o health HP'.
  die_from_damages :    health z * fight_in_progress
                     -o die_screen.
  fight/die :    try_fight * fight_in_progress * monster Size * health HP
                   * subtract HP Size none
	      -o die_screen.
}

choice : pred.

qui * stage fight_auto * $fight_in_progress  -o  stage fight * choice.
qui * stage fight_auto * $win_screen         -o  stage win.
qui * stage fight_auto * $die_screen         -o  stage die.

stage fight = {
  do_fight : choice * $fight_in_progress  -o  try_fight. 
  do_flee  : choice *  fight_in_progress  -o  flee_screen.
}
#interactive fight.

qui * stage fight * $fight_in_progress  -o  stage fight_auto.
qui * stage fight * $flee_screen        -o  stage flee.

stage flee = {
  % lose spoils
  do/flee :    flee_screen * spoils X * monster _ * monster_hp _
            -o ().
}

qui * stage flee  -o  stage main * main_screen.

go_home_or_continue : pred.
stage win = {
  win : win_screen * monster Size * drop_amount Size Drop  -o  drop Drop.
  collect_spoils : drop X * spoils Y * plus X Y Z  -o  spoils Z * go_home_or_continue.
  go_home :    go_home_or_continue
                 * spoils X * treasure Y * plus X Y Z
	    -o treasure Z * main_screen.
  continue : go_home_or_continue -o fight_screen.
}
#interactive win.

qui * stage win * $main_screen  -o  stage main.
qui * stage win * $fight_screen  -o  stage fight_init.
end : pred.
stage die = {
  quit : die_screen  -o  end.
  restart :    die_screen * monster_hp _
                 * spoils _ * ndays _ * treasure _
                 * weapon_damage _
            -o init_tok.
}
#interactive die.

qui * stage die * end  -o  ().
qui * stage die * $init_tok  -o  stage init.



