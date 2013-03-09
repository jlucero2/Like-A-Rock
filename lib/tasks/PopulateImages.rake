require 'json/ext'
require 'httparty'
require 'net/http'
require 'open-uri'
require 'curb'

task :populate_images => :environment do
  puts "rake the world!"
  test = Curl.get("mars.jpl.nasa.gov/msl-raw-images/image/image_manifest.json")
  jsonmanifest = JSON.parse(test.body_str)

  arraymanifest = jsonmanifest.to_a

  arraymanifest[4][1].each do |i|
     arrayofsols = i.to_a
     thesolurl =  arrayofsols[2][1]
     solobject = Curl.get(thesolurl)
     jsonsol = JSON.parse(solobject.body_str)
     solarray = jsonsol.to_a
     solarray[3][1].each do |j|
       imagearray = j.to_a
       imageurl = imagearray[14][1]
       solday = imagearray[5][1]
       sampletype = imagearray[22][1]
       if sampletype != "thumbnail"
         #puts sampletype
         #puts imageurl
         #puts solday
         imagecheck = true
         Image.all.each do |k|
           if k.sol.to_i == solday.to_i && k.url == imageurl
             imagecheck = false
             #puts "Image is in database!"
           end
         end
         if imagecheck
           #puts "Adding new image"
           a = Image.new
           a.url = imageurl
           a.sol = solday
           a.save
         end
       end
     end
  end
end

