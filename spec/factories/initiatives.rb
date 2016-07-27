FactoryGirl.define do
  factory :initiative do
    title 'Прибрати вулицю'
    main_video 'Video'
    short_description 'На вулиці буде грязно її треба прибрати'
    long_description 'На вулиці буде грязно її треба прибрати в дуже короткий час та за певну плату'
    sum '777'
    term_fundraiser '30'
    term_report '15'
    main_picture { File.open('spec/support/photo.jpg') }
    aasm_state 'fundraiser'
    finished_day '30'
    user_id '1'
  end
end
