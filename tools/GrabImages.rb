require 'json/ext'
require 'httparty'
require 'net/http'
require 'open-uri'
require 'curb'

#test = open("mars.jpl.nasa.gov/msl-raw-images/image/image_manifest.json").read

test = Curl.get("mars.jpl.nasa.gov/msl-raw-images/image/image_manifest.json")

#puts test.body_str

jsonmanifest = JSON.parse(test.body_str)

arraymanifest = jsonmanifest.to_a
arraymanifest[4][1].each do |i|
   arrayofsols = i.to_a
   puts arrayofsols[0]
   thesolurl =  solarray[2][1]
   solobject = Curl.get(thesolurl)
   jsonsol = JSON.parse(solobject.body_str)
   solarray = jsonsol.to_a
   
#   puts i
end
