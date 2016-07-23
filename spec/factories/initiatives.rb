FactoryGirl.define do
  factory :initiative do
    title 'Прибрати вулицю'
    main_video 'Video'
    short_description 'На вулиці буде грязно її треба прибрати'
    long_description 'На вулиці буде грязно її треба прибрати в дуже короткий час та за певну плату'
    sum '777'
    term_fundraiser '30'
    term_report '15'
    aasm_state 'fundraiser'
    user_id '2'
  end
end
