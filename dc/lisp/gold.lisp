
					; -*-Lisp-*-
(fact `(max_hp 10))
(fact `(damage sword 4))
(fact `(cost sword 10))


(fact `(init_tok))

 ;;; stage [init]
(defparameter init_rules nil)
(stagerule init i
	   (match `(init_tok) `(max_hp N))
	   (retract `(init_tok))
	   (retract `(max_hp N))
	   (assert `(health N))
	   (assert `(treasure z))
	   (assert `(ndays z))
	   (assert `(weapon_damage 4)))
 ;;; end stage [init]

 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub1
	   (match `(qui) `(stage init))
	   (retract `(qui))
	   (retract `(stage init))
	   (assert `(stage main))
	   (assert `(main_screen))
	   )
 ;;; end stage [top]




 ;;; stage [main]
(defparameter main_rules nil)
(stagerule main do/rest
	   (match `(main_screen))
	   (retract `(main_screen))
	   (assert `(rest_screen)))
(stagerule main do/adventure
	   (match `(main_screen))
	   (retract `(main_screen))
	   (assert `(adventure_screen)))
(stagerule main do/shop
	   (match `(main_screen))
	   (retract `(main_screen))
	   (assert `(shop_screen)))
(stagerule main do/quit
	   (match `(main_screen))
	   (retract `(main_screen))
	   (assert `(quit)))
 ;;; end stage [main]
#(fact `(interactive main))



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub2
	   (match `(qui) `(stage main) `(rest_screen))
	   (retract `(qui))
	   (retract `(stage main))
	   (retract `(rest_screen))
	   (assert `(rest_screen))
	   (assert `(stage rest))
	   )
 ;;; end stage [top]



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub3
	   (match `(qui) `(stage main) `(shop_screen))
	   (retract `(qui))
	   (retract `(stage main))
	   (retract `(shop_screen))
	   (assert `(shop_screen))
	   (assert `(stage shop))
	   )
 ;;; end stage [top]



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub4
	   (match `(qui) `(stage main) `(adventure_screen))
	   (retract `(qui))
	   (retract `(stage main))
	   (retract `(adventure_screen))
	   (assert `(adventure_screen))
	   (assert `(stage adventure))
	   )
 ;;; end stage [top]



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub5
	   (match `(qui) `(stage main) `(quit))
	   (retract `(qui))
	   (retract `(stage main))
	   (retract `(quit))
	   (assert `(empty))
	   )
 ;;; end stage [top]




 ;;; stage [rest]
(defparameter rest_rules nil)
(stagerule rest recharge
	   (match `(rest_screen) `(health HP) `(max_hp Max) `(recharge_hp Recharge) `(cplus HP,Recharge,Max,N) `(ndays NDAYS))
	   (retract `(rest_screen))
	   (retract `(health HP))
	   (retract `(max_hp Max))
	   (retract `(recharge_hp Recharge))
	   (retract `(cplus HP,Recharge,Max,N))
	   (retract `(ndays NDAYS))
	   (assert `(health N))
	   (assert `(ndays(+ NDAYS 1))))
 ;;; end stage [rest]

 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub6
	   (match `(qui) `(stage rest))
	   (retract `(qui))
	   (retract `(stage rest))
	   (assert `(stage main))
	   (assert `(main_screen))
	   )
 ;;; end stage [top]




 ;;; stage [shop]
(defparameter shop_rules nil)
(stagerule shop leave
	   (match `(shop_screen))
	   (retract `(shop_screen))
	   (assert `(main_screen)))
