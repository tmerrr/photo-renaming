class RenamePics
	def initialize
		@root = 'C:/Users/Tom/Pictures'
		@iphone = 'C:/Users/Tom/Pictures/iPhone Pics'
		puts "We'll start by selecting the range of pictures you wish to move and rename."
		get_range
	end

	def get_img_num(string_n)
		n = string_n.to_i
		case
			when n < 10 then "IMG_000#{n}.JPG"
			when n < 100 then "IMG_00#{n}.JPG"
			when n < 1000 then "IMG_0#{n}.JPG"
			else "IMG_#{n}.JPG"
		end
	end

	def get_num
		num = gets.chomp
		puts
		if num == num.to_i.to_s
			Dir.chdir(@iphone)
			if File.exists?(get_img_num(num))
				num.to_i
			else
				puts "File #{get_img_num(num)} not found. Please try again."
				get_num
			end
		else
			puts "Please enter a valid number"
			get_num
		end
	end

	def confirm
		answer = gets.chomp
		case answer.downcase
		when 'y' || 'yes' then true
		when 'n' || 'no' then false
		else
			puts "Please answer y / n"
			confirm
		end
	end

	def get_range
		puts "Please enter the IMG number of the first picture."
		@first_pic_num = get_num
		puts "Great! Now please enter the IMG number of the final picture."
		@last_pic_num = get_num
		if @first_pic_num > @last_pic_num
			temp = @last_pic_num
			@last_pic_num = @first_pic_num
			@first_pic_num = temp
		end
		puts "Excellent!  We have selected #{get_img_num(@first_pic_num)} to #{get_img_num(@last_pic_num)} as our batch of pictures."
		puts "Is this correct? [y / n]"
		confirm ? name_batch : get_range
	end

	def name_batch
		Dir.chdir(@root)
		puts "Which folder would you like to save this batch to?"
		batch = gets.chomp.strip
		if batch == ''
			puts "Please enter a valid folder name"
			name_batch
		elsif File.exists?(batch)
			puts "A folder called #{batch} already exists. Would you like to save here? [y / n]"
			confirm ? save(batch) : name_batch
		else
			puts "No folder called #{batch} was found. Would you like to create it now? [y / n]"
			if confirm
				Dir.mkdir(batch)
				save(batch)
			else
				name_batch
			end
		end
	end

	def save(batch_name)
		folder = "#{@root}/#{batch_name}"
		current_pics = Dir["#{folder}/*.JPG"]
		new_num = current_pics.empty? ? 1 : current_pics.size + 1
		puts "Saving pictures to #{folder}..."
		iter = @first_pic_num
		count = 0
		while iter <= @last_pic_num
			picture = get_img_num(iter)
			Dir.chdir(@iphone)
			if File.exists?(picture)
				Dir.chdir(folder)
				File.rename("#{@iphone}/#{picture}", "#{batch_name} #{new_num}.JPG")
				new_num += 1
				iter += 1
				count += 1
			else
				iter += 1
			end
		end
		puts
		puts "Complete! #{count} pictures were moved to #{folder}"
	end
end

RenamePics.new