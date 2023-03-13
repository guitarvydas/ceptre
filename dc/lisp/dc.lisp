
					; -*-Lisp-*-
(clear-fb) ;;m
(defparameter top_rules nil) ;;m
(assert `(max_hp 10)) ;;m max_hp(10).
(assert `(damage sword 4)) ;;m damage(sword,4).
(assert `(cost sword 10)) ;;m cost(sword,10).


(assert `(init_tok)) ;;m context init_ctx = {(fact init_tok })


 ;;; stage [init]
(defparameter init_rules nil)

(defun [init]_[i]()
  (cond((match-unless? `((layer "stagename") (init_tok)(max_hp N)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[i]"))
	(retract `(init_tok))
	(retract `(max_hp N))(assert `(health N))
	(assert `(treasure z))
	(assert `(ndays z))
	(assert `(weapon_damage 4))
	t)
       (t nil)))
(push init_i init_rules)
;;; end stage [init]

 ;;; stage [top]
; --deleted--

(defun [top]_[topsub1]()
  (cond((match-unless? `((layer "stagename") (qui)(stage init)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub1]"))
	(retract `(qui))
	(retract `(stage init))
	(assert `(stage main))
	(assert `(main_screen))

	t)
       (t nil)))
(push top_topsub1 top_rules)
;;; end stage [top]




 ;;; stage [main]
(defparameter main_rules nil)

(defun [main]_[do/rest]()
  (cond((match-unless? `((layer "stagename") (main_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[do/rest]"))
	(retract `(main_screen))(assert `(rest_screen))
	t)
       (t nil)))
(push main_do/rest main_rules)

(defun [main]_[do/adventure]()
  (cond((match-unless? `((layer "stagename") (main_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[do/adventure]"))
	(retract `(main_screen))(assert `(adventure_screen))
	t)
       (t nil)))
(push main_do/adventure main_rules)

(defun [main]_[do/shop]()
  (cond((match-unless? `((layer "stagename") (main_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[do/shop]"))
	(retract `(main_screen))(assert `(shop_screen))
	t)
       (t nil)))
(push main_do/shop main_rules)

(defun [main]_[do/quit]()
  (cond((match-unless? `((layer "stagename") (main_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[do/quit]"))
	(retract `(main_screen))(assert `(quit))
	t)
       (t nil)))
(push main_do/quit main_rules)
;;; end stage [main]
#interactive(main).



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub2]()
  (cond((match-unless? `((layer "stagename") (qui)(stage main)(rest_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub2]"))
	(retract `(qui))
	(retract `(stage main))
	(retract `(rest_screen))
	(assert `(rest_screen))
	(assert `(stage rest))

	t)
       (t nil)))
(push top_topsub2 top_rules)
;;; end stage [top]



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub3]()
  (cond((match-unless? `((layer "stagename") (qui)(stage main)(shop_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub3]"))
	(retract `(qui))
	(retract `(stage main))
	(retract `(shop_screen))
	(assert `(shop_screen))
	(assert `(stage shop))

	t)
       (t nil)))
(push top_topsub3 top_rules)
;;; end stage [top]



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub4]()
  (cond((match-unless? `((layer "stagename") (qui)(stage main)(adventure_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub4]"))
	(retract `(qui))
	(retract `(stage main))
	(retract `(adventure_screen))
	(assert `(adventure_screen))
	(assert `(stage adventure))

	t)
       (t nil)))
(push top_topsub4 top_rules)
;;; end stage [top]



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub5]()
  (cond((match-unless? `((layer "stagename") (qui)(stage main)(quit)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub5]"))
	(retract `(qui))
	(retract `(stage main))
	(retract `(quit))
	(assert `(empty))

	t)
       (t nil)))
(push top_topsub5 top_rules)
;;; end stage [top]




 ;;; stage [rest]
(defparameter rest_rules nil)

(defun [rest]_[recharge]()
  (cond((match-unless? `((layer "stagename") (rest_screen)(health HP)(max_hp Max)(recharge_hp Recharge)(cplus HP,Recharge,Max,N)(ndays NDAYS)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[recharge]"))
	(retract `(rest_screen))
	(retract `(health HP))
	(retract `(max_hp Max))
	(retract `(recharge_hp Recharge))
	(retract `(cplus HP,Recharge,Max,N))
	(retract `(ndays NDAYS))(assert `(health N))
	(assert `(ndays(+ NDAYS 1)))
	t)
       (t nil)))
(push rest_recharge rest_rules)
;;; end stage [rest]

 ;;; stage [top]
; --deleted--

(defun [top]_[topsub6]()
  (cond((match-unless? `((layer "stagename") (qui)(stage rest)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub6]"))
	(retract `(qui))
	(retract `(stage rest))
	(assert `(stage main))
	(assert `(main_screen))

	t)
       (t nil)))
(push top_topsub6 top_rules)
;;; end stage [top]




 ;;; stage [shop]
(defparameter shop_rules nil)

(defun [shop]_[leave]()
  (cond((match-unless? `((layer "stagename") (shop_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[leave]"))
	(retract `(shop_screen))(assert `(main_screen))
	t)
       (t nil)))
(push shop_leave shop_rules)

(defun [shop]_[buy]()
  (cond((match-unless? `((layer "stagename") (treasure T)(cost W,C)(damage_of W,D)(weapon_damage _)(subtract T,C,(some T_))) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[buy]"))
	(retract `(treasure T))
	(retract `(cost W,C))
	(retract `(damage_of W,D))
	(retract `(weapon_damage _))
	(retract `(subtract T,C,(some T_)))(assert `(treasure T_))
	(assert `(weapon_damage D))
	t)
       (t nil)))
(push shop_buy shop_rules)
;;; end stage [shop]
#interactive(shop).



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub7]()
  (cond((match-unless? `((layer "stagename") (qui)(stage shop)(main_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub7]"))
	(retract `(qui))
	(retract `(stage shop))
	(retract `(main_screen))
	(assert `(main_screen))
	(assert `(stage main))

	t)
       (t nil)))
(push top_topsub7 top_rules)
;;; end stage [top]




 ;;; stage [adventure]
(defparameter adventure_rules nil)

(defun [adventure]_[init]()
  (cond((match-unless? `((layer "stagename") (adventure_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[init]"))
	(retract `(adventure_screen))(assert `(spoils z))
	t)
       (t nil)))
(push adventure_init adventure_rules)
;;; end stage [adventure]

 ;;; stage [top]
; --deleted--

(defun [top]_[topsub8]()
  (cond((match-unless? `((layer "stagename") (qui)(stage adventure)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub8]"))
	(retract `(qui))
	(retract `(stage adventure))
	(assert `(stage fight_init))
	(assert `(fight_screen))

	t)
       (t nil)))
(push top_topsub8 top_rules)
;;; end stage [top]



(defbwd(drop_amount nat nat) bwd)
drop_amount(X,X).

 ;;; stage [fight_init]
(defparameter fight_init_rules nil)

(defun [fight_init]_[init]()
  (cond((match-unless? `((layer "stagename") (fight_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[init]"))
	(retract `(fight_screen))(assert `(gen_monster))
	(assert `(fight_in_progress))
	t)
       (t nil)))
(push fight_init_init fight_init_rules)

(defun [fight_init]_[gen_a_monster]()
  (cond((match-unless? `((layer "stagename") (gen_monster)(monster_size Size)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[gen_a_monster]"))
	(retract `(gen_monster))
	(retract `(monster_size Size))(assert `(monster Size))
	(assert `(monster_hp Size))
	t)
       (t nil)))
(push fight_init_gen_a_monster fight_init_rules)
;;; end stage [fight_init]

 ;;; stage [top]
; --deleted--

(defun [top]_[topsub9]()
  (cond((match-unless? `((layer "stagename") (qui)(stage fight_init)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub9]"))
	(retract `(qui))
	(retract `(stage fight_init))
	(assert `(stage fight))
	(assert `(choice))

	t)
       (t nil)))
(push top_topsub9 top_rules)
;;; end stage [top]



(defpred(try_fight) pred)
(defpred(fight_in_progress) pred)

 ;;; stage [fight_auto]
(defparameter fight_auto_rules nil)

(defun [fight_auto]_[fight/hit]()
  (cond((match-unless? `((layer "stagename") (try_fight)(fight_in_progress)(monster_hp MHP)(weapon_damage D)(subtract MHP,D,(some MHP_))) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[fight/hit]"))
	(retract `(try_fight))
	(retract `(fight_in_progress))
	(retract `(monster_hp MHP))
	(retract `(weapon_damage D))
	(retract `(subtract MHP,D,(some MHP_)))(assert `(fight_in_progress))
	(assert `(weapon_damage D))
	(assert `(monster_hp MHP_))
	t)
       (t nil)))
(push fight_auto_fight/hit fight_auto_rules)

(defun [fight_auto]_[win]()
  (cond((match-unless? `((layer "stagename") (fight_in_progress)(monster_hp MHP)(weapon_damage D)(subtract MHP,D,none)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[win]"))
	(retract `(fight_in_progress))
	(retract `(monster_hp MHP))
	(retract `(weapon_damage D))
	(retract `(subtract MHP,D,none))(assert `(weapon_damage D))
	(assert `(win_screen))
	t)
       (t nil)))
(push fight_auto_win fight_auto_rules)

(defun [fight_auto]_[fight/miss]()
  (cond((match-unless? `((layer "stagename") (try_fight)(fight_in_progress)(monster Size)(health HP)(subtract HP,Size,(some HP_))) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[fight/miss]"))
	(retract `(try_fight))
	(retract `(fight_in_progress))
	(retract `(monster Size))
	(retract `(health HP))
	(retract `(subtract HP,Size,(some HP_)))(assert `(fight_in_progress))
	(assert `(monster Size))
	(assert `(health HP_))
	t)
       (t nil)))
(push fight_auto_fight/miss fight_auto_rules)

(defun [fight_auto]_[die_from_damages]()
  (cond((match-unless? `((layer "stagename") (health z)(fight_in_progress)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[die_from_damages]"))
	(retract `(health z))
	(retract `(fight_in_progress))(assert `(die_screen))
	t)
       (t nil)))
(push fight_auto_die_from_damages fight_auto_rules)

(defun [fight_auto]_[fight/die]()
  (cond((match-unless? `((layer "stagename") (try_fight)(fight_in_progress)(monster Size)(health HP)(subtract HP,Size,none)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[fight/die]"))
	(retract `(try_fight))
	(retract `(fight_in_progress))
	(retract `(monster Size))
	(retract `(health HP))
	(retract `(subtract HP,Size,none))(assert `(die_screen))
	t)
       (t nil)))
(push fight_auto_fight/die fight_auto_rules)
;;; end stage [fight_auto]
(defpred(choice) pred)


 ;;; stage [top]
; --deleted--

(defun [top]_[topsub10]()
  (cond((match-unless? `((layer "stagename") (qui)(stage fight_auto)(fight_in_progress)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub10]"))
	(retract `(qui))
	(retract `(stage fight_auto))
	(retract `(fight_in_progress))
	(assert `(fight_in_progress))
	(assert `(stage fight))
	(assert `(choice))

	t)
       (t nil)))
(push top_topsub10 top_rules)
;;; end stage [top]



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub11]()
  (cond((match-unless? `((layer "stagename") (qui)(stage fight_auto)(win_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub11]"))
	(retract `(qui))
	(retract `(stage fight_auto))
	(retract `(win_screen))
	(assert `(win_screen))
	(assert `(stage win))

	t)
       (t nil)))
(push top_topsub11 top_rules)
;;; end stage [top]



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub12]()
  (cond((match-unless? `((layer "stagename") (qui)(stage fight_auto)(die_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub12]"))
	(retract `(qui))
	(retract `(stage fight_auto))
	(retract `(die_screen))
	(assert `(die_screen))
	(assert `(stage die))

	t)
       (t nil)))
(push top_topsub12 top_rules)
;;; end stage [top]




 ;;; stage [fight]
(defparameter fight_rules nil)

(defun [fight]_[do_fight]()
  (cond((match-unless? `((layer "stagename") (choice)(fight_in_progress)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[do_fight]"))
	(retract `(choice))
	(retract `(fight_in_progress))(assert `(fight_in_progress))
	(assert `(try_fight))
	t)
       (t nil)))
(push fight_do_fight fight_rules)

(defun [fight]_[do_flee]()
  (cond((match-unless? `((layer "stagename") (choice)(fight_in_progress)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[do_flee]"))
	(retract `(choice))
	(retract `(fight_in_progress))(assert `(flee_screen))
	t)
       (t nil)))
(push fight_do_flee fight_rules)
;;; end stage [fight]
#interactive(fight).



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub13]()
  (cond((match-unless? `((layer "stagename") (qui)(stage fight)(fight_in_progress)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub13]"))
	(retract `(qui))
	(retract `(stage fight))
	(retract `(fight_in_progress))
	(assert `(fight_in_progress))
	(assert `(stage fight_auto))

	t)
       (t nil)))
(push top_topsub13 top_rules)
;;; end stage [top]



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub14]()
  (cond((match-unless? `((layer "stagename") (qui)(stage fight)(flee_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub14]"))
	(retract `(qui))
	(retract `(stage fight))
	(retract `(flee_screen))
	(assert `(flee_screen))
	(assert `(stage flee))

	t)
       (t nil)))
(push top_topsub14 top_rules)
;;; end stage [top]




 ;;; stage [flee]
(defparameter flee_rules nil)

(defun [flee]_[do/flee]()
  (cond((match-unless? `((layer "stagename") (flee_screen)(spoils X)(monster _)(monster_hp _)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[do/flee]"))
	(retract `(flee_screen))
	(retract `(spoils X))
	(retract `(monster _))
	(retract `(monster_hp _))(assert `(empty))
	t)
       (t nil)))
(push flee_do/flee flee_rules)
;;; end stage [flee]

 ;;; stage [top]
; --deleted--

(defun [top]_[topsub15]()
  (cond((match-unless? `((layer "stagename") (qui)(stage flee)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub15]"))
	(retract `(qui))
	(retract `(stage flee))
	(assert `(stage main))
	(assert `(main_screen))

	t)
       (t nil)))
(push top_topsub15 top_rules)
;;; end stage [top]



(defpred(go_home_or_continue) pred)

 ;;; stage [win]
(defparameter win_rules nil)

(defun [win]_[win]()
  (cond((match-unless? `((layer "stagename") (win_screen)(monster Size)(drop_amount Size,Drop)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[win]"))
	(retract `(win_screen))
	(retract `(monster Size))
	(retract `(drop_amount Size,Drop))(assert `(drop Drop))
	t)
       (t nil)))
(push win_win win_rules)

(defun [win]_[collect_spoils]()
  (cond((match-unless? `((layer "stagename") (drop X)(spoils Y)(plus X,Y,Z)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[collect_spoils]"))
	(retract `(drop X))
	(retract `(spoils Y))
	(retract `(plus X,Y,Z))(assert `(spoils Z))
	(assert `(go_home_or_continue))
	t)
       (t nil)))
(push win_collect_spoils win_rules)

(defun [win]_[go_home]()
  (cond((match-unless? `((layer "stagename") (go_home_or_continue)(spoils X)(treasure Y)(plus X,Y,Z)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[go_home]"))
	(retract `(go_home_or_continue))
	(retract `(spoils X))
	(retract `(treasure Y))
	(retract `(plus X,Y,Z))(assert `(treasure Z))
	(assert `(main_screen))
	t)
       (t nil)))
(push win_go_home win_rules)

(defun [win]_[continue]()
  (cond((match-unless? `((layer "stagename") (go_home_or_continue)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[continue]"))
	(retract `(go_home_or_continue))(assert `(fight_screen))
	t)
       (t nil)))
(push win_continue win_rules)
;;; end stage [win]
#interactive(win).



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub16]()
  (cond((match-unless? `((layer "stagename") (qui)(stage win)(main_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub16]"))
	(retract `(qui))
	(retract `(stage win))
	(retract `(main_screen))
	(assert `(main_screen))
	(assert `(stage main))

	t)
       (t nil)))
(push top_topsub16 top_rules)
;;; end stage [top]



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub17]()
  (cond((match-unless? `((layer "stagename") (qui)(stage win)(fight_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub17]"))
	(retract `(qui))
	(retract `(stage win))
	(retract `(fight_screen))
	(assert `(fight_screen))
	(assert `(stage fight_init))

	t)
       (t nil)))
(push top_topsub17 top_rules)
;;; end stage [top]


(defpred(end) pred)

 ;;; stage [die]
(defparameter die_rules nil)

(defun [die]_[quit]()
  (cond((match-unless? `((layer "stagename") (die_screen)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[quit]"))
	(retract `(die_screen))(assert `(end))
	t)
       (t nil)))
(push die_quit die_rules)

(defun [die]_[restart]()
  (cond((match-unless? `((layer "stagename") (die_screen)(monster_hp _)(spoils _)(ndays _)(treasure _)(weapon_damage _)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[restart]"))
	(retract `(die_screen))
	(retract `(monster_hp _))
	(retract `(spoils _))
	(retract `(ndays _))
	(retract `(treasure _))
	(retract `(weapon_damage _))(assert `(init_tok))
	t)
       (t nil)))
(push die_restart die_rules)
;;; end stage [die]
#interactive(die).



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub18]()
  (cond((match-unless? `((layer "stagename") (qui)(stage die)(end)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub18]"))
	(retract `(qui))
	(retract `(stage die))
	(retract `(end))
	(assert `(empty))

	t)
       (t nil)))
(push top_topsub18 top_rules)
;;; end stage [top]



 ;;; stage [top]
; --deleted--

(defun [top]_[topsub19]()
  (cond((match-unless? `((layer "stagename") (qui)(stage die)(init_tok)) `((qui)))
	(retract `(named-rule(:? any))) 
	(assert `(named-rule "[topsub19]"))
	(retract `(qui))
	(retract `(stage die))
	(retract `(init_tok))
	(assert `(init_tok))
	(assert `(stage init))

	t)
       (t nil)))
(push top_topsub19 top_rules)
;;; end stage [top]