(stagerule shop buy
	   (match `(treasure T) `(cost W,C) `(damage_of W,D) `(weapon_damage _) `(subtract T,C,(some T')))
	   (retract `(treasure T))
	   (retract `(cost W,C))
	   (retract `(damage_of W,D))
	   (retract `(weapon_damage _))
	   (retract `(subtract T,C,(some T')))
	   (assert `(treasure T'))
	   (assert `(weapon_damage D)))
 ;;; end stage [shop]
#(fact `(interactive shop))



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub7
	   (match `(qui) `(stage shop) `(main_screen))
	   (retract `(qui))
	   (retract `(stage shop))
	   (retract `(main_screen))
	   (assert `(main_screen))
	   (assert `(stage main))
	   )
 ;;; end stage [top]




 ;;; stage [adventure]
(defparameter adventure_rules nil)
(stagerule adventure init
	   (match `(adventure_screen))
	   (retract `(adventure_screen))
	   (assert `(spoils z)))
 ;;; end stage [adventure]

 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub8
	   (match `(qui) `(stage adventure))
	   (retract `(qui))
	   (retract `(stage adventure))
	   (assert `(stage fight_init))
	   (assert `(fight_screen))
	   )
 ;;; end stage [top]



(defbwd(drop_amount nat nat) bwd)
(fact `(drop_amount X X))

 ;;; stage [fight_init]
(defparameter fight_init_rules nil)
(stagerule fight_init init
	   (match `(fight_screen))
	   (retract `(fight_screen))
	   (assert `(gen_monster))
	   (assert `(fight_in_progress)))
(stagerule fight_init gen_a_monster
	   (match `(gen_monster) `(monster_size Size))
	   (retract `(gen_monster))
	   (retract `(monster_size Size))
	   (assert `(monster Size))
	   (assert `(monster_hp Size)))
 ;;; end stage [fight_init]

 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub9
	   (match `(qui) `(stage fight_init))
	   (retract `(qui))
	   (retract `(stage fight_init))
	   (assert `(stage fight))
	   (assert `(choice))
	   )
 ;;; end stage [top]



(defpred(try_fight) pred)
(defpred(fight_in_progress) pred)

 ;;; stage [fight_auto]
(defparameter fight_auto_rules nil)
(stagerule fight_auto fight/hit
	   (match `(try_fight) `(fight_in_progress) `(monster_hp MHP) `(weapon_damage D) `(subtract MHP,D,(some MHP')))
	   (retract `(try_fight))
	   (retract `(fight_in_progress))
	   (retract `(monster_hp MHP))
	   (retract `(weapon_damage D))
	   (retract `(subtract MHP,D,(some MHP')))
	   (assert `(fight_in_progress))
	   (assert `(weapon_damage D))
	   (assert `(monster_hp MHP')))
(stagerule fight_auto win
	   (match `(fight_in_progress) `(monster_hp MHP) `(weapon_damage D) `(subtract MHP,D,none))
	   (retract `(fight_in_progress))
	   (retract `(monster_hp MHP))
	   (retract `(weapon_damage D))
	   (retract `(subtract MHP,D,none))
	   (assert `(weapon_damage D))
	   (assert `(win_screen)))
(stagerule fight_auto fight/miss
	   (match `(try_fight) `(fight_in_progress) `(monster Size) `(health HP) `(subtract HP,Size,(some HP')))
	   (retract `(try_fight))
	   (retract `(fight_in_progress))
	   (retract `(monster Size))
	   (retract `(health HP))
	   (retract `(subtract HP,Size,(some HP')))
	   (assert `(fight_in_progress))
	   (assert `(monster Size))
	   (assert `(health HP')))
(stagerule fight_auto die_from_damages
	   (match `(health z) `(fight_in_progress))
	   (retract `(health z))
	   (retract `(fight_in_progress))
	   (assert `(die_screen)))
(stagerule fight_auto fight/die
	   (match `(try_fight) `(fight_in_progress) `(monster Size) `(health HP) `(subtract HP,Size,none))
	   (retract `(try_fight))
	   (retract `(fight_in_progress))
	   (retract `(monster Size))
	   (retract `(health HP))
	   (retract `(subtract HP,Size,none))
	   (assert `(die_screen)))
 ;;; end stage [fight_auto]
(defpred(choice) pred)


 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub10
	   (match `(qui) `(stage fight_auto) `(fight_in_progress))
	   (retract `(qui))
	   (retract `(stage fight_auto))
	   (retract `(fight_in_progress))
	   (assert `(fight_in_progress))
	   (assert `(stage fight))
	   (assert `(choice))
	   )
 ;;; end stage [top]



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub11
	   (match `(qui) `(stage fight_auto) `(win_screen))
	   (retract `(qui))
	   (retract `(stage fight_auto))
	   (retract `(win_screen))
	   (assert `(win_screen))
	   (assert `(stage win))
	   )
 ;;; end stage [top]



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub12
	   (match `(qui) `(stage fight_auto) `(die_screen))
	   (retract `(qui))
	   (retract `(stage fight_auto))
	   (retract `(die_screen))
	   (assert `(die_screen))
	   (assert `(stage die))
	   )
 ;;; end stage [top]




 ;;; stage [fight]
(defparameter fight_rules nil)
(stagerule fight do_fight
	   (match `(choice) `(fight_in_progress))
	   (retract `(choice))
	   (retract `(fight_in_progress))
	   (assert `(fight_in_progress))
	   (assert `(try_fight)))
(stagerule fight do_flee
	   (match `(choice) `(fight_in_progress))
	   (retract `(choice))
	   (retract `(fight_in_progress))
	   (assert `(flee_screen)))
 ;;; end stage [fight]
#(fact `(interactive fight))



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub13
	   (match `(qui) `(stage fight) `(fight_in_progress))
	   (retract `(qui))
	   (retract `(stage fight))
	   (retract `(fight_in_progress))
	   (assert `(fight_in_progress))
	   (assert `(stage fight_auto))
	   )
 ;;; end stage [top]



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub14
	   (match `(qui) `(stage fight) `(flee_screen))
	   (retract `(qui))
	   (retract `(stage fight))
	   (retract `(flee_screen))
	   (assert `(flee_screen))
	   (assert `(stage flee))
	   )
 ;;; end stage [top]




 ;;; stage [flee]
(defparameter flee_rules nil)
(stagerule flee do/flee
	   (match `(flee_screen) `(spoils X) `(monster _) `(monster_hp _))
	   (retract `(flee_screen))
	   (retract `(spoils X))
	   (retract `(monster _))
	   (retract `(monster_hp _))
	   (assert `(empty)))
 ;;; end stage [flee]

 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub15
	   (match `(qui) `(stage flee))
	   (retract `(qui))
	   (retract `(stage flee))
	   (assert `(stage main))
	   (assert `(main_screen))
	   )
 ;;; end stage [top]



(defpred(go_home_or_continue) pred)

 ;;; stage [win]
(defparameter win_rules nil)
(stagerule win win
	   (match `(win_screen) `(monster Size) `(drop_amount Size,Drop))
	   (retract `(win_screen))
	   (retract `(monster Size))
	   (retract `(drop_amount Size,Drop))
	   (assert `(drop Drop)))
(stagerule win collect_spoils
	   (match `(drop X) `(spoils Y) `(plus X,Y,Z))
	   (retract `(drop X))
	   (retract `(spoils Y))
	   (retract `(plus X,Y,Z))
	   (assert `(spoils Z))
	   (assert `(go_home_or_continue)))
(stagerule win go_home
	   (match `(go_home_or_continue) `(spoils X) `(treasure Y) `(plus X,Y,Z))
	   (retract `(go_home_or_continue))
	   (retract `(spoils X))
	   (retract `(treasure Y))
	   (retract `(plus X,Y,Z))
	   (assert `(treasure Z))
	   (assert `(main_screen)))
(stagerule win continue
	   (match `(go_home_or_continue))
	   (retract `(go_home_or_continue))
	   (assert `(fight_screen)))
 ;;; end stage [win]
#(fact `(interactive win))



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub16
	   (match `(qui) `(stage win) `(main_screen))
	   (retract `(qui))
	   (retract `(stage win))
	   (retract `(main_screen))
	   (assert `(main_screen))
	   (assert `(stage main))
	   )
 ;;; end stage [top]



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub17
	   (match `(qui) `(stage win) `(fight_screen))
	   (retract `(qui))
	   (retract `(stage win))
	   (retract `(fight_screen))
	   (assert `(fight_screen))
	   (assert `(stage fight_init))
	   )
 ;;; end stage [top]


(defpred(end) pred)

 ;;; stage [die]
(defparameter die_rules nil)
(stagerule die quit
	   (match `(die_screen))
	   (retract `(die_screen))
	   (assert `(end)))
(stagerule die restart
	   (match `(die_screen) `(monster_hp _) `(spoils _) `(ndays _) `(treasure _) `(weapon_damage _))
	   (retract `(die_screen))
	   (retract `(monster_hp _))
	   (retract `(spoils _))
	   (retract `(ndays _))
	   (retract `(treasure _))
	   (retract `(weapon_damage _))
	   (assert `(init_tok)))
 ;;; end stage [die]
#(fact `(interactive die))



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub18
	   (match `(qui) `(stage die) `(end))
	   (retract `(qui))
	   (retract `(stage die))
	   (retract `(end))
	   (assert `(empty))
	   )
 ;;; end stage [top]



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub19
	   (match `(qui) `(stage die) `(init_tok))
	   (retract `(qui))
	   (retract `(stage die))
	   (retract `(init_tok))
	   (assert `(init_tok))
	   (assert `(stage init))
	   )
 ;;; end stage [top]






















