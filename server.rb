require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth'
require 'omniauth-github'
require 'shotgun'
require 'pry'
require 'pg'
require 'rake'

require_relative 'config/application.rb'
#Requires everything in models folder
Dir['models/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do

  if signed_in?
    @users_characters = User.find(session[:user_id]).characters
  end

  erb :index
end

get '/characters/:character_id' do

  @character = Character.includes(:connections, character_skills: :skill,
    characterqualities: :quality,
    character_weapons: :weapon).where(id: params[:character_id])[0]

  erb :character
end

get '/create' do

  erb :create
end

post '/create' do

  name = params["name"]
  metatype_id = Metatype.find_by(name: params["metatype"]).id
  body = params["body"]
  agility = params["agility"]
  reaction = params["reaction"]
  strength = params["strength"]
  charisma = params["charisma"]
  intuition = params["intuition"]
  logic = params["logic"]
  willpower = params["willpower"]
  edge = params["edge"]
  nuyen = params["nuyen"]
  essence = params["essence"]
  magic = params["magic"]
  initiative_passes = params["initiative-passes"]
  bio = params["bio"]
  user_id = session[:user_id]

  if signed_in?
    new_character = Character.create(name: name,user_id: user_id, metatype_id: metatype_id,
      body: body, agility: agility, reaction: reaction, strength: strength, charisma: charisma, intuition: intuition, logic: logic, willpower: willpower,edge: edge,
      nuyen: nuyen, essence: essence, magic: magic, initiative_passes: initiative_passes,bio: bio)


    flash[:notice] = "You have successfully created a new Character!"
  else
    authenticate!
  end

  redirect '/'
end

post '/delete/:character_id' do
  Character.destroy(params[:character_id])

  redirect "/"
end

post '/addskill/:character_id' do
  character_id = params[:character_id]
  skill_name = params['skillname']
  skill_rating = params['skillrating']
  skill_specialization = params['skillspecialization']
  skill_group = params['skillgroup']
  skill_default = params['skilldefault']

  if Skill.find_by(name: skill_name) != nil
    skill_id = Skill.find_by(name: skill_name).id
    #add catcher to keep from adding redundant  charskills
    CharacterSkill.create(character_id: character_id,skill_id: skill_id,rating: skill_rating, specialization: skill_specialization)
  else
    Skill.create(name: skill_name,default_skill: skill_default,skill_group: skill_group)
    skill_id = Skill.find_by(name: skill_name).id
    CharacterSkill.create(character_id: character_id,skill_id: skill_id,rating: skill_rating, specialization: skill_specialization)
  end

  redirect "/characters/#{character_id}"
end

post '/delete-skill/:character_id' do
  character_skills_of_current_character = Character.find(params[:character_id]).character_skills
  skill_to_delete_id = Skill.find_by(name: params["deletable-skill"]).id

  character_skill_to_destroy = character_skills_of_current_character.find_by(skill_id: skill_to_delete_id)
  character_skill_to_destroy.destroy
  redirect "/characters/#{params[:character_id]}"
end

post '/addquality/:character_id' do
  character_id = params[:character_id]
  quality_name = params['qname']
  quality_description = params['qdescription']
  quality_affect = params['qaffect']
  quality_rating = params['qrating']

  if Quality.find_by(name: quality_name) != nil
    quality_id = Quality.find_by(name: quality_name).id
    #add catcher to keep from adding redundant  charskills
    Characterquality.create(character_id: character_id,quality_id: quality_id,affect_rating: quality_rating)
  else
    Quality.create(name: quality_name,description: quality_description,affected_stat: quality_affect)
    quality_id = Quality.find_by(name: quality_name).id

    Characterquality.create(character_id: character_id,quality_id: quality_id,affect_rating: quality_rating)

  end

  redirect "/characters/#{character_id}"
end

post '/delete-quality/:character_id' do
  character_qualities_of_current_character = Character.find(params[:character_id]).characterqualities
  quality_to_delete_id = Quality.find_by(name: params["deletable-quality"]).id

  character_quality_to_destroy = character_qualities_of_current_character.find_by(quality_id: quality_to_delete_id)

  character_quality_to_destroy.destroy
  redirect "/characters/#{params[:character_id]}"
end

post '/addconnection/:character_id' do

  character_id = params[:character_id]
  connection_name = params['connectionname']
  connection_description = params['connectiondescription']
  connection_loyalty = params['connectionloyalty']
  connection_connection = params['connection']

  Connection.create(character_id: character_id, name: connection_name, description: connection_description,
    loyalty: connection_loyalty,connection: connection_connection)

  redirect "/characters/#{character_id}"
end

post '/delete-connection/:character_id' do

  Connection.find_by(name: params["deletable-connection"]).destroy

  redirect "/characters/#{params[:character_id]}"
end


post "/addweapon/:character_id" do
  character_id = params[:character_id]
  weapon_name = params['weapon-name']
  weapon_damage = params['weapon-damage']
  weapon_damage_type = params['weapon-damage-type']
  weapon_melee = params['melee']=='true' ? true : false
  weapon_rating = params['weapon-rating']
  weapon_ap = params['weapon-ap']
  weapon_concealability = params['weapon-concealability']
  weapon_mode = params['weapon-mode']
  weapon_recoil = params['weapon-recoil']
  weapon_ammo = params['weapon-ammo']
  weapon_legality = params['weapon-legality']
  weapon_description = params['weapon-description']

  if Weapon.find_by(name: weapon_name) != nil
    weapon_id = Weapon.find_by(name: weapon_name).id

    CharacterWeapon.create(character_id: character_id,weapon_id: weapon_id, rating: weapon_rating)
  else
    Weapon.create(name: weapon_name, damage: weapon_damage, damage_type: weapon_damage_type, melee: weapon_melee,
        description: weapon_description, concealability: weapon_concealability, armor_piercing: weapon_ap, mode: weapon_mode,
        recoil: weapon_recoil, ammo: weapon_ammo, legality: weapon_legality)
    binding.pry
    weapon_id = Weapon.find_by(name: weapon_name).id

    CharacterWeapon.create(character_id: character_id,weapon_id: weapon_id)

  end

  redirect "/characters/#{character_id}"
end

post '/delete-weapon/:character_id' do

  character_weapons_of_current_character = Character.find(params[:character_id]).character_weapons
  weapon_to_delete_id = Weapon.find_by(name: params["deletable-weapon"]).id

  character_weapon_to_destroy = character_weapons_of_current_character.find_by(weapon_id: weapon_to_delete_id)

  character_weapon_to_destroy.destroy
  redirect "/characters/#{params[:character_id]}"
end


##############
#OAUTH routes
##############

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end
