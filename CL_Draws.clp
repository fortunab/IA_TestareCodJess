(deftemplate UEFAChampionsLeagueGroupStageDraw (slot team)(slot country)(slot pot)(slot group))

(assert (UEFAChampionsLeagueGroupStageDraw (team "Bayern Munich")(country Germany)(pot 1)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Sevilla)(country Spain)(pot 1)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Real Madrid")(country Spain)(pot 1)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Liverpool)(country England)(pot 1)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Juventus)(country Italy)(pot 1)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team PSG)(country France)(pot 1)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Zenit)(country Russia)(pot 1)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Porto)(country Portugal)(pot 1)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Barcelona)(country Spain)(pot 2)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Atletico Madrid")(country Spain)(pot 2)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Manchester City")(country England)(pot 2)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Manchester United")(country England)(pot 2)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Shakhtar Donetsk")(country Ukraine)(pot 2)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Borussia Dortmund")(country Germany)(pot 2)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Chelsea)(country England)(pot 2)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Ajax)(country Netherlands)(pot 2)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Dynamo Kyiv")(country Ukraine)(pot 3)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "RB Salzburg")(country Austria)(pot 3)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "RB Leipzig")(country Germany)(pot 3)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Inter Milan")(country Italy)(pot 3)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Olympiacos)(country Greece)(pot 3)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Lazio)(country Italy)(pot 3)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Krasnodar)(country Russia)(pot 3)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Atalanta)(country Italy)(pot 3)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Lokomotiv Moscow")(country Russia)(pot 4)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Marseille)(country France)(pot 4)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Club Brugge")(country Belgium)(pot 4)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Borussia Moenchengladbach")(country Germany)(pot 4)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team "Istanbul Basaksehir")(country Turkey)(pot 4)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Midtjylland)(country Denmark)(pot 4)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Rennes)(country France)(pot 4)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Ferencvaros)(country Hungary)(pot 4)(group nil)))



(deftemplate AssociateGroup
    (slot team)(slot group))

(assert (team "Bayern Munich")(team Sevilla)(team "Real Madrid")(team Liverpool)(team Juventus)(team PSG)(team Zenit)(team Porto)
   		(team Barcelona)(team "Atletico Madrid")(team "Manchester City")(team "Manchester United")
    	(team "Shakhtar Donetsk")(team "Borussia Dortmund")(team Chelsea)(team Ajax)
    	(team "Dynamo Kyiv")(team "RB Salzburg")(team "RB Leipzig")(team "Inter Milan")(team Olympiacos)(team Lazio)(team Krasnodar)(team Atalanta)
    	(team "Lokomotiv Moscow")(team Marseille)(team "Club Brugge")(team "Borussia Moenchengladbach")
    	(team "Istanbul Basaksehir")(team Midtjylland)(team Rennes)(team Ferencvaros)
    
    	(group A)(group B)(group C)(group D)(group E)(group F)(group G)(group H)	
)

(defrule init
    (team ?t)
    (group ?g)
    =>
    (assert (AssociateGroup (team ?t)(group ?g)))
)

