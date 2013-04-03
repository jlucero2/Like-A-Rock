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
    earthday = 0
    solnum = arrayofsols[0][1]
    if numimages.to_i > 0
      puts "Number of images: #{numimages}"  
      solobject = Curl.get(thesolurl)
      jsonsol = JSON.parse(solobject.body_str)
      solarray = jsonsol.to_a
      #solalb = Album.find_by_sol(solnum.to_s)
      thumbnailcount = 0
      puts "Adding New Images."
      solarray[3][1].each do |j|
        imagearray = j.to_a
        imagehash = Hash[*imagearray.flatten]
        #sampletype = imagearray[22][1]
        if imagehash['sampleType'] != "thumbnail"
          datetime = imagehash['utc']
          earthday = datetime.split('t', 2).first
          if Album.find_by_earthday(earthday.to_s).nil?
            #create it if it doesn't
            a = Album.new
            a.earthday = earthday.to_s
            a.url = thesolurl
            a.timestamp = lastupdate
            a.num_images = numimages.to_i
            a.save
            earthalb = Album.find_by_earthday(earthday.to_s)
            n = earthalb.images.new
            imagehash.each do |info|
              #puts info[0] + ": " + info[1]
              n[info[0]] = info[1].to_s
            end
            puts "n: #{n.inspect}"
            n.save
          else
            earthalb = Album.find_by_earthday(earthday.to_s)
            if earthalb.timestamp != lastupdate and numimages.to_i != earthalb.num_images
              puts "Updating Album Sol #{solnum}...\n"
              n = earthalb.images.new
              imagehash.each do |info|
                #puts info[0] + ": " + info[1]
                n[info[0]] = info[1].to_s
              end
              puts "New Image: #{n.inspect}"
              n.save
            else
              puts "***Album up to date.***\n"
            end
          end
        else
          thumbnailcount += 1
        end
      end
      puts "Thumbnails: #{thumbnailcount}"
      if numimages.to_i != 0 and thumbnailcount == numimages.to_i
        puts "Destroying album: All images are thumbnails"
        earthalb = Album.find_by_earthday(earthday.to_s)
        earthalb.destroy
      else
        totnum = numimages.to_i - thumbnailcount
        puts "Number of images added: #{totnum}\n"
        earthalb = Album.find_by_earthday(earthday.to_s)
        earthalb.num_images = numimages.to_i - thumbnailcount
        earthalb.save
      end
    end
  end
end
