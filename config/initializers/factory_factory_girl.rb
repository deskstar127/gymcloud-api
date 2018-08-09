FactoryFactoryGirl.configure do |config|

  config.match \
    (/_?id$/),
    function: 'nil'

  config.match \
    (/descripton|comment/),
    function: 'FFaker::Lorem.paragraph'

  config.match \
    (/value/),
    function: '(1..100).to_a.sample'

end if defined?(FactoryFactoryGirl)
