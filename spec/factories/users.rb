FactoryBot.define do
  factory :admin_user, class: 'User' do
    name                  { 'Admin' }
    email                 { 'admin@test.com' }
    password              { '123456' }
    password_confirmation { '123456' }
    role                  { 'admin' }
    confirmed_at          { Date.today }
  end
end
