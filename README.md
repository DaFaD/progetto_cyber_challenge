# Progetto Cyber Challenge

Gemme utilizzate:
	gem 'rails', '4.2.0.rc2'
    gem 'bcrypt', '3.1.7'
    gem 'faker', '1.4.2'
    gem 'will_paginate', '3.0.7'
    gem 'bootstrap-will_paginate', '0.0.10'
    gem 'will_paginate-bootstrap'
    gem 'codice-fiscale'
    gem 'bootstrap-sass', '3.2.0.0'
    gem 'sass-rails', '5.0.0.beta1'
    gem 'uglifier', '2.5.3'
    gem 'coffee-rails', '4.0.1'
    gem 'jquery-rails', '4.0.0.beta2'
    gem 'turbolinks', '2.3.0'
    gem 'jbuilder', '2.2.3'
    gem 'rails-html-sanitizer', '1.0.1'
    gem 'sdoc', '0.4.0', group: :doc
    
    Gemme specifiche per gli ambienti development e test:
        gem 'sqlite3', '1.3.9'
        gem 'byebug', '3.4.0'
        gem 'web-console', '2.0.0.beta3'
        gem 'spring', '1.1.3'
        
    Gemme specifiche per l'ambiente test:
        gem 'minitest-reporters', '1.0.5'
        gem 'mini_backtrace', '0.1.3'
        gem 'guard-minitest', '2.3.1'
        
    Gemme specifiche per l'ambiente production (production eseguita su Heroku):
        gem 'pg', '0.17.1'
        gem 'rails_12factor', '0.0.2'
        gem 'unicorn', '4.8.3'
        

Per la produzione è stato scelto il servizio Heroku.
Per i test è stato usato lo strumento Minitest.


# Istruzioni:
1. clonare in locale il ramo master del progetto;
2. spostarsi con un prompt di comando all'interno della cartella progetto_cyber_challenge (radice di tutta l'applicazione);
3. eseguire il comando "bundle install --without production" che installerà tutte le gemme necessarie
   (con questo comando vengono escuse le gemme del gruppo production le quali servono solamente per il deploy su Heroku);
4. eseguire il comando "bundle exec rake db:migrate" che creerà un database per l'ambiente di sviluppo dell'applicazione;
5. eseguire il comando "bundle exec rake test" che creerà un database per l'ambiente di test dell'aplicazione
   ed eseguirà la suite di test fornita tramite lo strumento Minitest;
6. eseguire il comando "bundle exec rake db:seed" che popolerà il database di sviluppo dell'applicazione con degli utenti
   d'esempio (il comando di seed potrebbe richiedere svariato tempo affinché termini di popolare il database e sblocchi
   il terminale su cui è stato lanciato);
7. una volta terminata l'operazione di seed lanciare il comando "rails server" che avvierà un server Webrick che renderà
   l'applicazione visitabile all'indirizzo "http://localhost:3000/" (in produzione è stato invece scelto un server Unicorn
   in grado di gestire molti più utenti e connessioni del server dell'ambiente di sviluppo).


# NB
1. Se si vogliono resettare i database eseguire in sequenza i comandi:
        "bundle exec rake db:migrate:reset"
        "bundle exec rake test"
        "bundle exec rake db:seed"
2. Le e-mail che l'applicazione invia in atomatico (vedi ad esempio l'email di attivazione dell'account, o quella di reset della
   password o ancora quella per la fornitura dell'OTP), vengono inviate veramente solo in produzione su Heroku; se ci si trova
   nell'ambiente di sviluppo tali e-mail verranno visualizzate con un'anteprima un po' primitiva nel log del server visualizzabile
   nel prompt di comando nel quale è stato lanciato il server (potrebbe essere necessario scrollare di molto verso l'alto nel prompt
   prima di arrivare a visualizzare l'anteprima in questione).
3. Per potersi registrare nell'applicazione potrebbero essere necessari determinati tipi di e-mail a seconda del tipo di utente per
   cui si sta tentando di effettuare la registrazione:
         _Utente amministratore: può essere utilizzata una qualsiasi e-mail;
         _Utente professore: è necessaria una e-mail terminante con "@uniroma1.it" oppure con "@dis.uniroma1.it"
                             oppure ancora con "@diag.uniroma1.it";
         _Utente studente: è necessaria una email istituzionale della Sapienza.
