# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'codice_fiscale'

def rand_in_range(from, to)
  rand * (to - from) + from
end

def rand_int(from, to)
  rand_in_range(from, to).to_i
end

def primeTreConsonanti(s)
    return "bbb" if s.length == 0
    res=""
    cont=0
    while res.length < 3 && cont < s.length
        lettera= s[cont].downcase
        if lettera=="b" || lettera=="c" || lettera=="d" || lettera=="f" || lettera=="g" || lettera=="h" || lettera=="j" || lettera=="k" || lettera=="l" || lettera=="m" || lettera=="n" || lettera=="p" || lettera=="q" || lettera=="r" || lettera=="s" || lettera=="t" || lettera=="v" || lettera=="w" || lettera=="x" || lettera=="y" || lettera=="z"
            res+= lettera
        end
        cont+=1
    end
    return "bbb" if res.length == 0
    return res+"bb" if res.length == 1
    return res+"b" if res.length == 2
    res
end

def CFgenerate(nome, cognome, cfintermedio)
    res= primeTreConsonanti(cognome) + primeTreConsonanti(nome) + cfintermedio[6,16]
    res.downcase
end

UserAdmin.create!(name: "Daniele", surname: "Sinibaldi", email: "daniel46.95@gmail.com", username: "Daniel-01", password: "password", password_confirmation: "password")
UserAdmin.create!(name: "Daniele", surname: "Sinibaldi", email: "daniel46-95@hotmail.it", username: "Daniel-02", password: "password", password_confirmation: "password")
UserAdmin.create!(name: "User", surname: "Example", email: "example@railstutorial.org", username: "EsempioSoprannome-0", password: "password", password_confirmation: "password")

97.times do |n|
    name = Faker::Name.first_name
    surname = Faker::Name.last_name
    email = "example-#{n+1}@railstutorial.org"
    username = "esempiosoprannomeadmin-#{n+1}"
    password = "password"
    UserAdmin.create!(name: name, surname: surname, email: email, username: username, password: password, password_confirmation: password)
end

100.times do |n|
    name = Faker::Name.first_name
    surname = Faker::Name.last_name
    email = "exampleprofessore-#{n+1}@uniroma1.it"
    username = "esempiosoprannomeprofessore-#{n+1}"
    password = "password"
    UserProfessore.create!(name: name, surname: surname, email: email, username: username, password: password, password_confirmation: password)
end

50.times do |n|
    name = Faker::Name.first_name
    surname = Faker::Name.last_name
    email = "examplestudente-#{n+1}-male.1657294@studenti.uniroma1.it"
    username = "esempiosoprannomestudente-#{n+1}-male"
    birthDay = Date.new(rand_int(1990, 2000), rand_int(1, 12), rand_int(1, 28))
    fiscalCode_intermedio = CodiceFiscale.calculate( :name => name, :surname => surname, :gender => :male, :birthdate => birthDay, :province_code => 'RM', :city_name => 'Roma' )
    fiscalCode= CFgenerate(name, surname, fiscalCode_intermedio)
    password = "password"
    UserStudente.create!(name: name, surname: surname, email: email, username: username, fiscalCode: fiscalCode, birthDay: birthDay, password: password, password_confirmation: password)
end

50.times do |n|
    name = Faker::Name.first_name
    surname = Faker::Name.last_name
    email = "examplestudente-#{n+1}-female.1657294@studenti.uniroma1.it"
    username = "esempiosoprannomestudente-#{n+1}-female"
    birthDay = Date.new(rand_int(1990, 2000), rand_int(1, 12), rand_int(1, 28))
    fiscalCode_intermedio = CodiceFiscale.calculate( :name => name, :surname => surname, :gender => :female, :birthdate => birthDay, :province_code => 'RM', :city_name => 'Roma' )
    fiscalCode= CFgenerate(name, surname, fiscalCode_intermedio)
    password = "password"
    UserStudente.create!(name: name, surname: surname, email: email, username: username, fiscalCode: fiscalCode, birthDay: birthDay, password: password, password_confirmation: password)
end

50.times do |n|

    text =('a'..'z').to_a.shuffle[0..7].join
    ans1 =('a'..'z').to_a.shuffle[0..7].join
    ans2 =('a'..'z').to_a.shuffle[0..7].join
    ans3 =('a'..'z').to_a.shuffle[0..7].join
    ans4 =('a'..'z').to_a.shuffle[0..7].join

    ans_ok=1+rand(4)
    Question.create!(text: text, ans1: ans1, ans2: ans2,  ans3: ans3, ans4: ans4, ans_ok: ans_ok)
end

50.times do |n|

    q1 =1+rand(n)
    q2 =1+rand(n)
    q3 =1+rand(n)
    q4 =1+rand(n)
    q5 =1+rand(n)
    q6 =1+rand(n)
    q7 =1+rand(n)
    q8 =1+rand(n)
    q9 =1+rand(n)
    q10 =1+rand(n)


    Quiz.create!(q1: q1,q2: q2,q3: q3,q4: q4,q5: q5,q6: q6,q7: q7,q8: q8,q9: q9,q10: q10)
end

50.times do |n|

   id_user =1+rand(97)
   id_quiz =1+rand(n)
   score =1+rand(30)


    History.create!(id_user: id_user,id_quiz: id_quiz,score: score)
end
