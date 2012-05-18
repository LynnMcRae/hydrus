namespace :hydrus do
  FIXTURE_PIDS = [
    "druid:oo000oo0001", # Item
    "druid:oo000oo0002", # APO
    "druid:oo000oo0003", # Collection
  ]
  
  desc "load hydrus fixtures"
  task :loadfix do
    FIXTURE_PIDS.each { |pid|  
      ENV["pid"] = pid
      Rake::Task['repo:load'].reenable
      Rake::Task['repo:load'].invoke
  }
  end
  
  desc "delete hydrus fixtures"
  task :deletefix do
    FIXTURE_PIDS.each { |pid|  
      ENV["pid"] = pid
      Rake::Task['repo:delete'].reenable
      Rake::Task['repo:delete'].invoke
  }
  end
  
  desc "refresh hydrus fixtures"
  task :refreshfix => [:deletefix, :loadfix]
  
end
