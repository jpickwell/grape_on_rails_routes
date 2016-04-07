namespace :grape do
  desc 'show API routes'
  task routes: :environment do
    grape_klasses = ObjectSpace.each_object(Class).select { |klass| klass < Grape::API }
    routes = grape_klasses.flat_map(&:routes).uniq { |r| r.path + r.request_method.to_s }
    version_width, verb_width, pattern_width, description_width = widths(routes)

    headers = %w(Version Verb 'URI Pattern' Description)
    version_width = headers[0].length if headers[0].length > version_width
    verb_width = headers[1].length if headers[1].length > verb_width
    pattern_width = headers[2].length if headers[2].length > pattern_width
    description_width = headers[3].length if headers[3].length > description_width

    rows = [headers]
    rows += routes.map do |route|
      [
        route.version.to_s,
        route.request_method.to_s,
        route.path.to_s,
        route.description.to_s
      ]
    end

    rows.each do |version, verb, pattern, description|
      puts "#{ version.ljust(version_width) } #{ verb.ljust(verb_width) } #{ pattern.ljust(pattern_width) } #{ description.ljust(description_width) }"
    end
  end

  def widths(routes)
    [
      routes.map { |r| r.version.try(:length) }.compact.max || 0,
      routes.map { |r| r.request_method.try(:length) }.compact.max || 0,
      routes.map { |r| r.path.try(:length) }.compact.max || 0,
      routes.map { |r| r.description.try(:length) }.compact.max || 0
    ]
  end
end
