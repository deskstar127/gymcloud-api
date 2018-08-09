namespace :properties do

  desc 'Load new properties'
  task load: :environment do
    puts "\e[32m Start loading properties... \e[0m"
    Services::Seed::PropertyUnit.!
    puts "\e[33m PropertyUnits loaded. \e[0m"
    Services::Seed::GlobalProperty.!
    puts "\e[33m GlobalProperties loaded. \e[0m"
    Services::Seed::GlobalPropertyUnit.!
    puts "\e[33m PropertyUnits for GlobalProperties loaded. \e[0m"
    ::User.pros.each do |user|
      Services::UserBootstrap::PersonalProperties.!(user: user)
      puts "\e[33m PersonalProperties loaded for User##{user.id}. \e[0m"
    end
    puts "\e[32m Done! \e[0m"
  end

end
