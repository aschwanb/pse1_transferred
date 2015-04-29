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
```
cd ../MegaUltraTweet
```
Alle Cron Jobs starten
```
whenever --update-crontab MegaUltraTweet
```
Datenbank neu aufsetzen:
```
rake db:create
rake db:schema:load
```
Development Datenbank importiern:  
Im Verzeichnis dokument/db befindet sich ein Dump der Server-Datenbank.
```
mysql -u root -p db/development.mysql < dump.sql
```

# Run Tests
In das Verzeichnis wechseln
```
cd ../MegaUltraTweet
```
Test ausführen:
```
rspec spec
```
