
					; -*-Lisp-*-
(assert `(max_hp 10))
(assert `(damage sword 4))
(assert `(cost sword 10))


(assert `(init_tok))

 ;;; stage [init]
(defparameter init_rules nil)

(defun init_i ()           
  (cond ((and (match? `(stage init))
              (match? `(init_tok))
              (match? `(max_hp N)))
         (assert `(rule i))
         (retract `(init_tok))
         (retract `(max_hp N))
         (assert `(health N))
         (assert `(treasure z))
         (assert `(ndays z))
         (assert `(weapon_damage 4))
         t)
        (t nil)))
(setf init_rules (append init_rules '(i)))
  
 ;;; end stage [init]

 ;;; stage [top]
(defparameter top_rules nil)

(defun top_topsub1 ()
  (cond ((and (match? `(stage top))
	      (match? `(qui))
              (match? `(stage init)))
         (assert `(rule topsub1))
         (retract `(qui))
         (retract `(stage init))
         (assert `(stage main))
         (assert `(main_screen))
         t)
        (t nil)))
(setf top_rules (append top_rules '(top_topsub1)))
 ;;; end stage [top]


 ;;; stage [main]
(defparameter main_rules nil)
(defun main__interaction ()
  (interact main 
	    "choose: 1 - do/rest ; 2 - do/adventure ; 3 - do/shop ; 4 - do/quit" 
	    `((1 . do/rest) (2 . do/adventure) (3 . do/shop) (4 . do/quit))))
(setf main_rules (append main_rules '(main__interaction)))
	 
(defun main_do/rest ()
  (cond ((and (match? `(stage main))
	      (match? `(main_screen))
	      (match? `(_interaction_finished))
	      (match? `(do/rest)))
	 (assert `(rule do/rest))
	 (retract `(main_screen))
	 (retract `(_interaction_finished))
	 (assert `(rest_screen))
	 t)
	(t nil)))
(setf main_rules (append main_rules '(main_do/rest)))

(defun main_do/adventure ()
  (cond ((and (match? `(stage main))
	      (match? `(main_screen))
	      (match? `(_interaction_finished))
	      (match? `(do/adventure)))
	 (assert `(rule do/adventure))
	 (retract `(main_screen))
	 (retract `(_interaction_finished))
	 (assert `(adventure_screen))
	 t)
	(t nil)))
(setf main_rules (append main_rules '(main_do/adventure))

(defun main_do/shop ()
  (cond ((and (match? `(stage main))
	      (match? `(main_screen))
	      (match? `(_interaction_finished))
	      (match? `(do/shop)))
	 (assert `(rule do/shop))
	 (retract `(main_screen))
	 (retract `(_interaction_finished))
	 (assert `(shop_screen))
	 t)
	(t nil)))
(setf main_rules (append main_rules '(main_do/shop))

(stagerule main do/quit
(defun main_do/quit ()
  (cond ((and (match? `(stage main))
	      (match? `(main_screen))
	      (match? `(_interaction_finished))
	      (match? `(do/quit)))
	 (assert `(rule do/quit))
	 (retract `(main_screen))
	 (retract `(_interaction_finished))
	 (assert `(quit))
	 t)
	(t nil)))
(setf main_rules (append main_rules '(main_do/quit))
 ;;; end stage [main]



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub2
	   (atomicmatch (match? `(qui))
			(match? `(stage main))
			(match? `(rest_screen)))
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
	   (atomicmatch (match? `(qui))
			(match? `(stage main))
			(match? `(shop_screen)))
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
	   (atomicmatch (match? `(qui))
			(match? `(stage main))
			(match? `(adventure_screen)))
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
	   (atomicmatch (match? `(qui))
			(match? `(stage main))
			(match? `(quit)))
	   (retract `(qui))
	   (retract `(stage main))
	   (retract `(quit))
	   (assert `(empty))
	   )
 ;;; end stage [top]




 ;;; stage [rest]
(defparameter rest_rules nil)
(stagerule rest recharge
	   (atomicmatch (match? `(rest_screen))
			(match? `(health HP))
			(match? `(max_hp Max))
			(match? `(recharge_hp Recharge))
			(match? `(cplus HP,Recharge,Max,N))
			(match? `(ndays NDAYS)))
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
	   (atomicmatch (match? `(qui))
			(match? `(stage rest)))
	   (retract `(qui))
	   (retract `(stage rest))
	   (assert `(stage main))
	   (assert `(main_screen))
	   )
 ;;; end stage [top]




 ;;; stage [shop]
(defparameter shop_rules nil)
(stagerule shop leave
	   (atomicmatch (match? `(shop_screen)))
	   (retract `(shop_screen))
	   (assert `(main_screen)))
(stagerule shop buy
	   (atomicmatch (match? `(treasure T))
			(match? `(cost W,C))
			(match? `(damage_of W,D))
			(match? `(weapon_damage _))
			(match? `(subtract T,C,(some T'))))
	   (retract `(treasure T))
	   (retract `(cost W,C))
	   (retract `(damage_of W,D))
	   (retract `(weapon_damage _))
	   (retract `(subtract T,C,(some T')))
	   (assert `(treasure T'))
	   (assert `(weapon_damage D)))
 ;;; end stage [shop]
(interactive '(
	       (leave (shop leave))
	       (but   (shop buy))))




 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub7
	   (atomicmatch (match? `(qui))
			(match? `(stage shop))
			(match? `(main_screen)))
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
	   (atomicmatch (match? `(adventure_screen)))
	   (retract `(adventure_screen))
	   (assert `(spoils z)))
 ;;; end stage [adventure]

 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub8
	   (atomicmatch (match? `(qui))
			(match? `(stage adventure)))
	   (retract `(qui))
	   (retract `(stage adventure))
	   (assert `(stage fight_init))
	   (assert `(fight_screen))
	   )
 ;;; end stage [top]



(defbwd(drop_amount nat nat) bwd)
(assert `(drop_amount X X))

 ;;; stage [fight_init]
(defparameter fight_init_rules nil)
(stagerule fight_init init
	   (atomicmatch (match? `(fight_screen)))
	   (retract `(fight_screen))
	   (assert `(gen_monster))
	   (assert `(fight_in_progress)))
(stagerule fight_init gen_a_monster
	   (atomicmatch (match? `(gen_monster))
			(match? `(monster_size Size)))
	   (retract `(gen_monster))
	   (retract `(monster_size Size))
	   (assert `(monster Size))
	   (assert `(monster_hp Size)))
 ;;; end stage [fight_init]

 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub9
	   (atomicmatch (match? `(qui))
			(match? `(stage fight_init)))
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
	   (atomicmatch (match? `(try_fight))
			(match? `(fight_in_progress))
			(match? `(monster_hp MHP))
			(match? `(weapon_damage D))
			(match? `(subtract MHP,D,(some MHP'))))
	   (retract `(try_fight))
	   (retract `(fight_in_progress))
	   (retract `(monster_hp MHP))
	   (retract `(weapon_damage D))
	   (retract `(subtract MHP,D,(some MHP')))
	   (assert `(fight_in_progress))
	   (assert `(weapon_damage D))
	   (assert `(monster_hp MHP')))
(stagerule fight_auto win
	   (atomicmatch (match? `(fight_in_progress))
			(match? `(monster_hp MHP))
			(match? `(weapon_damage D))
			(match? `(subtract MHP,D,none)))
	   (retract `(fight_in_progress))
	   (retract `(monster_hp MHP))
	   (retract `(weapon_damage D))
	   (retract `(subtract MHP,D,none))
	   (assert `(weapon_damage D))
	   (assert `(win_screen)))
(stagerule fight_auto fight/miss
	   (atomicmatch (match? `(try_fight))
			(match? `(fight_in_progress))
			(match? `(monster Size))
			(match? `(health HP))
			(match? `(subtract HP,Size,(some HP'))))
	   (retract `(try_fight))
	   (retract `(fight_in_progress))
	   (retract `(monster Size))
	   (retract `(health HP))
	   (retract `(subtract HP,Size,(some HP')))
	   (assert `(fight_in_progress))
	   (assert `(monster Size))
	   (assert `(health HP')))
(stagerule fight_auto die_from_damages
	   (atomicmatch (match? `(health z))
			(match? `(fight_in_progress)))
	   (retract `(health z))
	   (retract `(fight_in_progress))
	   (assert `(die_screen)))
(stagerule fight_auto fight/die
	   (atomicmatch (match? `(try_fight))
			(match? `(fight_in_progress))
			(match? `(monster Size))
			(match? `(health HP))
			(match? `(subtract HP,Size,none)))
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
	   (atomicmatch (match? `(qui))
			(match? `(stage fight_auto))
			(match? `(fight_in_progress)))
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
	   (atomicmatch (match? `(qui))
			(match? `(stage fight_auto))
			(match? `(win_screen)))
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
	   (atomicmatch (match? `(qui))
			(match? `(stage fight_auto))
			(match? `(die_screen)))
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
	   (atomicmatch (match? `(choice))
			(match? `(fight_in_progress)))
	   (retract `(choice))
	   (retract `(fight_in_progress))
	   (assert `(fight_in_progress))
	   (assert `(try_fight)))
(stagerule fight do_flee
	   (atomicmatch (match? `(choice))
			(match? `(fight_in_progress)))
	   (retract `(choice))
	   (retract `(fight_in_progress))
	   (assert `(flee_screen)))
 ;;; end stage [fight]
(interactive `(
	       (fight (fight do_fight))
	       (flee  (fight do_flee))))




 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub13
	   (atomicmatch (match? `(qui))
			(match? `(stage fight))
			(match? `(fight_in_progress)))
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
	   (atomicmatch (match? `(qui))
			(match? `(stage fight))
			(match? `(flee_screen)))
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
	   (atomicmatch (match? `(flee_screen))
			(match? `(spoils X))
			(match? `(monster _))
			(match? `(monster_hp _)))
	   (retract `(flee_screen))
	   (retract `(spoils X))
	   (retract `(monster _))
	   (retract `(monster_hp _))
	   (assert `(empty)))
 ;;; end stage [flee]

 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub15
	   (atomicmatch (match? `(qui))
			(match? `(stage flee)))
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
	   (atomicmatch (match? `(win_screen))
			(match? `(monster Size))
			(match? `(drop_amount Size,Drop)))
	   (retract `(win_screen))
	   (retract `(monster Size))
	   (retract `(drop_amount Size,Drop))
	   (assert `(drop Drop)))
(stagerule win collect_spoils
	   (atomicmatch (match? `(drop X))
			(match? `(spoils Y))
			(match? `(plus X,Y,Z)))
	   (retract `(drop X))
	   (retract `(spoils Y))
	   (retract `(plus X,Y,Z))
	   (assert `(spoils Z))
	   (assert `(go_home_or_continue)))
(stagerule win go_home
	   (atomicmatch (match? `(go_home_or_continue))
			(match? `(spoils X))
			(match? `(treasure Y))
			(match? `(plus X,Y,Z)))
	   (retract `(go_home_or_continue))
	   (retract `(spoils X))
	   (retract `(treasure Y))
	   (retract `(plus X,Y,Z))
	   (assert `(treasure Z))
	   (assert `(main_screen)))
(stagerule win continue
	   (atomicmatch (match? `(go_home_or_continue)))
	   (retract `(go_home_or_continue))
	   (assert `(fight_screen)))
 ;;; end stage [win]
(interactive `((win (win win)) (collect_spoils (win collect_spoils)) (go_home (win go_home)) (continue (win continue))))



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub16
	   (atomicmatch (match? `(qui))
			(match? `(stage win))
			(match? `(main_screen)))
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
	   (atomicmatch (match? `(qui))
			(match? `(stage win))
			(match? `(fight_screen)))
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
	   (atomicmatch (match? `(die_screen)))
	   (retract `(die_screen))
	   (assert `(end)))
(stagerule die restart
	   (atomicmatch (match? `(die_screen))
			(match? `(monster_hp _))
			(match? `(spoils _))
			(match? `(ndays _))
			(match? `(treasure _))
			(match? `(weapon_damage _)))
	   (retract `(die_screen))
	   (retract `(monster_hp _))
	   (retract `(spoils _))
	   (retract `(ndays _))
	   (retract `(treasure _))
	   (retract `(weapon_damage _))
	   (assert `(init_tok)))
 ;;; end stage [die]
(interactive '( (quit (die quit)) (restart (die restart))))



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub18
	   (atomicmatch (match? `(qui))
			(match? `(stage die))
			(match? `(end)))
	   (retract `(qui))
	   (retract `(stage die))
	   (retract `(end))
	   (assert `(empty))
	   )
 ;;; end stage [top]



 ;;; stage [top]
(defparameter top_rules nil)
(stagerule top topsub19
	   (atomicmatch (match? `(qui))
			(match? `(stage die))
			(match? `(init_tok)))
	   (retract `(qui))
	   (retract `(stage die))
	   (retract `(init_tok))
	   (assert `(init_tok))
	   (assert `(stage init))
	   )
 ;;; end stage [top]
