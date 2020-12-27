(deftemplate UEFAChampionsLeagueGroupStageDraw (slot team)(slot country)(slot pot)(slot group))

(assert (UEFAChampionsLeagueGroupStageDraw (team "Bayern Munich")(country Germany)(pot 1)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Liverpool)(country England)(pot 1)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Juventus)(country Italy)(pot 1)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Porto)(country Portugal)(pot 1)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Barcelona)(country Spain)(pot 2)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Manchester United")(country England)(pot 2)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Borussia Dortmund")(country Germany)(pot 2)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Chelsea)(country England)(pot 2)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Ajax)(country Netherlands)(pot 3)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Inter Milan")(country Italy)(pot 3)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Olympiacos)(country Greece)(pot 3)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Krasnodar)(country Russia)(pot 3)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Lokomotiv Moscow")(country Russia)(pot 4)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Borussia Moenchengladbach")(country Germany)(pot 4)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Istanbul Basaksehir")(country Turkey)(pot 4)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Rennes)(country France)(pot 4)(group nil)))

(assert  (group A)(group B)(group C)(group D))

(defrule display_data
    (declare(salience 110))
	(UEFAChampionsLeagueGroupStageDraw (team ?t)(country ?c)(pot ?p))
    =>
    (printout t "Team " ?t " from " ?c " is in the pot number " ?p crlf)
)

(deftemplate AssociateGroup
    (slot team)(slot group))

(assert 
    (team "Bayern Munich")(team Liverpool)(team Juventus)(team Porto)
   	(team Barcelona)(team "Manchester United")(team "Borussia Dortmund")(team Chelsea)
    (team Ajax)(team "Inter Milan")(team Olympiacos)(team Krasnodar)
    (team "Lokomotiv Moscow")(team "Borussia Moenchengladbach")(team "Istanbul Basaksehir")(team Rennes)
    
    (group A)(group B)(group C)(group D)
)

(defrule init
    (team ?t)
    (group ?g)
    =>
    (assert (AssociateGroup (team ?t)(group ?g)))
)


(defrule solutionPotsInGroups
    ?we1<-(AssociateGroup (team "Bayern Munich")(group ?gbm &: (= A ?gbm)))
    ?we2<-(AssociateGroup (team Liverpool)(group ?gli &~ ?gbm))
    ?we3<-(AssociateGroup (team Juventus)(group ?gju &~ ?gli &~ ?gbm))
    ?we4<-(AssociateGroup (team Porto)(group ?gpo &~ ?gju &~ ?gli &~ ?gbm))
    
    ?we5<-(AssociateGroup (team Barcelona)(group ?gba))
    ?we6<-(AssociateGroup (team "Manchester United")(group ?gmu &~ ?gba &~ ?gli))
    ?we7<-(AssociateGroup (team "Borussia Dortmund")(group ?gbd &~ ?gmu &~ ?gba &~ ?gbm))
    ?we8<-(AssociateGroup (team Chelsea)(group ?gch &~ ?gbd &~ ?gmu &~ ?gba &~ ?gli))
    
    ?we9<-(AssociateGroup (team Ajax)(group ?gaj))
    ?we10<-(AssociateGroup (team "Inter Milan")(group ?gim &~ ?gaj &~ ?gju))
    ?we11<-(AssociateGroup (team Olympiacos)(group ?gol &~ ?gim &~ ?gaj))
    ?we12<-(AssociateGroup (team Krasnodar)(group ?gkr &~ ?gol &~ ?gim &~ ?gaj))
    
    ?we13<-(AssociateGroup (team "Lokomotiv Moscow")(group ?glm &~ ?gkr))
    ?we14<-(AssociateGroup (team "Borussia Moenchengladbach")(group ?gbmoe &~ ?glm &~ ?gbm &~ ?gbd))
    ?we15<-(AssociateGroup (team "Istanbul Basaksehir")(group ?gib &~ ?gbmoe &~ ?glm))
    ?we16<-(AssociateGroup (team Rennes)(group ?gren &~ ?gib &~ ?gbmoe &~ ?glm))

    =>
    
    (modify 0 (group ?gbm))
    (modify 1 (group ?gli))
    (modify 2 (group ?gju))
    (modify 3 (group ?gpo))
    
    (modify 4 (group ?gba))
    (modify 5 (group ?gmu))
    (modify 6 (group ?gbd))
    (modify 7 (group ?gch))
    
    (modify 8 (group ?gaj))
    (modify 9 (group ?gim))
    (modify 10 (group ?gol))
    (modify 11 (group ?gkr))
    
    (modify 12 (group ?glm))
    (modify 13 (group ?gbmoe))
    (modify 14 (group ?gib))
    (modify 15 (group ?gren))
   
    
    (retract ?we1)
    (retract ?we2)
    (retract ?we3)
    (retract ?we4)
    
    (retract ?we5)
    (retract ?we6)
    (retract ?we7)
    (retract ?we8)
    
    (retract ?we9)
    (retract ?we10)
    (retract ?we11)
    (retract ?we12)
    
    (retract ?we13)
    (retract ?we14)
    (retract ?we15)
    (retract ?we16) 
    
    (facts)
)

(defrule grupaA
    (declare(salience 100))
    (UEFAChampionsLeagueGroupStageDraw (team ?t)(group A))
	=>
    (printout t "A -> " ?t crlf)
)

(defrule grupaB
    (declare(salience 90))
    (UEFAChampionsLeagueGroupStageDraw (team ?t)(group B))
	=>
    (printout t "B -> " ?t crlf)
)

(defrule grupaC
    (declare(salience 80))
    (UEFAChampionsLeagueGroupStageDraw (team ?t)(group C))
	=>
    (printout t "C -> " ?t crlf)
)

(defrule grupaD
    (declare(salience 70))
    (UEFAChampionsLeagueGroupStageDraw (team ?t)(group D))
	=>
    (printout t "D -> " ?t crlf)
)

(facts)
(run)







