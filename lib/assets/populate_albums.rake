require 'json/ext'
require 'httparty'
require 'net/http'
require 'open-uri'
require 'curb'

task :populate_albums => :environment do
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
     albumcheck = true
     #updatecheck = true
     if numimages.to_i <= 0  
        #Album.all.each do |alb|
         #if alb.sol.to_i == solnum.to_i 
           #albumcheck = false
           #if alb.timestamp == lastupdate
           #  updatecheck = false
          #   break
         #  end
        #   break
       #  end
      # end
     #else
        #updatecheck = false
        albumcheck = false
     end
     if albumcheck
       a = Album.new
       a.sol = solnum
       a.url = thesolurl
       a.timestamp = lastupdate
       a.num_images = numimages
       a.save
       solobject = Curl.get(thesolurl)
       jsonsol = JSON.parse(solobject.body_str)
       solarray = jsonsol.to_a
       solalb = Album.last
       thumbnailcount = 0
       solarray[3][1].each do |j|
         imagearray = j.to_a
         sampletype = imagearray[22][1]
         if sampletype != "thumbnail"
            #puts sampletype
            #puts imageurl
            #puts solday
            #imagecheck = true
            #solalb.images.all.each do |k|
             # if k.url == imageurl
              #  imagecheck = false
               # break
                #puts "Image is in database!"
              #end
            #end
            #if imagecheck
              #puts "Adding new image"
              imageurl = imagearray[14][1]
              solday = imagearray[5][1]
              n = solalb.images.new
              n.url = imageurl 
              n.sol = solday
              n.save
            #end
         else
           thumbnailcount += 1
         end
       end
       if thumbnailcount == numimages.to_i
         solalb.destroy
       end
     end
  end
end  
      
 

