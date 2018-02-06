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

PwNewAdmin.create!(pw: PwNewAdmin.digest("password"))

PwNewProfessore.create!(pw: PwNewProfessore.digest("password"))

SurveyActivation.create!(activated: true)

SubscribeAndExamActivation.create!(subscribe: true, exam: true)

PretestAndExamQuiz.create!(text1: "text1", ans1_1: "ans1_1", ans1_2: "ans1_2",  ans1_3: "ans1_3", ans1_4: "ans1_4", ans1_ok: 1, text2: "text2", ans2_1: "ans2_1", ans2_2: "ans2_2",  ans2_3: "ans2_3", ans2_4: "ans2_4", ans2_ok: 2, text3: "text3", ans3_1: "ans3_1", ans3_2: "ans3_2",  ans3_3: "ans3_3", ans3_4: "ans3_4", ans3_ok: 3, text4: "text4", ans4_1: "ans4_1", ans4_2: "ans4_2",  ans4_3: "ans4_3", ans4_4: "ans4_4", ans4_ok: 4, text5: "text5", ans5_1: "ans5_1", ans5_2: "ans5_2",  ans5_3: "ans5_3", ans5_4: "ans5_4", ans5_ok: 1, text6: "text6", ans6_1: "ans6_1", ans6_2: "ans6_2",  ans6_3: "ans6_3", ans6_4: "ans6_4", ans6_ok: 2, text7: "text7", ans7_1: "ans7_1", ans7_2: "ans7_2",  ans7_3: "ans7_3", ans7_4: "ans7_4", ans7_ok: 3, text8: "text8", ans8_1: "ans8_1", ans8_2: "ans8_2",  ans8_3: "ans8_3", ans8_4: "ans8_4", ans8_ok: 4, text9: "text9", ans9_1: "ans9_1", ans9_2: "ans9_2",  ans9_3: "ans9_3", ans9_4: "ans9_4", ans9_ok: 1, text10: "text10", ans10_1: "ans10_1", ans10_2: "ans10_2",  ans10_3: "ans10_3", ans10_4: "ans10_4", ans10_ok: 2)
PretestAndExamQuiz.create!(text1: "text1", ans1_1: "ans1_1", ans1_2: "ans1_2",  ans1_3: "ans1_3", ans1_4: "ans1_4", ans1_ok: 1, text2: "text2", ans2_1: "ans2_1", ans2_2: "ans2_2",  ans2_3: "ans2_3", ans2_4: "ans2_4", ans2_ok: 2, text3: "text3", ans3_1: "ans3_1", ans3_2: "ans3_2",  ans3_3: "ans3_3", ans3_4: "ans3_4", ans3_ok: 3, text4: "text4", ans4_1: "ans4_1", ans4_2: "ans4_2",  ans4_3: "ans4_3", ans4_4: "ans4_4", ans4_ok: 4, text5: "text5", ans5_1: "ans5_1", ans5_2: "ans5_2",  ans5_3: "ans5_3", ans5_4: "ans5_4", ans5_ok: 1, text6: "text6", ans6_1: "ans6_1", ans6_2: "ans6_2",  ans6_3: "ans6_3", ans6_4: "ans6_4", ans6_ok: 2, text7: "text7", ans7_1: "ans7_1", ans7_2: "ans7_2",  ans7_3: "ans7_3", ans7_4: "ans7_4", ans7_ok: 3, text8: "text8", ans8_1: "ans8_1", ans8_2: "ans8_2",  ans8_3: "ans8_3", ans8_4: "ans8_4", ans8_ok: 4, text9: "text9", ans9_1: "ans9_1", ans9_2: "ans9_2",  ans9_3: "ans9_3", ans9_4: "ans9_4", ans9_ok: 1, text10: "text10", ans10_1: "ans10_1", ans10_2: "ans10_2",  ans10_3: "ans10_3", ans10_4: "ans10_4", ans10_ok: 2)

UserAdmin.create!(name: "Daniele", surname: "Sinibaldi", email: "daniel46.95@gmail.com", username: "Daniel-01", password: "password", password_confirmation: "password", activated: true, activated_at: Time.zone.now)
UserAdmin.create!(name: "Daniele", surname: "Sinibaldi", email: "daniel46-95@hotmail.it", username: "Daniel-02", password: "password", password_confirmation: "password", activated: true, activated_at: Time.zone.now)
UserAdmin.create!(name: "User", surname: "Example", email: "example@railstutorial.org", username: "EsempioSoprannome-0", password: "password", password_confirmation: "password", activated: true, activated_at: Time.zone.now)

97.times do |n|
    name = Faker::Name.first_name
    surname = Faker::Name.last_name
    email = "example-#{n+1}@railstutorial.org"
    username = "esempiosoprannomeadmin-#{n+1}"
    password = "password"
    UserAdmin.create!(name: name, surname: surname, email: email, username: username, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
end

100.times do |n|
    name = Faker::Name.first_name
    surname = Faker::Name.last_name
    email = "exampleprofessore-#{n+1}@uniroma1.it"
    username = "esempiosoprannomeprofessore-#{n+1}"
    password = "password"
    UserProfessore.create!(name: name, surname: surname, email: email, username: username, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
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
    UserStudente.create!(name: name, surname: surname, email: email, username: username, fiscalCode: fiscalCode, birthDay: birthDay, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
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
    UserStudente.create!(name: name, surname: surname, email: email, username: username, fiscalCode: fiscalCode, birthDay: birthDay, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
end

100.times do |n|
    title = "title-#{n+1}"
    content = "Lorem -#{n+1}- ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis"
    author = UserProfessore.find_by(id: "#{n+1}").username.to_s
    writtenAt = Time.now
    Advice.create!(title: title, content: content, author: author, writtenAt: writtenAt)
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



1000.times do |n|

   id_user =1+rand(100)

   score =-11+1+rand(41)


    History.create!(id_user: id_user,score: score)
end


100.times do |n|

   id_user =n+1
   my_average= -11+1+rand(40) + rand(10)*0.1 + rand(10)*0.01
   ntest=1+rand(100)
   year = 2010 +rand(9)

    TrainingAverage.create!(id_user: id_user,my_average: my_average,ntest: ntest, year: year)
end

50.times do |n|
    id_user= UserStudente.find(n+1).id
    score= -11+1+rand(41)
    year = 2010 +rand(9)
    CompetitionSubscribed.create!(id_user: id_user, score: score, year: year)
end
