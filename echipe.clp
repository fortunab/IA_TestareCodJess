(deftemplate UEFAChampionsLeagueGroupStageDraw (slot team)(slot country)(slot pot)(slot cod)(slot group))

(assert (UEFAChampionsLeagueGroupStageDraw (team Bayern-Munich)(country Germany)(pot 1)(cod Bay)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Sevilla)(country Spain)(pot 1)(cod Sev)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Real-Madrid)(country Spain)(pot 1)(cod RMA)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Liverpool)(country England)(pot 1)(cod Liv)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Juventus)(country Italy)(pot 1)(cod Juv)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Paris-St-Germain)(country France)(pot 1)(cod PSG)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Zenit-St-Petersburg)(country Russia)(pot 1)(cod ZSP)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Porto)(country Portugal)(pot 1)(cod Por)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Barcelona)(country Spain)(pot 2)(cod FCB)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Atletico-Madrid)(country Spain)(pot 2)(cod ATM)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Manchester-City)(country England)(pot 2)(cod MNC)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Manchester-United)(country England)(pot 2)(cod MCU)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Shakhtar-Donetsk)(country Ukraine)(pot 2)(cod SKD)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Borussia-Dortmund)(country Germany)(pot 2)(cod DOR)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Chelsea)(country England)(pot 2)(cod Cls)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Ajax)(country Netherlands)(pot 2)(cod Ajx)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Dynamo-Kyiv)(country Ukraine)(pot 3)(cod DNK)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team RB-Salzburg)(country Austria)(pot 3)(cod RBS)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team RB-Leipzig)(country Germany)(pot 3)(cod RBL)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Inter-Milan)(country Italy)(pot 3)(cod FCI)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Olympiacos)(country Greece)(pot 3)(cod Oly)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Lazio)(country Italy)(pot 3)(cod Laz)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Krasnodar)(country Russia)(pot 3)(cod Kra)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Atalanta)(country Italy)(pot 3)(cod Ata)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Lokomotiv-Moscow)(country Russia)(pot 4)(cod LKM)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Marseille)(country France)(pot 4)(cod Mar)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Club-Brugge)(country Belgium)(pot 4)(cod CBr)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Borussia-Moenchengladbach)(country Germany)(pot 4)(cod Moc)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Istanbul-Basaksehir)(country Turkey)(pot 4)(cod ITB)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Midtjylland)(country Denmark)(pot 4)(cod Mid)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Rennes)(country France)(pot 4)(cod Ren)(group nil)))
(assert (UEFAChampionsLeagueGroupStageDraw (team Ferencvaros)(country Hungary)(pot 4)(cod Fer)(group nil)))


(defrule display_data
    (declare(salience 110))
	(UEFAChampionsLeagueGroupStageDraw (team ?t)(country ?c)(pot ?p)(cod ?cod))
    =>
    (printout t ?t " " ?cod " " ?c " " ?p crlf)
)

;(facts)
(save-facts "Graf.txt" local UEFAChampionsLeagueGroupStageDraw)
(run)






