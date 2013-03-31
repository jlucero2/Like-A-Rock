require 'json/ext'
require 'httparty'
require 'net/http'
require 'open-uri'
require 'curb'

task :update_albums => :environment do
  puts "rake the world!"
  test = Curl.get("mars.jpl.nasa.gov/msl-raw-images/image/image_manifest.json")
  jsonmanifest = JSON.parse(test.body_str)

  arraymanifest = jsonmanifest.to_a
  
  if Album.find_by_sol("Popular Images").nil?
    puts "\n***Creating Album: Popular Images***\n"
    a = Album.new
    a.sol = "Popular Images"
    a.num_images = 0
    a.save
  end

  arraymanifest[4][1].each do |i|
     arrayofsols = i.to_a #makes i into array
     thesolurl =  arrayofsols[2][1]
     lastupdate = arrayofsols[3][1]
     numimages = arrayofsols[1][1]
     solnum = arrayofsols[0][1]
     if Album.find_by_sol(solnum.to_s).nil?
       if numimages.to_i > 0
         puts "\n***Album Sol #{solnum} doesn't exist. Creating it...***\n"
         puts "Number of images: #{numimages}"  
         a = Album.new
         a.sol = solnum.to_s
         a.url = thesolurl
         a.timestamp = lastupdate
         a.num_images = numimages.to_i
         a.save
         solobject = Curl.get(thesolurl)
         jsonsol = JSON.parse(solobject.body_str)
         solarray = jsonsol.to_a
         solalb = Album.find_by_sol(solnum.to_s)
         thumbnailcount = 0
         puts "Adding New Images."
         solarray[3][1].each do |j|
           imagearray = j.to_a
           imagehash = Hash[*imagearray.flatten]
           #sampletype = imagearray[22][1]
           if imagehash['sampleType'] != "thumbnail"
             n = solalb.images.new
             imagehash.each do |info|
               #puts info[0] + ": " + info[1]
               n[info[0]] = info[1].to_s
             end
             #puts "n: #{n.inspect}"
             n.save
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
           puts "Number of images added: #{totnum}\n"
           solalb.num_images = numimages.to_i - thumbnailcount
           solalb.save
         end
       end
     else
       solalb = Album.find_by_sol(solnum.to_s)
       puts "\n***Sol #{solnum}***"
       puts "Timestamp: #{solalb.timestamp}"
       puts "Last Update: #{lastupdate}"
       if solalb.timestamp != lastupdate and numimages.to_i != solalb.num_images      
         puts "Updating Album Sol #{solnum}...\n"
         solobject = Curl.get(thesolurl)
         jsonsol = JSON.parse(solobject.body_str)
         solarray = jsonsol.to_a
         thumbnailcount = 0
         solarray[3][1].each do |j|
           imagearray = j.to_a
           imagehash = Hash[*imagearray.flatten]
           if solalb.images.find_by_urlList(imagehash["urlList"]).nil?
             if imagehash["sampleType"] != "thumbnail"
                n = solalb.images.new
                imagehash.each do |info|
                  #puts info[0] + ": " + info[1]
                  n[info[0]] = info[1].to_s
                end
                puts "New Image: #{n.inspect}"
                n.save
             else
                thumbnailcount += 1
             end
           end
         end
         puts "Thumbnails: #{thumbnailcount}"
         puts "Images: #{numimages}\n"
         if numimages.to_i != 0 and thumbnailcount == numimages.to_i
           puts "**Destroying Album: All images are thumbnails."
           solalb.destroy
         else
           puts "New Images added: #{numimages.to_i - solalb.num_images - thumbnailcount}"
           puts "Timestamp updated: #{solalb.timestamp} -> #{lastupdate}\n"
           solalb.timestamp = lastupdate
           solalb.num_images = numimages.to_i - thumbnailcount
           solalb.save
         end
       else
         puts "***Album up to date.***\n"
       end
     end
  end
end  
      
 

