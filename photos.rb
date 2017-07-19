home = 'C:/Users/Tom/Pictures'
iphone = 'C:/Users/Tom/Pictures/iPhone Pics'

def get_img_num string_n
	n = string_n.to_i
	if n < 10
		return IMG_"000#{n}.JPG"
	elsif n < 100
		return "IMG_00#{n}.JPG"
	elsif n < 1000
		return "IMG_0#{n}.JPG"
	else
		return "IMG_#{n}.JPG"
	end
end

puts "We'll start by selecting the range of pictures you wish to move and rename."

while true
	puts "Please enter the IMG number of the first picture."
	first_pic_num = gets.chomp
	puts
	int_check = (first_pic_num.to_i.to_s == first_pic_num)
	if int_check != true
		puts "Not a valid IMG number"
	else
		first_pic = get_img_num first_pic_num
		Dir.chdir iphone
		if File.exists?(first_pic) == false
			puts "Image number #{first_pic} not found."
			puts
		else
			break
		end
	end
end

puts
puts "Great! Next step:"

while true
	puts "Please enter the IMG number of the final picture."
	last_pic_num = gets.chomp
	puts
	
	if last_pic_num.to_i < first_pic_num.to_i
		abort("ERROR: Last IMG number must be less than the first IMG number.")
	end
	
	int_check = (last_pic_num.to_i.to_s == last_pic_num)
	if int_check != true
		puts "Not a valid IMG number"
	else
		last_pic = get_img_num last_pic_num
		Dir.chdir iphone
		if File.exists?(last_pic) == false
			puts "Image number #{last_pic} not found."
		else
			break
		end
	end
end

puts "Excellent!  We have selected #{first_pic} to #{last_pic} as our batch of pictures."
batch = ''
Dir.chdir home

while Dir.exists?(batch) != true
	puts "What shall we call this batch?"
	batch = gets.chomp
	puts
	if Dir.exists?(batch) != true
		puts "No folder called #{batch} was found."
		puts "Would you like to create one now? (Y/N)"
		while true
			confirm = gets.chomp
			puts
			if (confirm.upcase == 'Y') || (confirm.upcase == 'YES')
				Dir.mkdir(batch)
				count = 0
				break
			elsif (confirm.upcase == 'N') || (confirm.upcase == 'NO')
				puts "Folder wasn't created"
				break
			else
				puts "Please answer Y/N"
			end
		end
	else
		puts "Folder called #{batch} already exists."
	end
end

new_folder = "#{home}/#{batch}"
puts "Using destination:  #{new_folder}"

existing_pics = Dir["#{new_folder}/*.JPG"]
if existing_pics.length > 0
	count = existing_pics.length
end

progress = first_pic_num.to_i

while progress <= last_pic_num.to_i
	picture = get_img_num progress
	Dir.chdir iphone
	if File.exists?(picture) == true
		count = count + 1
		locate = "#{iphone}/#{picture}"
		new_name = "#{batch} #{count}.JPG"
		Dir.chdir new_folder
		File.rename locate, new_name
		progress = progress + 1
	else
		progress = progress + 1
	end
end

puts
puts 'Complete!'
puts "#{count} file(s) were moved to #{new_folder}"
