# pse1
Semesterprojekt Praktikum Software Engineering
==============================================
# Projektbeschreibung:
SwissDRG
Welche hashtags werden auf twitter im Bereich Technik synonym gebraucht?
Graphisches Abbilden von jeweils 7 "nahestehenden" hashtags in einer Baum oder bubble-Struktur.
Evtl. Aufzeigen, welche Begriffe in den zugehörigen Tweets in den letzten 48h neu dazugekommen
sind ("trending") oder aus der Reihe fallen.

# Setup
Nach dem Clonen des Repositories:
In das Verzeichnis wechseln
> cd ../MegaUltraTweet
Alle Cron Jobs starten
> whenever --update-crontab
Datenbank neu aufsetzen:
> rake db:create
> rake db:schema:load
