SimpleCov.use_merging(true)
SimpleCov.start do
#  add_filter 'app/admin'
  add_filter 'features'
  add_filter 'config/initializers'
end