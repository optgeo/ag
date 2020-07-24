require 'json'
while gets
  f = JSON.parse($_.strip)
  f['tippecanoe'] = {
    :minzoom => ENV['MINZOOM'].to_i,
    :maxzoom => ENV['MAXZOOM'].to_i,
    :layer => 'farmland'
  }
  print "\x1e#{JSON.dump(f)}\n"
end
