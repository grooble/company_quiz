require 'csv'

desc "Import questions from csv file"
task :import => [:environment] do

  file = "db/qq1.csv"

  CSV.foreach(file) do |row|
    Question.create(
      :qn => row[0],
      :correct => row[1],
	  :option1 => row[2],
	  :option2 => row[3],
	  :option3 => row[4])
  end

end