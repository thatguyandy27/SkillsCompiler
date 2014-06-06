namespace :data do
  @fields= { 'web-development' => ['web-developer'], 
      'web-applications' => ['webapp'],
      'selinium' => ['selenium-fitnesse-bridge', 'selenium-webdriver']
      'software-engineering' => ['sofware', 'software-release', 'software-lifecycle', 'software-architecture'],
      'bitcoin' => ['bitcoind', 'bitcion'],
      'angularjs' => ['angular-ui', 'angular', 'angular.js'],
      'knockout.js' => ['knockout-es5-plugin', 'knockouts.js', 'knockout'],
      'ember.js' => ['ember', 'emberjs', 'ember-data']
  }
  task :clean => :environment do

  end
end