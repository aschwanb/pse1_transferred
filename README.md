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

# Custom Error Pages
Ein dedizierter Controller kümmert sich um die Weiterleitung für Fehlerseiten. Diese wird jedoch im development environment standardmässig unterdrückt. (Fehler werden direkt in den Browser ausgegeben.) Nett fürs Debugging, für das Testen der Error Pages aber wenig sinnvoll. Deshalb kann diese Funktion mit folgendem Befehl ausgeschaltet werden:
```
config/environments/development.rb
config.consider_all_requests_local = false
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

# Ranking/Popularity explained
Um den Rang/die Wichtigkeit eines Objekts zu bestimmen, werden die folgenden Informationen verwendet:
```
Author = Follower Count
Tweet = Retweet Count + Rank Author
Hashtag = Times Used (im letzten Intervall)
Author/Hashtag Pair = Times Uses (im letzten Intervall)
Hashtag/Hashtag Pair = Times Uses (im letzten Intervall)
```
# Trending explained
- Pro Rollover wird erfasst, wie oft ein Hashtag verwendet wird.
- Um den Trend zu berechnen, wird am Ende jedes Rollovers der Unterschied zwischen dem jetzigen und dem vorherigen Intervall erfasst.
- Die Art des Trends definiert die Länge des Intervalls.
```ruby
# Beispiel
# Short Term Trend: 15 min
interval = 1
usage = [ 15 20 10 4 ]
current = self.times_used[0, interval]
# => [15]
old = self.times_used[0+interval, interval]
# => [20]
trend =  current.inject(:+) - old.inject(:+)
# => 15-20 = -5
```
# Starting points for search
- Starting Points sind definiert in MegaUltraTweet::Application::DEFAULT_STARTING_VALUES
- Sie werden nach dem Aufsetzen der Datenbank und dem seeding in der Datenbank gespeichert
..- Startingpoint.first
- Pro Rollover werden die populärsten Hashtags zum Startinpoint hinzugefügt
- Ein Maximum sorgt dafür, dass nicht zu viele Hashtags als Startwerte genommen werden
- Die gensammte Konfiguration ist abgelegt in ../config/application.rb

# Search explained
Die eigentliche Suche findet im TwitterClient objekt statt. Ausgelöst wird sie aber in TwitterScraper. Hier wird der Vorgang erklärt:
```ruby
def get_tweets(query, depth)
  Array(query).each { |keyword| scrape(keyword, depth) }
end
# Für jeden Wert in Startingpoint.get_start wird folgenes ausgeführt 
def scrape(keyword, depth)
  # Der Twitter Client führt eine Suche nach dem Keyword aus und erhält Tweets zurück
  tweets = run_query(keyword)
  # Die Tweets werden gespeichert
  tweets.each { |t| @client.save_tweet(t) }
  # Die in den Tweets enthaltenen Hashtags werden nach ihrer Popularität geordnet
  # Die Populärsten n werden genommen und in new_query geschrieben
  new_query = self.get_new_query(keyword, tweets)
  # Eine neue Suche mit den neuen Begriffen wird ausgelöst
  depth -= 1
  if depth > 0
    puts "Finished with #{keyword}. Start new branch with #{new_query}"
    get_tweets(new_query, depth)
  end
end
```
