# frozen_string_literal: true

desc 'Scans repositories For outdated packages'
task scan: :environment do
  repositories = Repository.where(scan: true)
  repositories&.each do |repository|
    access_token = repository.user.access_token
    namespace_path = repository.namespace_path
    DependabotService.new(access_token, namespace_path).run
  end
end
