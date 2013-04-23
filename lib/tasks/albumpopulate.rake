require 'json/ext'
require 'httparty'
require 'net/http'
require 'open-uri'
require 'curb'

namespace :albums do
task :populateAlbums => :environment do
  puts "rake the world!"
  test = Curl.get("mars.jpl.nasa.gov/msl-raw-images/image/image_manifest.json")
  jsonmanifest = JSON.parse(test.body_str)

  arraymanifest = jsonmanifest.to_a
  
  arraymanifest[4][1].each do |i|
     arrayofsols = i.to_a #makes i into array
     thesolurl =  arrayofsols[2][1]
     lastupdate = arrayofsols[3][1]
     numimages = arrayofsols[1][1]
     solnum = arrayofsols[0][1]
     if numimages.to_i > 0
       solobject = Curl.get(thesolurl)
       jsonsol = JSON.parse(solobject.body_str)
       solarray = jsonsol.to_a
       thumbnailcount = 0
       imagecount = 0
        if Album.find_by_sol(solnum.to_s).nil?
          puts "\n***Album Sol #{solnum} doesn't exist. Creating it...***\n"
          puts "Number of images: #{numimages}" 
          a = Album.new
          a.sol = solnum.to_s
          a.url = thesolurl
          a.num_images = numimages.to_i
          a.save
        end
       solalb = Album.find_by_sol(solnum.to_s)
       #puts "Adding New Images."
       solarray[3][1].each do |j|
         imagearray = j.to_a
         imagehash = Hash[*imagearray.flatten]
         if imagehash['sampleType'] != "thumbnail"
           datetime = imagehash['utc']
           earthday = datetime.split('T', 2).first
           if Album.find_by_earthday(earthday.to_s).nil?
             puts "\n***Earth Day Album #{earthday} doesn't exist. Creating it...***\n" 
             a = Album.new
             a.earthday = earthday.to_s
             a.sol = "Sol #{solnum.to_s}"
             a.url = thesolurl
             a.num_images = 0 #numimages.to_i
             a.save
           end
           earthalb = Album.find_by_earthday(earthday.to_s)
           if solalb.images.find_by_urlList(imagehash["urlList"]).nil? and earthalb.images.find_by_urlList(imagehash["urlList"]).nil?
             n = solalb.images.new
             m = earthalb.images.new
             puts "->Inserting Image in Sol Album Sol #{solnum} and Earthday album #{earthday}..."
             imagehash.each do |info|
               n[info[0]] = info[1].to_s
               m[info[0]] = info[1].to_s
             end
             n.save
             m.save
             imagecount += 1
           elsif solalb.images.find_by_urlList(imagehash["urlList"]).nil?
              n = solalb.images.new
              puts "->Inserting Image in Sol Album #{solnum}..."
              imagehash.each do |info|
                n[info[0]] = info[1].to_s
              end
              n.save
           elsif earthalb.images.find_by_urlList(imagehash["urlList"]).nil?
             m = earthalb.images.new
             puts "->Inserting Image into Earth Day Album #{earthday}..."
             imagehash.each do |info|
                m[info[0]] = info[1].to_s
             end
             m.save
             imagecount += 1
           end
           earthalb = Album.find_by_earthday(earthday.to_s)
           earthalb.num_images += imagecount
           earthalb.save
         else
           thumbnailcount += 1
         end
       end
       puts "Thumbnails: #{thumbnailcount}"
       if numimages.to_i != 0 and thumbnailcount == numimages.to_i
         puts "Destroying album: All images are thumbnails"
         solalb.destroy
       else
         totnum = numimages.to_i - thumbnailcount
         puts "Original imagenum: #{numimages}"
         puts "Number of images added: #{totnum}\n"
         solalb.num_images = numimages.to_i - thumbnailcount
         solalb.save
       end
     end
  end
end 
end
    


