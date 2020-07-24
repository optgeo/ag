require 'find'

desc 'disolve polygons'
task :dissolve do
  D = 10   # buffer width
  S = 2.5 # simplification tolerance
  Find.find('src') {|path|
    next unless /shp$/.match path
    t = File.basename(path, '.shp')
    cmd = "ogr2ogr -oo ENCODING=CP932 -lco RFC7946=YES -f GeoJSON "
    cmd += "-simplify 5 geojson/#{t}.geojson "
    cmd += "-dialect sqlite -sql "
    cmd += "'SELECT ST_Buffer(ST_Buffer(ST_Union(Geometry), #{D}), -#{D}) "
    cmd += "from \"#{t}\"' "
    cmd += path
    sh cmd
  }
end

desc 'produce tiles'
task :tiles do
  cmd = []
  Find.find('geojson') {|path|
    next unless /\.geojson$/.match path
    next if File.size(path) == 0
    cmd << "(ogr2ogr -f GeoJSONSeq /vsistdout/ #{path} | " +
      "MINZOOM=2 MAXZOOM=10 ruby filter.rb)"
  }
  Find.find('src') {|path|
    next unless /\.shp$/.match path
    #cmd << "(ogr2ogr -oo ENCODING=CP932 -f GeoJSONSeq " +
    #  "/vsistdout/ #{path} | " +
    #  "MINZOOM=11 MAXZOOM=14 ruby filter.rb)"
  }
  cmd = "(#{cmd.join('; ')}) | " +
    "tippecanoe -o tiles.mbtiles -f " +
    "--maximum-zoom=14 --base-zoom=14 --hilbert " +
    "--drop-polygons -as -ad -an -aN -aD -aS "
  sh cmd
  sh "tile-join --force --no-tile-compression " +
    "--output-to-directory=docs/zxy --no-tile-size-limit tiles.mbtiles"
end

desc 'create style.json'
task :style do
  sh "parse-hocon conf/style.conf > docs/style.json"
  sh "gl-style-validate docs/style.json"
end

desc 'host the site locally'
task :host do
  sh "budo -d docs"
end