(defrule solutiePot1
    (AssociateGroup (team "Bayern Munich")(group ?gbm &: (= A ?gbm)))
    (AssociateGroup (team Sevilla)(group ?gse &~ ?gbm))
    (AssociateGroup (team "Real Madrid")(group ?grm &~ ?gse &~ ?gbm))
    (AssociateGroup (team Liverpool)(group ?gli &~ ?grm &~ ?gse &~ ?gbm))
    (AssociateGroup (team Juventus)(group ?gju &~ ?gli &~ ?grm &~ ?gse &~ ?gbm))
    (AssociateGroup (team PSG)(group ?gpa &~ ?gju &~ ?gli &~ ?grm &~ ?gse &~ ?gbm))
    (AssociateGroup (team Zenit)(group ?gze &~ ?gpa &~ ?gju &~ ?gli &~ ?grm &~ ?gse &~ ?gbm))
    (AssociateGroup (team Porto)(group ?gpo &~ ?gze &~ ?gpa &~ ?gju &~ ?gli &~ ?grm &~ ?gse &~ ?gbm))
    
    (AssociateGroup (team Barcelona)(group ?gba &~ ?grm &~ ?gse))
    (AssociateGroup (team "Atletico Madrid")(group ?gam &~ ?gba &~ ?grm &~ ?gse))
    (AssociateGroup (team "Manchester City")(group ?gmc &~ ?gam &~ ?gba &~ ?gli))
    (AssociateGroup (team "Manchester United")(group ?gmu &~ ?gmc &~ ?gam &~ ?gba &~ ?gli))
    (AssociateGroup (team "Shakhtar Donetsk")(group ?gsd &~ ?gmu &~ ?gmc &~ ?gam &~ ?gba &~ ?gze))
    (AssociateGroup (team "Borussia Dortmund")(group ?gbd &~ ?gsd &~ ?gmu &~ ?gmc &~ ?gam &~ ?gba &~ ?gbm))
    (AssociateGroup (team Chelsea)(group ?gch &~ ?gbd &~ ?gsd &~ ?gmu &~ ?gmc &~ ?gam &~ ?gba &~ ?gli))
    (AssociateGroup (team Ajax)(group ?gaj &~ ?gch &~ ?gbd &~ ?gsd &~ ?gmu &~ ?gmc &~ ?gam &~ ?gba))
    
    (AssociateGroup (team "Dynamo Kyiv")(group ?gdk &~ ?gsd &~ ?gze))
    (AssociateGroup (team "RB Salzburg")(group ?grbs &~ ?gdk))
    (AssociateGroup (team "RB Leipzig")(group ?grbl &~ ?grbs &~ ?gdk &~ ?gbd &~ ?gbm))
    (AssociateGroup (team "Inter Milan")(group ?gim &~ ?grbl &~ ?grbs &~ ?gdk &~ ?gju))
    (AssociateGroup (team Olympiacos)(group ?gol &~ ?gim &~ ?grbl &~ ?grbs &~ ?gdk))
    (AssociateGroup (team Lazio)(group ?gla &~ ?gol &~ ?gim &~ ?grbl &~ ?grbs &~ ?gdk &~ ?gju))
    (AssociateGroup (team Krasnodar)(group ?gkr &~ ?gla &~ ?gol &~ ?gim &~ ?grbl &~ ?grbs &~ ?gdk &~ ?gsd &~ ?gze))
    (AssociateGroup (team Atalanta)(group ?gatal &~ ?gkr &~ ?gla &~ ?gol &~ ?gim &~ ?grbl &~ ?grbs &~ ?gdk &~ ?gju))
    
    (AssociateGroup (team "Lokomotiv Moscow")(group ?glm &~ ?gdk &~ ?gsd &~ ?gze &~ ?gkr))
    (AssociateGroup (team Marseille)(group ?gmrs &~ ?glm &~ ?gpa))
    (AssociateGroup (team "Club Brugge")(group ?gcb &~ ?gmrs &~ ?glm))
    (AssociateGroup (team "Borussia Moenchengladbach")(group ?gbmoe &~ ?gcb &~ ?gmrs &~ ?glm &~ ?gbm &~ ?gbd &~ ?grbl))
    (AssociateGroup (team "Istanbul Basaksehir")(group ?gbmoe &~ ?gcb &~ ?gmrs &~ ?glm))
    (AssociateGroup (team Midtjylland)(group ?gmy &~ ?gbmoe &~ ?gcb &~ ?gmrs &~ ?glm))
    (AssociateGroup (team Rennes)(group ?gren &~ ?gmy &~ ?gbmoe &~ ?gcb &~ ?gmrs &~ ?glm &~ ?gpa))
    (AssociateGroup (team Ferencvaros)(group ?gfere &~ ?gren &~ ?gmy &~ ?gbmoe &~ ?gcb &~ ?gmrs &~ ?glm))
    

    ;(AssociateGroup (team ?t)(group A))   
    =>
    ;(printout t "Echipele din grupa A sunt=" ?t crlf)
    
    ;(assert (AssociateGroup (team ?t)(group A)))
    
    (printout t "Bayern Munich=" ?gbm "; ")
    (printout t "Sevilla=" ?gse "; ")
    (printout t "Real Madrid=" ?grm "; ")
    (printout t "Liverpool=" ?gli "; ")
    (printout t "Juventus=" ?gju "; ")
    (printout t "PSG=" ?gpa "; ")
    (printout t "Zenit=" ?gze "; ")
    (printout t "Porto=" ?gpo "; " crlf)

    
    (printout t "Barcelona=" ?gba "; ")
    (printout t "Atletico Madrid=" ?gam "; ")
    (printout t "Manchester City=" ?gmc "; ")
    (printout t "Manchester United=" ?gmu "; ")
    (printout t "Shakhtar Donetsk=" ?gsd "; ")
    (printout t "Borussia Dortmund=" ?gbd "; ")
    (printout t "Chelsea=" ?gch "; ")
    (printout t "Ajax=" ?gaj "; " crlf)
    
    (printout t "Dynamo Kiyv=" ?gdk "; ")
    (printout t "RBS=" ?grbs "; ")
    (printout t "RBL=" ?grbl "; ")
    (printout t "Inter=" ?gim "; ")
    (printout t "Olympiacos=" ?gol "; ")
    (printout t "Lazio=" ?gla "; ")
    (printout t "Krasnodar=" ?gkr "; ")
    (printout t "Atalanta=" ?gatal "; " crlf)
    
    (printout t "Lokomotiva Moscow=" ?glm "; ")
    (printout t "Marseille=" ?gmrs "; ")
    (printout t "Club Brugge=" ?gcb "; ")
    (printout t "BMG=" ?gbmoe "; ")
    (printout t "Istanbul Basaksehir=" ?gib "; ")
    (printout t "Midtjylland=" ?gmy "; ")
    (printout t "Rennes=" ?gren "; ")
    (printout t "Ferencvaros=" ?gfere "; ")
    
)
(run)







