require 'find'

task :dissolve do
  Find.find('src') {|path|
    next unless /shp$/.match path
    t = File.basename(path, '.shp')
    cmd = "ogr2ogr -oo ENCODING=CP932 -lco RFC7946=YES -f GeoJSON "
    cmd += "geojson/#{t}.geojson "
    cmd += "-dialect sqlite -sql 'SELECT ST_Union(Geometry) from "
    cmd += "\"#{t}\"' "
    cmd += path
    sh cmd
  }
end
