test_that("forest_sequestration", {
  # Test that the function runs without errors
  expect_silent(forest_sequestration(tree_density = 300, diameter = 30, height = 10))
  
  # Test that the function returns a numeric value
  expect_is(forest_sequestration(tree_density = 300, diameter = 30, height = 10), "numeric")
  
  # Test that the function returns the correct value
  #expect_equal(forest_sequestration(tree_density = 300, diameter = 30, height = 10), 1413.7167)
  
  # Test that the function returns the correct value when using a different set of inputs
  #expect_equal(forest_sequestration(tree_density = 200, diameter = 20, height = 5), 188.9542)
  
  # Test that the function returns an error when an invalid diameter value is provided
  expect_error(forest_sequestration(tree_density = 300, diameter = -30, height = 10), "Invalid diameter value")
  
  # Test that the function returns an error when an invalid height value is provided
  expect_error(forest_sequestration(tree_density = 300, diameter = 30, height = -10), "Invalid height value")
})


