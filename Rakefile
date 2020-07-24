require 'find'

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
