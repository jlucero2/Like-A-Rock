require 'json/ext'
require 'httparty'
require 'net/http'
require 'open-uri'
require 'curb'

namespace :albums do
task :populate => :environment do
  puts "rake the world!"
  test = Curl.get("mars.jpl.nasa.gov/msl-raw-images/image/image_manifest.json")
  jsonmanifest = JSON.parse(test.body_str)

  arraymanifest = jsonmanifest.to_a

  arraymanifest[4][1].each do |i|
    arrayofsols = i.to_a #makes i into array
    thesolurl =  arrayofsols[2][1]
    lastupdate = arrayofsols[3][1]
    numimages = arrayofsols[1][1]
    earthday = -1
    solnum = arrayofsols[0][1]
    if numimages.to_i > 0
      #puts "\nNumber of images: #{numimages}"  
      solobject = Curl.get(thesolurl)
      jsonsol = JSON.parse(solobject.body_str)
      solarray = jsonsol.to_a
      #solalb = Album.find_by_sol(solnum.to_s)
      thumbnailcount = 0
      imagecount = 0
      #puts "Adding New Images."
      solarray[3][1].each do |j|
        imagearray = j.to_a
        imagehash = Hash[*imagearray.flatten]
        datetime = imagehash['utc']
        earthday = datetime.split('T', 2).first
        if Album.find_by_earthday(earthday.to_s).nil?
          puts "\nCreating new album for #{earthday} \n"
          #create it if it doesn't
          a = Album.new
          a.earthday = earthday.to_s
          a.sol = solnum.to_s
          a.url = thesolurl
          a.timestamp = "0"
          a.num_images = 0 #numimages.to_i
          a.save
          earthalb = Album.find_by_earthday(earthday.to_s)
          if imagehash['sampleType'] != "thumbnail"
            n = earthalb.images.new
            imagehash.each do |info|
              n[info[0]] = info[1].to_s
            end
            n.save
            imagecount += 1
          else
            thumbnailcount += 1
          end
        else
          earthalb = Album.find_by_earthday(earthday.to_s)
          if imagehash['sampleType'] != "thumbnail"
            if earthalb.images.find_by_urlList(imagehash['urlList']).nil?
              puts "\nUpdating Album Day #{earthday}..."
              n = earthalb.images.new
              imagehash.each do |info|
                n[info[0]] = info[1].to_s
              end
              n.save
              imagecount += 1
            else
              puts "**Image already exists.**"
            end
          else
            thumbnailcount += 1
          end
            earthalb.num_images += imagecount
            earthalb.timestamp = Time.now.getutc 
            earthalb.save
          #check if whole album is thumbnails
        end
      end
      #puts "Thumbnails: #{thumbnailcount}"
      #puts "numimag #{earthalb.num_images}\n"
    end
  end
  Album.destroy_all(:num_images => 0)
  puts "\n**DESTROYING every ALBUM with 0 images...**\n"
end
end
