test_that("test extra sysreqs", {
  with_dir(pkg, {
    
    for (fun in list(
      add_dockerfile, 
      add_dockerfile_heroku, 
      add_dockerfile_shinyproxy
    )){
      burn_after_reading(
        "Dockerfile", {
          output <- testthat::capture_output(
            fun(pkg = pkg, sysreqs = FALSE, open = FALSE, extra_sysreqs = c("test1","test2"),output = "Dockerfile")
          )
          
          expect_exists("Dockerfile")
          test <- stringr::str_detect(
            output, 
            "Dockerfile created at Dockerfile"
          )
          expect_true(test)
          to_find <-   "RUN apt-get update && apt-get install -y  test1 test2 && rm -rf /var/lib/apt/lists/*"
          expect_true(sum(readLines(con = "Dockerfile") == to_find) == 1)
          
          
          
        }
        
        
        
        
      )
    }
    
  })
})
