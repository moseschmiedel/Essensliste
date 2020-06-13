# Essensliste

This is a simple web-application written in Perl with Mojolicious, where you can keep track of who has to prepare when a meal.

## Usage
To run this app you need...

...from your package manager:
```
perl5 sqlite3
````
...from CPAN:
```
Mojolicious DBIx::Class Mojolicious::Plugin::DBIC
```
When you finished installing these, you can run
```
sqlite3 essensliste.sqlite < essensliste01.sql
```
in the application folder and then to start the server you need to run
```
morbo script/essensliste
```
Now visit `localhost:3000` to use the application.
