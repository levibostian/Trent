if github.branch_for_base != "development" && github.pr_author != "levibostian"
  fail "Sorry, wrong branch. Create a PR into the `development` branch instead."
end

if github.branch_for_base == "production" && github.branch_for_head != "development"
  fail "You must merge from the `development` branch into `production`."
end

if github.branch_for_base == "production"
  if !git.diff_for_file("Versionfile")
    fail 'You did not update the Versionfile.'
  end
end